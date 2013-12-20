#!/usr/bin/python

# SVNExternalsValidator.py
# NIXObjCLint
#
# Created by Egor Zubkov on 24/1/13.
# Copyright 2013 nix. All rights reserved.

import os
import commands
import fnmatch

class SVNExternalsValidator(object):
    """
    Validates that svn:externals paths should not be defined in subdirectories
    """

    def validate_externals(self, source_path):
        folders_with_defined_externals = []

        for root_folder, sub_folders, files in os.walk(source_path):
            for sub_folder in sub_folders:
                folder_path = os.path.join(root_folder, sub_folder)

                if not fnmatch.fnmatch(folder_path, '*/.svn*'):
                    command = "svn propget svn:externals '%s'" % folder_path
                    status, output = commands.getstatusoutput(command)

                    if status == 0 and output != '':
                        folders_with_defined_externals.append(folder_path)

        return folders_with_defined_externals