#!/bin/bash

if [ $CONFIGURATION == "Release" ];then
    echo "Configuration is Release; Skipping..."
    exit 0
fi

if [[ $# < 1 ]]; then
    echo "usage: $0 ICONS_PATH [SHORT_VERSION:bool]"
    exit 1
fi


if [[ $# == 2 ]]; then
    echo "Draw short version"
    short_version=$2
else
    short_version=0
fi

currentScriptDir=$(cd "$(dirname "$0")"; pwd)
currentScriptDir=${currentScriptDir%/*}

# load build vars
source "${currentScriptDir}/LoadBuildEnvVars.sh"

if [ "${MONOTONIC_REVISION}" == "undefined" ]; then
    revisionNumber=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${INFOPLIST_FILE}"`
else
    revisionNumber=${MONOTONIC_REVISION}
fi

version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "${INFOPLIST_FILE}"`

if [ "$short_version" == "1" ];
then
    version=""
    suffix="OneLine"
fi

iconsDirectory=`cd $1 && pwd`
icons=(`/usr/libexec/PlistBuddy -c "Print CFBundleIconFiles" -c "Print CFBundleIconFile" -c "Print :CFBundleIcons:CFBundlePrimaryIcon:CFBundleIconFiles" "${INFOPLIST_FILE}" | grep png | tr -d '\n'`)

taggerDirectory=`dirname $0`
taggerPlist="tagImage.workflow/Contents/document.wflow"
tagsSubfolder="tagFiles"
paramsPath=":actions:0:action:ActionParameters"
iconsCount=${#icons[*]}

cd $taggerDirectory

for (( i=0; i<iconsCount; i++ ))
do
    src_icon="${iconsDirectory}/${icons[$i]}"
    dst_icon="$APP_PRODUCT/${icons[$i]}"

echo "$src_icon"
echo "$dst_icon"

    if [ -f $icon ]; then
        height=`sips -g pixelHeight "$src_icon" | tail -n 1 | sed "s/ *pixelHeight: */ /"`
        width=`sips -g pixelWidth "$src_icon" | tail -n 1 | sed "s/ *pixelWidth: */ /"`

        if (( $height == $width )); then
            renderSize=$(( $width * 10 )) # for some reason it looks much better when rendering canvas are bigger than an icon
            renderSize=$(( $renderSize + $width%2 )) # rendering canvas for odd sized images should also be odd

            /usr/libexec/PlistBuddy -c "Set $paramsPath:renderPixelsHigh $renderSize" -c "Set $paramsPath:renderPixelsWide $renderSize" $taggerPlist

            if( [[ "$src_icon" == *@2x* ]]); then
                resolution_suffix="@2x"
            fi

            automator -D text=${version}$'\n'${revisionNumber} -D image="$src_icon" -i "${tagsSubfolder}/tagImage${suffix}${resolution_suffix}.qtz" tagImage.workflow > /dev/null

            sips --cropToHeightWidth $height $width "${tagsSubfolder}/tagImage${suffix}${resolution_suffix}.png" > /dev/null
            mv "${tagsSubfolder}/tagImage${suffix}${resolution_suffix}.png" "$dst_icon"
        fi
    fi
done