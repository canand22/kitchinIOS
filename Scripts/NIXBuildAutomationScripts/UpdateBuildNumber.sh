#!/bin/sh -e

# Created by Artem on 06/03/12.
# Copyright 2012 nix. All rights reserved.

# Updates build number in processed info plist (i.e. doesn't change working copy)

currentScriptDir=$(cd "$(dirname "$0")"; pwd)
source "${currentScriptDir}/LoadBuildEnvVars.sh"

/usr/libexec/PlistBuddy -c "Set CFBundleVersion ${MONOTONIC_REVISION}" "${APP_INFOPLIST_FILE}"