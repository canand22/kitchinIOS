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

taggerDirectory=$(cd "$(dirname "$0")"; pwd)
scriptDirectory=${taggerDirectory%/*}
projectDirectory=${scriptDirectory%/*}
projectDirectory=${projectDirectory%/*}

# load build vars
source "${scriptDirectory}/LoadBuildEnvVars.sh"

if [ "${MONOTONIC_REVISION}" == "undefined" ]; then
    revisionNumber=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${INFOPLIST_FILE}"`
else
    revisionNumber=${MONOTONIC_REVISION}
fi

version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "${INFOPLIST_FILE}"`

style="TwoLine"
if [ "$short_version" == "1" ];
then
    style="OneLine"
fi

maskPath="${taggerDirectory}/masks/${style}Mask.png"

utility="${taggerDirectory}"

utility=$(printf '%q' "${taggerDirectory}")

iconsDirectory="$projectDirectory/$1"
plistPath="$projectDirectory/${INFOPLIST_FILE}"


DIR=$( pwd )
cd "Scripts"
cd "NixBuildAutomationScripts"
cd "XcodeIconTagger"
DIR=$( pwd )

"./IconTagger" --shortVersion=${version} --buildNumber=${revisionNumber} --style=${style} --maskPath="${maskPath}" --plist="${plistPath}" --sourceIconsPath="${iconsDirectory}" --destinationIconsPath="${APP_PRODUCT}"


