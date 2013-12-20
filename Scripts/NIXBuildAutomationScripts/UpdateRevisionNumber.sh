#!/bin/sh -e

# Created by Yuri Govorushchenko on 15-oct-2012.
# Copyright 2012 nix. All rights reserved.

# Updates revision number in processed info plist (i.e. doesn't change working copy)

currentScriptDir=$(cd "$(dirname "$0")"; pwd)
source "${currentScriptDir}/LoadBuildEnvVars.sh"

/usr/libexec/PlistBuddy -c "Set RevisionNumber ${REVISION}" "${APP_INFOPLIST_FILE}"