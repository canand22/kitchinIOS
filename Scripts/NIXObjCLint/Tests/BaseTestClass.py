#!/usr/bin/python

# BaseTestClass.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

import unittest
import os
import commands
import shutil

class BaseTestClass(unittest.TestCase):

    def setUp(self):
        self.source_file_dir    = os.path.join(os.path.dirname(__file__), 'Source')
        self.file_template_path = os.path.join(self.source_file_dir, 'FileTemplate')

    def will_not_raise_error_with_code(self, code_string, source_filename = "File.m", file_template = ".*", file_with_exclusion_patterns = None):
        file_path, output = self.validate_code(code_string, source_filename, file_template, file_with_exclusion_patterns)

        # verify
        self.verify_output("", output)

    def will_raise_error_with_code(self, code_string, file_line, column_number, error_msg, source_filename = "File.m", file_template = ".*", file_with_exclusion_patterns = None):
        assert len(file_line) == len(file_line)
        assert len(file_line) == len(error_msg)

        file_path, output = self.validate_code(code_string, source_filename, file_template, file_with_exclusion_patterns)

        expected_output = ""

        for i in range(len(file_line)):
            column_number_str  = "" if (column_number[i] is None) else ("%d:" % column_number[i])
            expected_output   += "\n%s:%d:%s warning: %s [NIXObjCLint]" % (file_path, file_line[i], column_number_str, error_msg[i])

        # verify
        self.verify_output(expected_output, output)

    def validate_code(self, code_string, source_filename, file_template, file_with_exclusion_patterns):
        lint_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'NIXObjCLint.py'))

        template_file_argument  = ""
        excluded_files_argument = ""
        source_file_path        = os.path.join(self.source_file_dir, source_filename)

        if os.path.exists(self.source_file_dir):
            shutil.rmtree(self.source_file_dir)
        os.makedirs(self.source_file_dir)

        text_file = open(source_file_path, "w+")
        text_file.write(code_string)
        text_file.close()

        if file_template is not None:
            template_file_argument = "--template_file='%s'" % self.file_template_path
            text_file = open(self.file_template_path, "w+")
            text_file.write(file_template)
            text_file.close()

        if file_with_exclusion_patterns is not None:
            excluded_files_argument = "--excluded_files='%s'" % file_with_exclusion_patterns

        # exercise
        command = "'%s' --source='%s' %s %s" % (lint_path, self.source_file_dir, template_file_argument, excluded_files_argument)
        status, output = commands.getstatusoutput(command)
        assert status == 0, output

        shutil.rmtree(self.source_file_dir)

        return source_file_path, output

    def verify_output(self, expected_output, actual_output):
        assert expected_output == actual_output, "\nExpected output:'%s'\nActual output:'%s'" % (expected_output, actual_output)

if __name__ == '__main__':
    unittest.main()