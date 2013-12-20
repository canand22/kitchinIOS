#!/bin/sh -e

# Created by Yuri Govorushchenko on 11/15/10.
# Copyright 2010 nix. All rights reserved.

# Script creates SVN/git tag
# Note that the SVN source code snapshot will be taken from the repository, not the working copy

if [[ $# < 2 ]]; then
    echo "usage: $0 USERNAME PASSWORD (specify empty username and password in order to indicate that script must use default credentials)"
    exit 1
fi

# load variables
username=$1
password=$2

USE_DEFAULT_CREDENTIALS=0
if [ "${username}" == "" -a "${password}" == "" ]; then
    echo "--- Username and password are not specified, using default SCM credentials"
    USE_DEFAULT_CREDENTIALS=1
fi

currentScriptDir=$(cd "$(dirname "$0")"; pwd)
source "${currentScriptDir}/LoadBuildEnvVars.sh"

# make sure developer tags the same source snapshot as in the working copy
checkWorkingCopyIsClean

TAG_NAME="${PROJECT}-${CURRENT_APP_VERSION}b${CURRENT_BUILD_VERSION}"

SCM_TYPE=$("${currentScriptDir}/DetectSCM.sh")

# Subversion
if [[ "${SCM_TYPE}" = "svn" ]]; then
    SVN_URL="$(svn info | grep '^URL:' | sed -e 's/^URL: //')"
    SVN_ROOT_URL="$(svn info | grep '^URL:' | sed -e 's/^URL: //' | (sed -e 's/\/branches\/.*//' | sed -e 's/\/trunk\/.*//'))"
    TAG_DIR="${SVN_ROOT_URL}/tags/${TAG_NAME}"

    echo "--- Check if tag exists at '${TAG_DIR}'"

    if [ ${USE_DEFAULT_CREDENTIALS} == 0 ]; then
        TAG_CONTENTS=$(svn list "${TAG_DIR}" --username="${username}" --password="${password}" 2>/dev/null || true)
    else
        TAG_CONTENTS=$(svn list "${TAG_DIR}" 2>/dev/null || true)
    fi

    if [ "${TAG_CONTENTS}" == "" ]; then
        echo "--- Make tag at '${TAG_DIR}'"

        if [ ${USE_DEFAULT_CREDENTIALS} == 0 ]; then
            perl "${currentScriptDir}/svncopy.pl" --revision "${REVISION}" --tag --verbose "${SVN_URL}" "${TAG_DIR}" --username="${username}" --password="${password}"
        else
            perl "${currentScriptDir}/svncopy.pl" --revision "${REVISION}" --tag --verbose "${SVN_URL}" "${TAG_DIR}"
        fi

        echo "--- Tag from branch '${SVN_URL}' was created at '${TAG_DIR}'"
    else
        echo "--- Tag from branch '${SVN_URL}' already exists at '${TAG_DIR}'"
    fi

# git
elif [[ "${SCM_TYPE}" = "git" ]]; then
    GIT_ORIGINAL_REMOTE_URL="$(git remote -v | head -n1 | sed 's/.*http/http/; s/ .*//')"
    GIT_ROOT_URL="$(echo $GIT_ORIGINAL_REMOTE_URL | sed 's/.*\/\///; s/ .*//')"

    if [ ${USE_DEFAULT_CREDENTIALS} == 0 ]; then
        # set remote url credentials
        git config remote.origin.url https://${username}:${password}@${GIT_ROOT_URL}

        # original username and password must be restored
        trap 'git config remote.origin.url "${GIT_ORIGINAL_REMOTE_URL}"' EXIT
    fi

    BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
    PROJECT_TAGS="$(git ls-remote --tags)"

    if [[ "${PROJECT_TAGS}" != *"${TAG_NAME}"* ]]; then
        git tag -a ${TAG_NAME} "${REVISION}" -m 'create tag ${TAG_NAME}'
        git push --tags

        echo "--- Tag '${TAG_NAME}' from branch '${BRANCH_NAME}' with revision '${REVISION}' was created"
    else
        echo "--- Tag '${TAG_NAME}' from branch '${BRANCH_NAME}' with revision '${REVISION}' already exists"
    fi

# mercurial
elif [[ "${SCM_TYPE}" = "mercurial" ]]; then
    echo  "make tag doesn't work for mercurial"

else
    echo "error: tag was not created, because script must be run from a working copy" 1>&2
    exit 1
fi