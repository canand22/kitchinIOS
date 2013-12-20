#!/bin/sh -e

# Created by Yuri Govorushchenko on 7/5/11.
# Copyright 2010 nix. All rights reserved.

# Script loads variables specified in _last_revision.sh and _last_build_vars.sh and checks that all specified files and dirs exist.

#############

function checkFileExists {
    if [ ! -f "$1" ]; then
        echo "error: file '$1' must exist ($2)." 1>&2
        exit 1
    fi
}

function checkDirExists {	
    if [ ! -d "$1" ]; then
        echo "error: directory '$1' must exist ($2)." 1>&2
        exit 1
    fi
}

function checkAppOrIPAProductExists {
    if [ ! -d "${APP_PRODUCT}" ]; then
        if [ ! -f "${IPA_PRODUCT}" ]; then
            echo "error: app product directory '${APP_PRODUCT}' or ipa file '${IPA_PRODUCT}' must exist." 1>&2
            exit 1
        fi
    fi
}

#############

function checkWorkingCopyIsClean {
    if [ ${WORKING_COPY_IS_CLEAN} -eq 1 ]; then
        echo "Working copy is clean. Continuing..."
    else
        echo "error: working copy must not have local modifications." 1>&2
        echo "You must add following files and folders to .gitignore:"
        echo "$(git status --porcelain)"
        exit 1
    fi    
}

#############

# set some default values to vars to catch errors quickly:
                    REVISION="unknown_revision"
                     PROJECT="unknown_project"
          BUILT_PRODUCTS_DIR="unknown_build_prodcuts_dir"
          OBJECTS_NORMAL_DIR="unknown_objects_normal_dir"
             EXECUTABLE_NAME="unknown_executable_name"
                 APP_PRODUCT="unknown_app_product"
                 IPA_PRODUCT="unknown_ipa_product"
                    APP_DSYM="unknown_app_dsym"
          APP_INFOPLIST_FILE="unknown_app_infoplist_file"
            EMBEDDED_PROFILE="unknown_embedded_profile"
                 TARGET_NAME="unknown_target_name"
               CONFIGURATION="unknown_configuration"
                    SDK_NAME="unknown_sdk_name"
               IPA_BUNDLE_ID="unknwon_ipa_bundle_id"
          RESIGNED_BUNDLE_ID="unknown_resigned_bundle_id"
        RESIGNED_BUNDLE_NAME="unknown_resigned_bundle_name"
  RESIGNED_ENTITLEMENTS_PATH="unknown_resigned_entitlements_path"
         NAME_FOR_DEPLOYMENT="unknown_name_for_deployment"

# these files should be already generated
LAST_REVISION_FILE="_last_revision.sh"
LAST_BUILD_VARS_FILE="_last_build_vars.sh"

checkFileExists ${LAST_REVISION_FILE}
checkFileExists ${LAST_BUILD_VARS_FILE}

source ${LAST_REVISION_FILE}
source ${LAST_BUILD_VARS_FILE}

echo "REVISION = ${REVISION}"
echo "MONOTONIC_REVISION = ${MONOTONIC_REVISION}"
echo "PROJECT = ${PROJECT}"
echo "BUILT_PRODUCTS_DIR = ${BUILT_PRODUCTS_DIR}"
echo "OBJECTS_NORMAL_DIR = ${OBJECTS_NORMAL_DIR}"
echo "EXECUTABLE_NAME = ${EXECUTABLE_NAME}"
echo "APP_PRODUCT = ${APP_PRODUCT}"
echo "IPA_PRODUCT = ${IPA_PRODUCT}"
echo "APP_DSYM = ${APP_DSYM}"
echo "APP_INFOPLIST_FILE = ${APP_INFOPLIST_FILE}"
echo "EMBEDDED_PROFILE = ${EMBEDDED_PROFILE}"
echo "TARGET_NAME = ${TARGET_NAME}"
echo "CONFIGURATION = ${CONFIGURATION}"
echo "SDK_NAME = ${SDK_NAME}"
echo "IPA_BUNDLE_ID = ${IPA_BUNDLE_ID}"
echo "RESIGNED_BUNDLE_ID = ${RESIGNED_BUNDLE_ID}"
echo "RESIGNED_BUNDLE_NAME = ${RESIGNED_BUNDLE_NAME}"
echo "RESIGNED_ENTITLEMENTS_PATH = ${RESIGNED_ENTITLEMENTS_PATH}"
echo "NAME_FOR_DEPLOYMENT = ${NAME_FOR_DEPLOYMENT}"

checkDirExists "${BUILT_PRODUCTS_DIR}" "build products dir"
checkAppOrIPAProductExists
checkDirExists "${APP_DSYM}" "app dsym"
checkFileExists "${APP_INFOPLIST_FILE}" "app info plist"

if [ -f "${EMBEDDED_PROFILE}" ]; then
    # get name of embedded provisioning profile; see http://stackoverflow.com/questions/2327257/name-of-provisioning-profile-used-to-sign-an-iphone-app
    EMBEDDED_PROFILE_NAME=$(strings "${EMBEDDED_PROFILE}" | grep -A1 '<key>Name</key>' | tail -n1 | awk -F'<string>' '{print $2}' | awk -F'</string>' '{print $1}')
else
    EMBEDDED_PROFILE_NAME="SIMULATOR"
fi

echo "EMBEDDED_PROFILE_NAME = ${EMBEDDED_PROFILE_NAME}"

CURRENT_APP_VERSION="`/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' \
    "${APP_INFOPLIST_FILE}"`"
CURRENT_BUILD_VERSION="`/usr/libexec/PlistBuddy -c 'Print CFBundleVersion' \
    "${APP_INFOPLIST_FILE}"`"

echo "CURRENT_APP_VERSION = ${CURRENT_APP_VERSION}"
echo "CURRENT_BUILD_VERSION = ${CURRENT_BUILD_VERSION}"