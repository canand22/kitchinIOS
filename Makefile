# set these vars if you have multiple projects in the root directory:
PROJECT_TO_BUILD :=
PROJECT_TARGET_TO_BUILD := Application
PROJECT_TARGET_TO_TEST := Tests

# OR set these vars if you want to build the workspace instead of the project:
WORKSPACE_TO_BUILD :=
WORKSPACE_SCHEME_TO_BUILD :=
WORKSPACE_SCHEME_TO_TEST :=

# for osx projects sdk should be macosx10.8 or macosx10.7
SDK           := iphoneos
SDK_FOR_TESTS := iphonesimulator

EXCLUDE_PATTERN_FOR_CODE_COVERAGE := .*/Vendor/.*|.*/Tests/.*
EXCLUDE_PATTERN_FOR_CODE_DUPLICATION := **/Vendor|**/Scripts

# you shouldn't touch these variables, because they will be defined on the CI server:
# DEPLOY_HOST := 
# DEPLOY_PATH :=
# DEPLOY_USERNAME :=
# DEPLOY_PASSWORD :=

# set these var if you want to add build number on icon
ICONS_PATH := Resources/Icons

BUILD_SCRIPTS_PATH := ./Scripts/NIXBuildAutomationScripts/

include ${BUILD_SCRIPTS_PATH}NIXMakefile
