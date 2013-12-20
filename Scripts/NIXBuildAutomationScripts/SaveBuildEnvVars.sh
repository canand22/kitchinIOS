#!/bin/sh -e

# Created by Yuri Govorushchenko on 2/21/11.
# Copyright 2011 nix. All rights reserved.

# Script which saves specific environment vars into _last_build_vars.sh. It will be used later by other build scripts.

echo "#!/bin/sh
### AUTOGENERATED BY SaveBuildEnvVars.sh; DO NOT EDIT ###
            PROJECT=\"${PROJECT}\"
 BUILT_PRODUCTS_DIR=\"${BUILT_PRODUCTS_DIR}\"
 OBJECTS_NORMAL_DIR=\"${OBJECT_FILE_DIR_normal}\"
    EXECUTABLE_NAME=\"${EXECUTABLE_NAME}\"
        APP_PRODUCT=\"${BUILT_PRODUCTS_DIR}/${EXECUTABLE_NAME}.app\"
           APP_DSYM=\"${BUILT_PRODUCTS_DIR}/${EXECUTABLE_NAME}.app.dSYM\"
 APP_INFOPLIST_FILE=\"${BUILT_PRODUCTS_DIR}/${INFOPLIST_PATH}\"
   EMBEDDED_PROFILE=\"${BUILT_PRODUCTS_DIR}/${EXECUTABLE_NAME}.app/${EMBEDDED_PROFILE_NAME}\"
        TARGET_NAME=\"${TARGET_NAME}\"
      CONFIGURATION=\"${CONFIGURATION}\"
           SDK_NAME=\"${SDK_NAME}\"
 RESIGNED_BUNDLE_ID=\"${RESIGNED_BUNDLE_ID}\"
RESIGNED_BUNDLE_NAME=\"${RESIGNED_BUNDLE_NAME}\"
RESIGNED_ENTITLEMENTS_PATH=\"${RESIGNED_ENTITLEMENTS_PATH}\"" > _last_build_vars.sh
       
       
