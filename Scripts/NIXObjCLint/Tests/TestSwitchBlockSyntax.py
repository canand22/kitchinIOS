#!/usr/bin/python

# TestSwitchBlockSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestSwitchBlockSyntax(BaseTestClass):

    def test_does_not_raise_error_with_correct_syntax_without_case_blocks(self):
        code_string = '''\
switch (type)
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_with_case_blocks(self):
        code_string = '''\
switch (type)
{
    case firstType:
    {
        line;
    }
        break;
    case secondType:
        break;
    default:
        break;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_in_switch_block(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            line;
        }
            break;
        case secondType:
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_switch_indents_which_inserted_in_switch(self):
        code_string = '''\
switch (type)
{
    case firstType:
    {
        switch (type)
        {
            case firstType:
                break;
        }

        break;
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
switch (type)
{
    case firstType:
    {
        switch (type)
        {
            case firstType:
                break;
        }
    }
        break;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_single_line_indent_in_case_block_without_braces(self):
        code_string = '''\
switch (type)
{
    case firstType:
        line;

        break;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_lines_indents_in_case_block_without_braces(self):
        code_string = '''\
switch (type)
{
    case firstType:
        line;
        line;

        break;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_string_indents_of_case_break_word_in_switch_sequence(self):
        code_string = '''\
if (foo)
{
    switch (type)
    {
        case value:
        {
            break;
        }
    }
}

switch (type)
{
    case value:
    {
        line;
        break;
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_one_whitespace_symbol_should_be_before_open_brace_of_switch_statement(self):
        code_string = '''\
switch(type)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Wrong whitespace count"])

        code_string = '''\
switch     (type)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_of_switch_statement(self):
        code_string = '''\
switch ( type)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

        code_string = '''\
switch (     type)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_of_switch_statement(self):
        code_string = '''\
switch (type )
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

        code_string = '''\
switch (type     )
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [17], ["Wrong whitespace count"])

    def test_raises_error_open_brace_of_switch_block_should_be_in_new_line(self):
        code_string = '''\
switch (type){
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_switch_block_should_be_in_new_line(self):
        code_string = '''\
switch (type)
{ }'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_switch_block_should_be_single_character_in_line(self):
        code_string = '''\
switch (type)
{ case firstType:
      break;
    default:
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_block_should_be_single_character_in_line(self):
        code_string = '''\
switch (type)
{
    case firstType:
        break;
    default:
        break; }'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Newline character is missed"])

    def test_does_not_raise_error_whitespace_should_not_be_before_colon_of_case_expression(self):
        code_string = '''\
switch (type)
{
    case firstType :
        break;
    default:
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [19], ["Wrong whitespace count"])

        code_string = '''\
switch (type)
{
    case firstType    :
        break;
    default:
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [22], ["Wrong whitespace count"])

    def test_raises_error_open_brace_of_case_block_should_be_in_new_line(self):
        code_string = '''\
switch (type)
{
    case firstType: {
    }
        break;
    default:
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Newline character is missed"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_case_block(self):
        code_string = '''\
switch (type)
{
    case firstType:

    {
    }
        break;
    default:
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_case_block(self):
        code_string = '''\
switch (type)
{
    case firstType:
    {

        line;
    }
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Too much newline characters"])

        code_string = '''\
switch (type)
{
    case firstType:
    {

    }
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace_of_case_block(self):
        code_string = '''\
switch (type)
{
    case firstType:
    {
        line;

    }
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_switch_block(self):
        code_string = '''\
switch (type)

{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_switch_block(self):
        code_string = '''\
switch (type)
{

    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

        code_string = '''\
switch (type)
{

}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_of_switch_block(self):
        code_string = '''\
switch (type)
{
    line;

}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_open_brace_of_case_block_should_be_single_character_in_line(self):
        code_string = '''\
switch (type)
{
    case firstType:
    { line; }
        break;
    default:
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_block_should_be_single_character_in_line(self):
        code_string = '''\
switch (type)
{
    case firstType:
    {
        line; }
        break;
    default:
        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Newline character is missed"])

    def test_raises_error_switch_expression_string_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
   switch (type)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
     switch (type)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_if_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
   {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
     {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_if_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
   }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
     }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

    def test_raises_error_case_expression_string_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
       case firstType:
        {
            line;
        }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
         case firstType:
        {
            line;
        }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_case_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
       {
            line;
        }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
         {
            line;
        }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_case_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            line;
       }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            line;
         }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_case_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
           line;
        }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
             line;
        }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
           line;

             line;
        }
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7, 9], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_break_word_should_have_four_whitespace_symbols_indent_after_case_block(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            line;
        }
           break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [9], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            line;
        }
             break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [9], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
           break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
             break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

    def test_raises_error_default_world_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
       default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
         default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_default_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
       {
            line;
        }
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
         {
            line;
        }
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_default_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
        {
            line;
       }
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [10], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
        {
            line;
         }
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [10], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_default_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
        {
           line;
        }
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [9], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
        {
             line;
        }
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [9], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
        {
           line;

             line;
        }
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [9, 11], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_break_word_should_have_four_whitespace_symbols_indent_after_default_block(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
        {
            line;
        }
           break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [11], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
        {
            line;
        }
             break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [11], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
           break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;
        default:
             break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

    def test_raises_error_without_newline_symbol_before_case_block(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break; case secondType:
                       break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Newline character is missed"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            break; } case secondType:
                         break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Newline character is missed"])

    def test_raises_error_with_more_than_one_newline_symbol_before_case_block(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;

        case secondType:
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Too much newline characters"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            break;
        }

        case secondType:
            break;
        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Too much newline characters"])

    def test_raises_error_without_newline_symbol_before_default_block(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break; default:
                       break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Newline character is missed"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            break; } default:
                         break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Newline character is missed"])

    def test_raises_error_with_more_than_one_newline_symbol_before_default_block(self):
        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
            break;

        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Too much newline characters"])

        code_string = '''\
- (void)fooMethod
{
    switch (type)
    {
        case firstType:
        {
            break;
        }

        default:
            break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Too much newline characters"])

    def test_raises_error_with_wrong_break_indent_with_inserted_switch_in_switch(self):
        code_string = '''\
switch (type)
{
    case firstType:
    {
        switch (type)
        {
            case firstType:
                break;
        }

       break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [11], [None], ["Wrong string indent"])

        code_string = '''\
switch (type)
{
    case firstType:
    {
        switch (type)
        {
            case firstType:
                break;
        }

         break;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [11], [None], ["Wrong string indent"])

        code_string = '''\
switch (type)
{
    case firstType:
    {
        switch (type)
        {
            case firstType:
                break;
        }
    }
       break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [11], [None], ["Wrong string indent"])

        code_string = '''\
switch (type)
{
    case firstType:
    {
        switch (type)
        {
            case firstType:
                break;
        }
    }
         break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [11], [None], ["Wrong string indent"])

    def test_raises_error_with_wrong_indent_of_the_single_line_in_case_block_without_braces(self):
        code_string = '''\
switch (type)
{
    case firstType:
       line;

        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
switch (type)
{
    case firstType:
         line;

        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_with_wrong_indent_of_the_first_line_in_case_block_without_braces(self):
        code_string = '''\
switch (type)
{
    case firstType:
       line;
        line;

        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
switch (type)
{
    case firstType:
         line;
        line;

        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_with_wrong_indent_of_the_last_line_in_case_block_without_braces(self):
        code_string = '''\
switch (type)
{
    case firstType:
        line;
       line;

        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
switch (type)
{
    case firstType:
        line;
         line;

        break;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])