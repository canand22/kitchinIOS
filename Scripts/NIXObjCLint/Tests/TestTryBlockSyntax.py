#!/usr/bin/python

# TestTryBlockSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestTryBlockSyntax(BaseTestClass):

    def test_does_not_raise_error_with_correct_syntax_of_try_catch_block(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception)
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@try
{
    foo;
}
@catch (NSException *exception)
{
    foo;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_try_finally_block(self):
        code_string = '''\
@try
{
    foo;
}
@finally
{
    foo;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@try
{
    foo;
}
@finally
{
    foo;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_try_catch_finally_block(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception)
{
}
@finally
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@try
{
    foo;
}
@catch (NSException *exception)
{
    foo;
}
@finally
{
    foo;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_in_try_catch_block(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
        foo;
    }
    @catch (NSException *exception)
    {
        foo;
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_in_try_finally_block(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
        foo;
    }
    @finally
    {
        foo;
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_in_try_catch_finally_block(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
        foo;
    }
    @catch (NSException *exception)
    {
        foo;
    }
    @finally
    {
        foo;
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_open_brace_of_try_block_should_be_in_new_line(self):
        code_string = '''\
@try{
}
@catch (NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_try_block_should_be_in_new_line(self):
        code_string = '''\
@try
{ }
@catch (NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_try_block_should_be_single_character_in_line(self):
        code_string = '''\
@try
{ foo;
}
@catch (NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_try_block_should_be_single_character_in_line(self):
        code_string = '''\
@try
{
    foo; }
@catch (NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_catch_block_should_be_in_new_line(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception){
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_catch_block_should_be_in_new_line(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception)
{ }'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_catch_block_should_be_single_character_in_line(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception)
{ foo;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_catch_block_should_be_single_character_in_line(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception)
{
    foo; }'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_finally_block_should_be_in_new_line(self):
        code_string = '''\
@try
{
}
@finally{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_finally_block_should_be_in_new_line(self):
        code_string = '''\
@try
{
}
@finally
{ }'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_finally_block_should_be_single_character_in_line(self):
        code_string = '''\
@try
{
}
@finally
{ foo;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_finally_block_should_be_single_character_in_line(self):
        code_string = '''\
@try
{
}
@finally
{
    foo; }'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Newline character is missed"])

    def test_raises_error_one_whitespace_should_be_before_exception_open_brace(self):
        code_string = '''\
@try
{
}
@catch(NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [6], ["Wrong whitespace count"])

        code_string = '''\
@try
{
}
@catch  (NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [8], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_exception_open_brace(self):
        code_string = '''\
@try
{
}
@catch ( NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [9], ["Wrong whitespace count"])

        code_string = '''\
@try
{
}
@catch (     NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [13], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_exception_close_brace(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception )
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [31], ["Wrong whitespace count"])

        code_string = '''\
@try
{
}
@catch (NSException *exception     )
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [35], ["Wrong whitespace count"])

    def test_raises_error_empty_line_should_not_be_before_catch_block(self):
        code_string = '''\
@try
{
}

@catch (NSException *exception)
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_finally_block(self):
        code_string = '''\
@try
{
}

@finally
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_catch_and_finally_block(self):
        code_string = '''\
@try
{
}

@catch (NSException *exception)
{
}

@finally
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3, 7], [None, None], ["Too much newline characters", "Too much newline characters"])

    def test_raises_error_try_word_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
   @try
    {
    }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
     @try
    {
    }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_catch_word_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
   @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
     @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

    def test_raises_error_finally_word_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
   @finally
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
     @finally
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_try_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
   {
    }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
     {
    }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_try_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
   }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
     }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_catch_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @catch (NSException *exception)
   {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @catch (NSException *exception)
     {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_catch_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @catch (NSException *exception)
    {
   }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @catch (NSException *exception)
    {
     }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_finally_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @finally
   {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @finally
     {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_finally_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @finally
    {
   }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @finally
    {
     }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_try_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
       line;
    }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
         line;
    }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
       line;

         line;
    }
    @catch (NSException *exception)
    {
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5, 7], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_code_inside_catch_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @catch (NSException *exception)
    {
       line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @catch (NSException *exception)
    {
         line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @catch (NSException *exception)
    {
       line;

         line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8, 10], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_code_inside_finally_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @finally
    {
       line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @finally
    {
         line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    @try
    {
    }
    @finally
    {
       line;

         line;
    }
}'''

        # verify
        self.will_raise_error_with_code(code_string, [8, 10], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_try_block(self):
        code_string = '''\
@try

{
}
@finally
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_finally_block(self):
        code_string = '''\
@try
{
}
@finally

{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_catch_block(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception)

{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_try_block(self):
        code_string = '''\
@try
{

    line;
}
@finally
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

        code_string = '''\
@try
{

}
@finally
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_finally_block(self):
        code_string = '''\
@try
{
}
@finally
{

    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Too much newline characters"])

        code_string = '''\
@try
{
}
@finally
{

}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_catch_block(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception)
{

    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Too much newline characters"])

        code_string = '''\
@try
{
}
@catch (NSException *exception)
{

}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace_of_try_block(self):
        code_string = '''\
@try
{
    line;

}
@finally
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace_of_finally_block(self):
        code_string = '''\
@try
{
}
@finally
{
    line;

}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace_of_catch_block(self):
        code_string = '''\
@try
{
}
@catch (NSException *exception)
{
    line;

}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Too much newline characters"])