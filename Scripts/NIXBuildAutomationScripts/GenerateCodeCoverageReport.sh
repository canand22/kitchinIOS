#!/bin/sh -e

# Created by Artem on 06/29/12.
# Copyright 2012 nix. All rights reserved.

# Script generates code coverage report for Cobertura Jenkins plugin. Call it after running tests.
# Tests target should be setup for generating GCOV data.

if [[ $# < 2 ]]
then 
    echo "usage: $0 EXCLUDE_PATTERN OUTPUT_FILENAME"
    exit 1
fi

# load variables
exclude="$1"
output="$2"

currentScriptDir=$(cd "$(dirname "$0")"; pwd)
source "${currentScriptDir}/LoadBuildEnvVars.sh"

"${currentScriptDir}/Utils/gcovr" -r "$(PWD)" --object-directory="${OBJECTS_NORMAL_DIR}/i386" --exclude "${exclude}" --xml > "${output}"