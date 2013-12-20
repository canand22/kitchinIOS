#!/usr/bin/python

# TestExcludedFilesValidator.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

import os
from BaseTestClass import BaseTestClass

class TestExcludedFilesValidator(BaseTestClass):

    def test_does_not_raise_error_with_correct_syntax_without_file_with_exclusion_patterns(self):
        code_string = '''\
NSString *string;'''

        # verify
        self._will_not_raise_error_with_specify_exclusion_patterns(code_string, "File.m", None)

    def test_does_not_raise_error_with_correct_syntax_without_exclusion_patterns(self):
        code_string = '''\
NSString *string;'''

        # verify
        self._will_not_raise_error_with_specify_exclusion_patterns(code_string, "File.m", "")

    def test_does_not_raise_error_with_incorrect_syntax_with_exclusion_pattern(self):
        code_string = '''\
NSString * string;'''

        # verify
        self._will_not_raise_error_with_specify_exclusion_patterns(code_string, "File.m", "*.m")

    def test_does_not_raise_error_with_incorrect_syntax_with_a_few_exclusion_patterns(self):
        code_string = '''\
NSString * string;'''

        exclusion_patterns = '''\
*.h
*AutoGenerated.m'''

        # verify
        self._will_not_raise_error_with_specify_exclusion_patterns(code_string, "File_AutoGenerated.m", exclusion_patterns)

    def test_raises_error_with_incorrect_syntax_without_exclusion_patterns(self):
        code_string = '''\
NSString * string;'''

        # verify
        self._will_raise_error_with_specify_exclusion_patterns(code_string, [1], [11], ["Wrong whitespace count"], "File.m", "")

    def test_raises_error_with_incorrect_syntax_with_exclusion_pattern(self):
        code_string = '''\
NSString * string;'''

        # verify
        self._will_raise_error_with_specify_exclusion_patterns(code_string, [1], [11], ["Wrong whitespace count"], "File.m", "*.h")

    def test_raises_error_with_incorrect_syntax_with_a_few_exclusion_patterns(self):
        code_string = '''\
NSString * string;'''

        exclusion_patterns = '''\
*.h
*AutoGenerated.m'''

        # verify
        self._will_raise_error_with_specify_exclusion_patterns(code_string, [1], [11], ["Wrong whitespace count"], "File.m", exclusion_patterns)

    def _will_not_raise_error_with_specify_exclusion_patterns(self, code_string, source_filename, excluded_files):
        file_with_exclusion_patterns = self._create_file_with_exclusion_patterns(excluded_files)

        # verify
        self.will_not_raise_error_with_code(code_string, source_filename, file_with_exclusion_patterns = file_with_exclusion_patterns)

        if file_with_exclusion_patterns is not None:
            if os.path.exists(file_with_exclusion_patterns):
                os.remove(file_with_exclusion_patterns)

    def _will_raise_error_with_specify_exclusion_patterns(self, code_string, file_line, column_number, error_msg, source_filename, excluded_files):
        file_with_exclusion_patterns = self._create_file_with_exclusion_patterns(excluded_files)

        # verify
        self.will_raise_error_with_code(code_string, file_line, column_number, error_msg, source_filename, file_with_exclusion_patterns = file_with_exclusion_patterns)

        if file_with_exclusion_patterns is not None:
            if os.path.exists(file_with_exclusion_patterns):
                os.remove(file_with_exclusion_patterns)

    def _create_file_with_exclusion_patterns(self, exclusion_patterns):
        file_with_exclusion_patterns = None

        if exclusion_patterns is not None:
            filename                     = "ExcludedFiles"
            file_with_exclusion_patterns = os.path.join(os.path.dirname(__file__), filename)

            text_file = open(file_with_exclusion_patterns, "w+")
            text_file.write(exclusion_patterns)
            text_file.close()

        return file_with_exclusion_patterns