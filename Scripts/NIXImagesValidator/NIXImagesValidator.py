#!/usr/bin/python

# NIXImagesValidator.py
#
# Created by Egor Zubkov on 02/07/14.
# Copyright 2013 nix. All rights reserved.

import os
import re
import sys
import optparse
import collections
import fnmatch

image_extensions           = ['.png', '.jpg', '.jpeg']
validation_file_extensions = ['.h', '.m', '.mm', '.xib', '.storyboard', '.plist']

def main():
    parser = optparse.OptionParser(description='Script validates that all image files are used, finds duplicated images and missing images in project folder', prog='NIXImagesValidator')

    parser.add_option("-s", "--source",         dest="source_path",                  help="full path to directory with project",                                                                         metavar="SOURCE-PATH")
    parser.add_option("-e", "--excluded_files", dest="file_with_exclusion_patterns", help="full path to file with Unix shell-style patterns (separated by newlines) to exclude files from verification", metavar="EXCLUDED-FILES")

    (options, args) = parser.parse_args()

    if options.source_path is None:
        parser.error('All arguments must be specified. Use option -h to see the usage.')

    if not os.path.exists(options.source_path):
        print "error: source path '%s' doesn't exist" % options.source_path
        return 1

    if options.file_with_exclusion_patterns is not None:
        if not os.path.exists(options.file_with_exclusion_patterns):
            print "error: The file with excluded files doesn't exist"
            return

    source_file_paths          = source_files_by_path(options.source_path)
    source_file_paths          = exclude_auto_generated_files(source_file_paths, options.source_path)
    excluded_file_pattern_list = excluded_file_patterns(options.file_with_exclusion_patterns)
    original_image_names       = image_names_by_path(options.source_path, excluded_file_pattern_list)
    image_names                = verify_and_remove_duplicated_items(original_image_names)
    image_names                = filter_images_with_suffixes(image_names)
    image_names                = remove_excluded_images(image_names)

    verify_unused_images(image_names, source_file_paths)
    verify_missing_images(original_image_names, source_file_paths, excluded_file_pattern_list)

    return 0

def source_files_by_path(source_path):
    source_file_paths = []

    for root_folder, sub_folders, files in os.walk(source_path):
        for file in files:
            file_path = os.path.join(root_folder, file)

            if is_validation_file(file_path):
                source_file_paths.append(file_path)

    return source_file_paths

def exclude_auto_generated_files(file_paths, source_path):
    filtered_file_paths = list(file_paths)

    for file_path in file_paths:
        if is_auto_generated_file(file_path, source_path):
            filtered_file_paths.remove(file_path)

    return filtered_file_paths

def is_auto_generated_file(file_path, source_path):
    filter_path_mask = os.path.join(source_path, 'build*')

    return fnmatch.fnmatch(file_path, filter_path_mask)

def is_validation_file(file_path):
    filename        = os.path.basename(file_path)
    name, extension = os.path.splitext(filename)

    return extension in validation_file_extensions

def image_names_by_path(source_path, excluded_file_patterns):
    image_names = []

    for root_folder, sub_folders, files in os.walk(source_path):
        for file in files:
            if is_image(file) and not is_auto_generated_file(root_folder, source_path) and not is_exclusion_file(os.path.join(root_folder, file), excluded_file_patterns):
                image_names.append(file)

    return image_names

def is_image(filename):
    name, extension = os.path.splitext(filename)

    return extension in image_extensions

def verify_and_remove_duplicated_items(items):
    duplicated_items = [item for item, count in collections.Counter(items).items() if count > 1]

    for item in duplicated_items:
        output_warning("'%s' image is duplicated" % item)

    return set(items)

def remove_excluded_images(image_names):
    excluded_images = ['default.png', 'default-568h.png']

    filtered_images = []

    for image_name in image_names:
        matcher = re.compile(image_name, re.IGNORECASE)
        if not any(filter(matcher.match, excluded_images)):
            filtered_images.append(image_name)

    return filtered_images

def filter_images_with_suffixes(image_names):
    suffixes = ['@2x', '~ipad', '~iphone', '-PortraitUpsideDown', '-LandscapeLeft', '-LandscapeRight', '-Portrait', '-Landscape', '-76', '-72', '-60']

    filtered_images = []

    for image_name in image_names:
        filtered_image = image_name

        for  suffix in suffixes:
            filtered_image = filtered_image.replace(suffix, '')

        filtered_images.append(filtered_image)

    return set(filtered_images)

def verify_unused_images(image_names, source_file_paths):
    for image_name in image_names:
        image_is_used = False

        for source_file_path in source_file_paths:
            if os.path.exists(source_file_path):
                file_content_string  = file_content(source_file_path)
                base_name, extension = os.path.splitext(image_name)

                pattern_with_image_extension    = '[",>]%s[",<]' % image_name
                pattern_without_image_extension = '[",>]%s[",<]' % base_name

                if re.search(pattern_with_image_extension, file_content_string) or re.search(pattern_without_image_extension, file_content_string):
                    image_is_used = True
                    break

        if not image_is_used:
            output_warning("'%s' image is unused" % image_name)

def verify_missing_images(image_names, source_file_paths, excluded_file_patterns):
    splitter = "|\\";
    matched_extensions = splitter.join(image_extensions);
    pattern = '(?<=")[^"\s]*(?:\%s)(?=")|(?<=>)[^>\s]*(?:\%s)(?=<)' % (matched_extensions, matched_extensions)

    for source_file_path in source_file_paths:
        matched_strings = set(re.findall(pattern, file_content(source_file_path)))

        for matched_string in matched_strings:
            if matched_string not in image_names and not is_exclusion_file(matched_string, excluded_file_patterns):
                output_warning("'%s' image is missing" % matched_string)

def file_content(file_path):
    file         = open(file_path, 'r')
    file_content = file.read()
    file.close()

    return file_content

def excluded_file_patterns(file_with_patterns_path):
    excluded_file_patterns = []

    if file_with_patterns_path is not None:
        if os.path.exists(file_with_patterns_path):
            file_with_patterns = open(file_with_patterns_path, "r")

            for pattern in file_with_patterns:
                excluded_file_patterns.append(pattern.rstrip('\r\n'))

            file_with_patterns.close()

    return excluded_file_patterns

def is_exclusion_file(file_path, excluded_file_patterns):
    for excluded_file_pattern in excluded_file_patterns:
        if fnmatch.fnmatch(file_path, excluded_file_pattern):
            return True

    return False

def output_warning(message):
    print "warning: %s" % message

if __name__ == '__main__':
    sys.exit(main())