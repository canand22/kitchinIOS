#!/bin/sh -e

# Script generates code duplication report for Violations or DRY Jenkins plugins.

if [[ $# < 2 ]]
then 
    echo "usage: $0 EXCLUDE_PATTERN OUTPUT_FILENAME"
    exit 1
fi

# load variables
patterns="$1"
output="$2"
excludes=""

for pattern in $(echo ${patterns} | tr "|" "\n")
do
    excludes="${excludes} -excludes=/${pattern}"
done

currentScriptDir="$(dirname "$0")"
source "${currentScriptDir}/LoadBuildEnvVars.sh"

java -jar "${currentScriptDir}/Utils/simian-2.3.33.jar" "**/*.m" "**/*.h" ${excludes} -threshold=5 -failOnDuplication- -formatter=xml:${output}