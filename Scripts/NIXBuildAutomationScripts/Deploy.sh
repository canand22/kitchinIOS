#!/bin/sh -e

# Created by Yaroslav on 10/21/11.
# Copyright 2011 nix. All rights reserved.

# Script uploads IPA product. Creates appropriate subdirectories.

if [[ $# < 4 ]]; then
    echo "usage: $0 DEPLOY_HOST DEPLOY_DIR DEPLOY_USER DEPLOY_PASSWORD"
    exit 1
fi

function zipDSYM {
    cd "${BUILT_PRODUCTS_DIR}"
    zip -r "$1" "${EXECUTABLE_NAME}.app.dSYM"
    cd "${currentScriptDir}"
}

DEPLOY_HOST=$1
DEPLOY_DIR=$2
DEPLOY_USER=$3
DEPLOY_PASS=$4

# load variables
currentScriptDir=$(cd "$(dirname "$0")"; pwd)
source "${currentScriptDir}/LoadBuildEnvVars.sh"

checkWorkingCopyIsClean
checkDirExists "${APP_DSYM}"

if [[ ! -f "${IPA_PRODUCT}" ]]; then
    echo "error: Nothing to upload. Generate ipa first."
    exit 1
fi

LOCAL_PATH_TO_APP="/tmp/${IPA_BUNDLE_ID}"
LOCAL_PATH_TO_BUILD="${LOCAL_PATH_TO_APP}/v.${CURRENT_APP_VERSION}_${CURRENT_BUILD_VERSION}"
rm -rf "${LOCAL_PATH_TO_BUILD}" | true # cleanup in case of previous releases
mkdir -p "${LOCAL_PATH_TO_BUILD}"

chmod -R 775 "${LOCAL_PATH_TO_APP}"

if [[ -f "${IPA_PRODUCT}" ]]; then
    CONFIGURATION_FULL_PATH="${LOCAL_PATH_TO_BUILD}/${NAME_FOR_DEPLOYMENT}"
    mkdir "${CONFIGURATION_FULL_PATH}"
    cp "${IPA_PRODUCT}" "${CONFIGURATION_FULL_PATH}/${EXECUTABLE_NAME}.ipa"

    zipDSYM "${CONFIGURATION_FULL_PATH}/${EXECUTABLE_NAME}.app.dSYM.zip"
fi

echo "Uploading .ipa, .plist and .dSYM to ${PATH_TO_BUILD}"

expect -d <<END_OF_SCRIPT
set timeout -1
spawn scp -r "${LOCAL_PATH_TO_APP}" "${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_DIR}"
expect {
    "Password:" {
        send "${DEPLOY_PASS}\r"
    }
    "yes/no)?" {
        send "yes\r"
    }
    eof {
        exit
    } 
    -re . {
        exp_continue
    }
}
expect eof
exit
END_OF_SCRIPT

rm -rf "${LOCAL_PATH_TO_APP}"