#!/usr/bin/python

# TestLiteralsSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 29/01/13.
# Copyright 2013 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestLiteralsSyntax(BaseTestClass):

    def test_does_not_raise_error_with_correct_syntax_of_array_with_integral_index(self):
        code_string = '''\
array[0];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
array[index];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_dictionary_literal_syntax_with_one_value_in_one_line(self):
        code_string = '''\
NSDictionary *dict = @{object : @"key"};'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_dictionary_literal_syntax_with_three_values_in_one_line(self):
        code_string = '''\
NSDictionary *dict = @{object1 : @"key1", object2 : @"key2", object3 : @"key3"};'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_dictionary_literal_syntax_with_one_value_in_several_lines(self):
        code_string = '''\
NSDictionary *dict = @{
                          object : @"key"
                      };'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_dictionary_literal_syntax_with_three_values_in_several_lines(self):
        code_string = '''\
NSDictionary *dict = @{
                          object1 : @"key1",
                          object2 : @"key2",
                          object3 : @"key3"
                      };'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_array_literal_syntax_with_one_value_in_one_line(self):
        code_string = '''\
NSArray *array = @[object];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_array_literal_syntax_with_three_values_in_one_line(self):
        code_string = '''\
NSArray *array = @[object1, object2, object3];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_array_literal_syntax_with_one_value_in_several_lines(self):
        code_string = '''\
NSArray *array = @[
                      object
                  ];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_array_literal_syntax_with_three_values_in_several_lines(self):
        code_string = '''\
NSArray *array = @[
                      object1,
                      object2,
                      object3
                  ];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_expression_literal_syntax_with_bool_value_and_braces(self):
        code_string = '''\
NSNumber *foo = @(YES);'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSNumber *foo = @(NO);'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_expression_literal_syntax_with_bool_value_and_without_braces(self):
        code_string = '''\
NSNumber *foo = @YES;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSNumber *foo = @NO;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_expression_literal_syntax_with_integer_value_and_braces(self):
        code_string = '''\
NSNumber *foo = @(4);'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSNumber *foo = @(777);'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_expression_literal_syntax_with_integer_value_and_without_braces(self):
        code_string = '''\
NSNumber *foo = @4;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSNumber *foo = @777;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_expression_literal_syntax_with_method_invocation(self):
        code_string = '''\
NSNumber *foo = @([self getValue]);'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSNumber *foo = @([self getValue]);'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_literal_syntax_inside_block(self):
        code_string = '''\
void (^block)(void) = ^
{
    NSDictionary *dict = @{
                              foo : @"key"
                          };
};'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_whitespace_should_not_be_before_open_brace_of_array_literal_index(self):
        code_string = '''\
array [0];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Wrong whitespace count"])

        code_string = '''\
array    [0];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

        code_string = '''\
array [index];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Wrong whitespace count"])

        code_string = '''\
array    [index];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_of_array_literal_index(self):
        code_string = '''\
array[ 0];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
array[    0];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

        code_string = '''\
array[ index];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
array[    index];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_of_array_literal_index(self):
        code_string = '''\
array[0 ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
array[0    ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
array[index ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [12], ["Wrong whitespace count"])

        code_string = '''\
array[index    ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [15], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_between_literal_caret_and_open_brace_of_dictionary_literal(self):
        code_string = '''\
NSDictionary *dict = @ {object : @"key"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [23], ["Wrong whitespace count"])

        code_string = '''\
NSDictionary *dict = @     {object : @"key"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [27], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_of_dictionary_literal(self):
        code_string = '''\
NSDictionary *dict = @{ object : @"key"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [24], ["Wrong whitespace count"])

        code_string = '''\
NSDictionary *dict = @{   object : @"key"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [26], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_of_dictionary_literal(self):
        code_string = '''\
NSDictionary *dict = @{object : @"key" };'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [39], ["Wrong whitespace count"])

        code_string = '''\
NSDictionary *dict = @{object : @"key"   };'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [41], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_colon_of_dictionary_literal(self):
        code_string = '''\
NSDictionary *dict = @{object: @"key"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [29], ["Wrong whitespace count"])

        code_string = '''\
NSDictionary *dict = @{object  : @"key"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [31], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_colon_of_dictionary_literal(self):
        code_string = '''\
NSDictionary *dict = @{object :@"key"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [31], ["Wrong whitespace count"])

        code_string = '''\
NSDictionary *dict = @{object :  @"key"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [33], ["Wrong whitespace count"])

    def test_raises_error_values_should_have_four_whitespace_symbols_indent_inside_dictionary_literal(self):
        code_string = '''\
NSDictionary *dict = @{
                         object1 : @"key1"
                      };'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

        code_string = '''\
NSDictionary *dict = @{
                           object1 : @"key1"
                      };'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

        code_string = '''\
NSDictionary *dict = @{
                         object1 : @"key1",
                          object2 : @"key2",
                           object3 : @"key3"
                      };'''

        # verify
        self.will_raise_error_with_code(code_string, [2, 4], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_close_brace_of_dictionary_literal_should_be_under_open_brace(self):
        code_string = '''\
NSDictionary *dict = @{
                          object1 : @"key1"
                     };'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
NSDictionary *dict = @{
                          object1 : @"key1"
                       };'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_one_whitespace_symbol_should_be_after_comma_in_dictionary_literal(self):
        code_string = '''\
NSDictionary *dict = @{object1 : @"key1",object2 : @"key2"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [41], ["Wrong whitespace count"])

        code_string = '''\
NSDictionary *dict = @{object1 : @"key1",  object2 : @"key2"};'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [43], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_between_literal_caret_and_open_brace_of_array_literal(self):
        code_string = '''\
NSArray *array = @ [object];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [19], ["Wrong whitespace count"])

        code_string = '''\
NSArray *array = @     [object];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [23], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_of_array_literal(self):
        code_string = '''\
NSArray *array = @[ object];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [20], ["Wrong whitespace count"])

        code_string = '''\
NSArray *array = @[   object];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [22], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_of_array_literal(self):
        code_string = '''\
NSArray *array = @[object ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [26], ["Wrong whitespace count"])

        code_string = '''\
NSArray *array = @[object   ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [28], ["Wrong whitespace count"])

    def test_raises_error_values_should_have_four_whitespace_symbols_indent_inside_array_literal(self):
        code_string = '''\
NSArray *array = @[
                     object
                  ];'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

        code_string = '''\
NSArray *array = @[
                       object
                  ];'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

        code_string = '''\
NSArray *array = @[
                     object1,
                      object2,
                       object3
                  ];'''

        # verify
        self.will_raise_error_with_code(code_string, [2, 4], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_close_brace_of_array_literal_should_be_under_open_brace(self):
        code_string = '''\
NSArray *array = @[
                      object
                 ];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
NSArray *array = @[
                      object
                   ];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_one_whitespace_symbol_should_be_after_comma_in_array_literal(self):
        code_string = '''\
NSArray *array = @[object1,object2];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [27], ["Wrong whitespace count"])

        code_string = '''\
NSArray *array = @[object1,  object2];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [29], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_between_literal_caret_and_quotes_of_string_literal(self):
        code_string = '''\
NSString *string = @ "object";'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [21], ["Wrong whitespace count"])

        code_string = '''\
NSString *string = @    "object";'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [24], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_between_literal_caret_and_open_brace_in_expression_literal(self):
        code_string = '''\
NSNumber *foo = @ (YES);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [18], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @  (123);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [19], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @   ([self getValue]);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [20], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_between_literal_caret_and_bool_value_in_expression_literal(self):
        code_string = '''\
NSNumber *foo = @ YES;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [18], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @    NO;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [21], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_between_literal_caret_and_integer_value_in_expression_literal(self):
        code_string = '''\
NSNumber *foo = @ 123;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [18], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @    123;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [21], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_in_expression_literal_with_bool_value(self):
        code_string = '''\
NSNumber *foo = @( YES);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [19], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @(   NO);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [21], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_in_expression_literal_with_integer_value(self):
        code_string = '''\
NSNumber *foo = @( 123);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [19], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @(   123);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [21], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_in_expression_literal_with_method_invocation(self):
        code_string = '''\
NSNumber *foo = @( [self getValue]);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [19], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @(   [self getValue]);'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [21], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_in_expression_literal_with_bool_value(self):
        code_string = '''\
NSNumber *foo = @(YES );'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [22], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @(NO   );'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [23], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_in_expression_literal_with_integer_value(self):
        code_string = '''\
NSNumber *foo = @(123 );'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [22], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @(123   );'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [24], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_in_expression_literal_with_method_invocation(self):
        code_string = '''\
NSNumber *foo = @([self getValue] );'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [34], ["Wrong whitespace count"])

        code_string = '''\
NSNumber *foo = @([self getValue]   );'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [36], ["Wrong whitespace count"])