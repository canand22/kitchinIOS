#!/usr/bin/python

# TestIfBlockSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestIfBlockSyntax(BaseTestClass):

    def test_does_not_raise_error_with_correct_syntax(self):
        code_string = '''\
if (isFoo)
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_empty_line_before_and_after_if_block(self):
        code_string = '''\
- (void)fooMethod
{
    line;

    if (isFoo)
    {
    }

    line;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_in_if_block(self):
        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
    {
        line;
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_break_word_in_if_block(self):
        code_string = '''\
if (foo)
{
    break;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_break_indent_in_if_block_which_embedded_in_switch_block(self):
        code_string = '''\
switch (type)
{
    case value:
    {
        if (foo)
        {
            break;
        }
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_one_whitespace_symbol_should_be_before_condition_open_brace(self):
        code_string = '''\
if(isFoo)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [2], ["Wrong whitespace count"])

        code_string = '''\
if  (isFoo)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [4], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_condition_open_brace(self):
        code_string = '''\
if ( isFoo)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
if (   isFoo)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_condition_close_brace(self):
        code_string = '''\
if (isFoo )
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

        code_string = '''\
if (isFoo    )
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

    def test_raises_error_open_brace_of_block_should_be_in_new_line(self):
        code_string = '''\
if (isFoo){
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_block_should_be_in_new_line(self):
        code_string = '''\
if (isFoo)
{ }'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_block_should_be_single_character_in_line(self):
        code_string = '''\
if (isFoo)
{ foo;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_block_should_be_single_character_in_line(self):
        code_string = '''\
if (isFoo)
{
    foo; }'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Newline character is missed"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_block(self):
        code_string = '''\
if (isFoo)

{
    foo;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_block(self):
        code_string = '''\
if (isFoo)
{

    foo;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

        code_string = '''\
if (isFoo)
{

}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace_of_block(self):
        code_string = '''\
if (isFoo)
{
    foo;

}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_one_empty_line_should_be_before_if_block(self):
        code_string = '''\
- (void)fooMethod
{
    line;
    if (isFoo)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Newline character is missed"])

        code_string = '''\
- (void)fooMethod
{
    line;


    if (isFoo)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_one_empty_line_should_be_after_if_block(self):
        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
    {
    }
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Newline character is missed"])

        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
    {
    }


    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Too much newline characters"])

    def test_raises_error_one_empty_line_should_be_before_and_after_if_block(self):
        code_string = '''\
- (void)fooMethod
{
    line;
    if (isFoo)
    {
    }
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3, 6], [None, None], ["Newline character is missed", "Newline character is missed"])

        code_string = '''\
- (void)fooMethod
{
    line;


    if (isFoo)
    {
    }



    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3, 8], [None, None], ["Too much newline characters", "Too much newline characters"])

    def test_raises_error_if_expression_string_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
   if (isFoo)
    {
        line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
     if (isFoo)
    {
        line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_if_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
   {
        line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
     {
        line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_if_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
    {
        line;
   }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
    {
        line;
     }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_if_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
    {
       line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
    {
         line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    if (isFoo)
    {
       line;

         line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5, 7], [None, None], ["Wrong string indent", "Wrong string indent"])