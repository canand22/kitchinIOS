#!/bin/sh -e

if $(svn info &>/dev/null); then
    echo svn
elif $(git status &>/dev/null); then
    echo git
elif $(hg status &>/dev/null); then
    echo mercurial
else
    echo undefined
fi