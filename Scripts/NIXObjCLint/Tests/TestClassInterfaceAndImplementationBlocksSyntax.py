#!/usr/bin/python

# TestClassInterfaceAndImplementationBlocksSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestClassInterfaceAndImplementationBlocksSyntax(BaseTestClass):

    def test_does_not_raise_error_with_correct_public_interface_syntax_without_protocol_list(self):
        code_string = '''\
@interface Class : Superclass
{
}

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_public_interface_syntax_with_protocol_list(self):
        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_private_interface_syntax(self):
        code_string = '''\
@interface Class ()
{
}

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_implementation_block_syntax(self):
        code_string = '''\
@implementation Class
{
}

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_inside_protocol_list_in_class_definition(self):
        code_string = '''\
@interface Class : Superclass<InterfaceProtocol>

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_symbol_around_colon_in_class_interface(self):
        code_string = '''\
@interface Class : Superclass

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_of_member_variables_in_class_interface(self):
        code_string = '''\
@interface Class : Superclass
{
 @public
    Class *object;
}

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@interface Class : Superclass
{
 @private
    NSInteger val;
}

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@interface Class : Superclass
{
 @protected
    line;
}

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@interface Class : Superclass
{
 @public
    line;

 @private
    line;

 @protected
    line;
}

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_whitespace_should_not_be_before_protocol_list_in_class_definition(self):
        code_string = '''\
@interface Class : Superclass <InterfaceProtocol>

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [30], ["Wrong whitespace count"])

        code_string = '''\
@interface Class : Superclass    <InterfaceProtocol>

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [33], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_of_protocol_list_in_class_definition(self):
        code_string = '''\
@interface Class : Superclass< InterfaceProtocol>

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [31], ["Wrong whitespace count"])

        code_string = '''\
@interface Class : Superclass<   InterfaceProtocol>

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [33], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_of_protocol_list_in_class_definition(self):
        code_string = '''\
@interface Class : Superclass<InterfaceProtocol >

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [48], ["Wrong whitespace count"])

        code_string = '''\
@interface Class : Superclass<InterfaceProtocol    >

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [51], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_colon_in_class_interface(self):
        code_string = '''\
@interface Class: Superclass

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [16], ["Wrong whitespace count"])

        code_string = '''\
@interface Class     : Superclass

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [21], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_colon_in_class_interface(self):
        code_string = '''\
@interface Class :Superclass

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [18], ["Wrong whitespace count"])

        code_string = '''\
@interface Class :      Superclass

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [24], ["Wrong whitespace count"])

    def test_raises_error_open_brace_of_class_interface_block_should_be_in_new_line(self):
        code_string = '''\
@interface Class : Superclass {
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Newline character is missed"])

        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3> {
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Newline character is missed"])

        code_string = '''\
@interface Class () {
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_class_implementation_block_should_be_in_new_line(self):
        code_string = '''\
@implementation Class {
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_class_interface_block_should_be_in_new_line(self):
        code_string = '''\
@interface Class : Superclass
{ }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>
{ }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

        code_string = '''\
@interface Class ()
{ }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_class_implementation_block_should_be_in_new_line(self):
        code_string = '''\
@implementation Class
{ }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_class_interface_block(self):
        code_string = '''\
@interface Class : Superclass

{
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>

{
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

        code_string = '''\
@interface Class ()

{
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_class_implementation_block(self):
        code_string = '''\
@implementation Class

{
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

    def test_raises_error_one_whitespace_should_be_before_open_brace_in_class_private_interface(self):
        code_string = '''\
@interface Class()

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [16], ["Wrong whitespace count"])

        code_string = '''\
@interface Class  ()

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [18], ["Wrong whitespace count"])

    def test_raises_error_class_interface_should_not_have_indent(self):
        code_string = '''\
 @interface Class : Superclass

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Wrong string indent"])

        code_string = '''\
    @interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Wrong string indent"])

    def test_raises_error_class_implementation_should_not_have_indent(self):
        code_string = '''\
 @implementation Class : Superclass

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Wrong string indent"])

        code_string = '''\
    @implementation Class : Superclass

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Wrong string indent"])

    def test_raises_error_end_word_of_class_interface_should_not_have_indent(self):
        code_string = '''\
@interface Class : Superclass

 @end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>

   @end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_end_word_of_class_implementation_should_not_have_indent(self):
        code_string = '''\
@implementation Class : Superclass

 @end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@implementation Class : Superclass

    @end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_class_member_variables_block_should_not_have_in_interface(self):
        code_string = '''\
@interface Class : Superclass
 {
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>
    {
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_class_member_variables_block_should_not_have_in_interface(self):
        code_string = '''\
@interface Class : Superclass
{
 }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>
{
    }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_class_member_variables_block_should_not_have_in_implementation(self):
        code_string = '''\
@implementation Class
 {
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

        code_string = '''\
@implementation Class
    {
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_class_member_variables_block_should_not_have_in_implementation(self):
        code_string = '''\
@implementation Class
{
 }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@implementation Class
{
    }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_class_member_variables_block_should_be_single_character_in_line_in_interface(self):
        code_string = '''\
@interface Class : Superclass
{ line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_class_member_variables_block_should_be_single_character_in_line_in_implementation(self):
        code_string = '''\
@interface Class : Superclass
{
    line; }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_of_class_member_variables_block_should_be_single_character_in_line_in_implementation(self):
        code_string = '''\
@implementation Class
{ line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_class_member_variables_block_should_be_single_character_in_line_in_implementation(self):
        code_string = '''\
@implementation Class
{
    line; }

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Newline character is missed"])

    def test_raises_error_access_modifiers_should_have_one_whitespace_symbols_indent(self):
        code_string = '''\
@interface Class : Superclass
{
@public
    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass
{
@private
    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass
{
@protected
    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass
{
  @public
    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass
{
  @private
    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass
{
  @protected
    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass
{
    @public
    line;

    @private
    line;

    @protected
    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3, 6, 9], [None, None, None], ["Wrong string indent", "Wrong string indent", "Wrong string indent"])

    def test_raises_error_member_variables_should_have_four_whitespace_symbols_indent_in_class_interface(self):
        code_string = '''\
@interface Class : Superclass
{
   line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass
{
     line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@interface Class : Superclass
{
   line;

     line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3, 5], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_member_variables_should_have_four_whitespace_symbols_indent_in_class_implementation(self):
        code_string = '''\
@implementation Class
{
   line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@implementation Class
{
     line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
@implementation Class
{
   line;

     line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3, 5], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_class_implementation_block(self):
        code_string = '''\
@implementation Class
{

    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

        code_string = '''\
@implementation Class
{

}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace_of_class_implementation_block(self):
        code_string = '''\
@implementation Class
{
    line;

}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_class_interface_block(self):
        code_string = '''\
@interface Class : Superclass
{

    line;
}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

        code_string = '''\
@interface Class : Superclass
{

}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace_of_class_implementation_block(self):
        code_string = '''\
@interface Class : Superclass
{
    line;

}

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])