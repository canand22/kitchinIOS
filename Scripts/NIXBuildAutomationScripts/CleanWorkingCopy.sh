#!/bin/sh -e

# Created by Yuri Govorushchenko on 22/05/2013.
# Copyright 2013 nix. All rights reserved.

# Script reverts all changes in working copy and removes unversioned files.

currentScriptDir=$(cd "$(dirname "$0")"; pwd)
SCM_TYPE=$("${currentScriptDir}/DetectSCM.sh")

# Subversion
if [[ "${SCM_TYPE}" = "svn" ]]; then
    echo "SVN working copy detected, cleaning..."

    # revert all changes
    svn revert --depth=infinity "./"

    # revert all changes in external directories
    for i in $(svn status | grep ^Performing | cut -d\' -f 2)
    do
        svn revert -R $i
    done

    # wipe out unversioned files
    perl "${currentScriptDir}/svn-clean.pl" "./"

# git
elif [[ "${SCM_TYPE}" = "git" ]]; then
    echo "GIT working copy detected, cleaning..."

    # revert all changes
    git reset --hard

    # wipe out unversioned files
    git clean -fdx

# mercurial
elif [[ "${SCM_TYPE}" = "mercurial" ]]; then
echo "Mercurial working copy detected, cleaning..."

# revert all changes
hg revert --all

# wipe out unversioned files
hg --config extensions.purge= clean --all

# undefined SCM
else
    echo "error: script must be run from working copy" 1>&2
    exit 1
fi