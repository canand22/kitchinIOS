#!/usr/bin/python

# TestTernaryOperatorSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestTernaryOperatorSyntax(BaseTestClass):

    def test_does_not_raise_error_with_correct_syntax(self):
        code_string = '''\
count = (isSelected) ? 3 : 5;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_ternary_operator_as_method_argument(self):
        code_string = '''\
[object setValue:isSelected ? value1 : value2];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_whitespace_should_not_be_after_condition_open_brace(self):
        code_string = '''\
count = ( isSelected) ? 3 : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

        code_string = '''\
count = (    isSelected) ? 3 : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_condition_close_brace(self):
        code_string = '''\
count = (isSelected ) ? 3 : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [20], ["Wrong whitespace count"])

        code_string = '''\
count = (isSelected    ) ? 3 : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [23], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_question_mark(self):
        code_string = '''\
count = (isSelected)? 3 : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [20], ["Wrong whitespace count"])

        code_string = '''\
count = (isSelected)  ? 3 : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [22], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_question_mark(self):
        code_string = '''\
count = (isSelected) ?3 : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [22], ["Wrong whitespace count"])

        code_string = '''\
count = (isSelected) ?  3 : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [24], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_colon(self):
        code_string = '''\
count = (isSelected) ? 3: 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [24], ["Wrong whitespace count"])

        code_string = '''\
count = (isSelected) ? 3  : 5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [26], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_colon(self):
        code_string = '''\
count = (isSelected) ? 3 :5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [26], ["Wrong whitespace count"])

        code_string = '''\
count = (isSelected) ? 3 :  5;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [28], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_colon_of_ternary_operator(self):
        code_string = '''\
[object setValue:isSelected ? value1: value2];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [36], ["Wrong whitespace count"])

        code_string = '''\
[object setValue:isSelected ? value1  : value2];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [38], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_colon_of_ternary_operator(self):
        code_string = '''\
[object setValue:isSelected ? value1 :value2];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [38], ["Wrong whitespace count"])

        code_string = '''\
[object setValue:isSelected ? value1 :  value2];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [40], ["Wrong whitespace count"])