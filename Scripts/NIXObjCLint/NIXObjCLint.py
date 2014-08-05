#!/usr/bin/python

# NIXObjCLint.py
# NIXObjCLint
#
# Created by Egor Zubkov on 10/02/12.
# Copyright 2012 nix. All rights reserved.

import os
import sys
import optparse
import commands
import fnmatch

def main():
    parser = optparse.OptionParser(description='Script validates coding style of files with Objective-C file extensions, prints warnings with format to highlight them in Xcode', prog='NIXObjCLint')

    parser.add_option("-s", "--source",         dest="source_path",                  help="full path to directory with files which should be verified",                                                  metavar="SOURCE-PATH")
    parser.add_option("-t", "--template_file",  dest="template_file_path",           help="full path to file with regular expression to set file template",                                              metavar="TEMPLATE_FILE_PATH")
    parser.add_option("-e", "--excluded_files", dest="file_with_exclusion_patterns", help="full path to file with Unix shell-style patterns (separated by newlines) to exclude files from verification", metavar="EXCLUDED-FILES")

    (options, args) = parser.parse_args()

    if options.source_path is None:
        parser.error('All arguments must be specified. Use option -h to see the usage.')

    if not os.path.exists(options.source_path):
        print "error: The source path doesn't exist"
        return

    file_template_argument = ""

    if options.template_file_path is not None:
        if not os.path.exists(options.template_file_path):
            print "error: The file with template file doesn't exist"
            return

        file_template_argument = "--template_file='%s'" % options.template_file_path

    if options.file_with_exclusion_patterns is not None:
        if not os.path.exists(options.file_with_exclusion_patterns):
            print "error: The file with excluded files doesn't exist"
            return

    lint_path = os.path.join(os.path.dirname(__file__), 'NIXObjCLint')

    source_file_paths          = objc_files_by_path(options.source_path)
    filtered_source_file_paths = exclude_files_with_patterns(source_file_paths, options.file_with_exclusion_patterns)

    input_files_list_path = os.path.join(os.path.dirname(__file__), 'InputFilesList')
    write_paths_to_file(filtered_source_file_paths, input_files_list_path)

    command = "'%s' --files='%s' %s" % (lint_path, input_files_list_path, file_template_argument)
    status, output = commands.getstatusoutput(command)
    print output

    os.remove(input_files_list_path)

def objc_files_by_path(source_path):
    source_file_paths = []

    for root_folder, sub_folders, files in os.walk(source_path):
        for file in files:
            file_path = os.path.join(root_folder, file)

            if is_objc_file(file_path):
                source_file_paths.append(file_path)

    return source_file_paths

def is_objc_file(file_path):
    filename        = os.path.basename(file_path)
    name, extension = os.path.splitext(filename)

    return extension == '.h' or extension == '.m' or extension == '.mm'

def write_paths_to_file(paths, destination_path):
    input_file = open(destination_path, 'w+')

    for path in paths:
        input_file.write(path + '\n')

    input_file.close()

def exclude_files_with_patterns(paths, file_with_patterns_path):
    excluded_file_patterns = []
    filtered_paths         = list(paths)

    if file_with_patterns_path is not None:
        if os.path.exists(file_with_patterns_path):
            file_with_patterns = open(file_with_patterns_path, "r")

            for pattern in file_with_patterns:
                excluded_file_patterns.append(pattern.rstrip('\r\n'))

            file_with_patterns.close()

    for path in paths:
        for excluded_file_pattern in excluded_file_patterns:
            if fnmatch.fnmatch(path, excluded_file_pattern):
                filtered_paths.remove(path)
                break

    return filtered_paths

if __name__ == '__main__':
    sys.exit(main())