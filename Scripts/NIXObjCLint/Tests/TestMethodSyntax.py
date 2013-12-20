#!/usr/bin/python

# TestMethodSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestMethodSyntax(BaseTestClass):

    def test_does_not_raise_error_in_simple_instance_method_without_arguments(self):
        code_string = '''\
- (void)fooMethod
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_in_simple_class_method_without_arguments(self):
        code_string = '''\
+ (void)fooMethod
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_in_method_with_argument(self):
        code_string = '''\
+ (void)fooMethod:(Class *)theObject
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_in_method_with_two_arguments(self):
        code_string = '''\
- (void)fooMethodWithObject1:(Class *)theObject1 object2:(Class)theObject2
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_in_method_with_three_arguments(self):
        code_string = '''\
+ (void)fooMethodWithObject1:(Class *)theObject1 object2:(Class)theObject2 object3:(id)theObject3
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_in_method_with_arguments_in_new_line(self):
        code_string = '''\
+ (void)fooMethodWithObject1:(Class *)theObject1
                     object2:(Class)theObject2
                     object3:(id)theObject3
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_after_method_type_identifier(self):
        code_string = '''\
- (void)fooMethod
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
line;
+ (void)fooMethod
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespaces_before_method_type_identifier(self):
        code_string = '''\
- (void)fooMethod
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
line;
+ (void)fooMethod
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_before_pointer_symbol(self):
        code_string = '''\
- (Class *)fooMethodWithObject1:(Class *)theObject1 object2:(Foo *)theObject2
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespaces_inside_brackets_of_type_definition(self):
        code_string = '''\
- (Class *)fooMethodWithObject1:(Class *)theObject1
                        object2:(id)theObject2
                        object3:(Foo *)theObject3
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespaces_around_colon(self):
        code_string = '''\
- (Class *)fooMethodWithObject1:(Class *)theObject1
                        object2:(id)theObject2
                        object3:(Foo *)theObject3
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_in_method_syntax(self):
        code_string = '''\
- (void)fooMethod
{
    line;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_empty_line_between_implementation_of_methods(self):
        code_string = '''\
- (void)method1
{
    line;
}

- (void)method2
{
    line;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_blank_line_in_the_end_of_file(self):
        code_string = '''\
+ (void)method
{
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_blank_line_in_the_end_of_file(self):
        code_string = '''\
+ (void)method
{
}
'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_c_method_as_target_object_in_method_invocation(self):
        code_string = '''\
[UIImagePNGRepresentation(thePhoto) base64EncodedString];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_whitespace_should_be_after_method_type_identifier(self):
        code_string = '''\
-(void)fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [1], ["Wrong whitespace count"])

        code_string = '''\
line;
+  (void)fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [3], ["Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_before_method_type_identifier(self):
        code_string = '''\
 - (void)fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Wrong string indent"])

        code_string = '''\
line;
    + (void)fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

    def test_raises_error_one_whitespace_should_be_before_pointer_symbol(self):
        code_string = '''\
- (Class*)fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
+ (void)fooMethodWithObject:(Class*)theObject
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [34], ["Wrong whitespace count"])

        code_string = '''\
- (Class  *)fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

        code_string = '''\
+ (void)fooMethodWithObject:(Class   *)theObject
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [37], ["Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_inside_brackets_of_return_type_definition(self):
        code_string = '''\
- ( Class)fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [4], ["Wrong whitespace count"])

        code_string = '''\
line;
+ (Class * )fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [11], ["Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_inside_brackets_of_parameter_type_definition(self):
        code_string = '''\
- (Class *)fooMethodWithObject:( Class)theObject
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [33], ["Wrong whitespace count"])

        code_string = '''\
line;
+ (Class *)fooMethodWithObject:(id)theObject object2:(Class * )theObject2
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [62], ["Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_inside_brackets_before_parameter_type_definition_in_new_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject:(   Class)theObject
                       object2:( id)theObject2
                       object3:(  Foo *)theObject3
{
}'''

        # verify
        self.will_raise_error_with_code(code_string,
                                     [1,   2,  3],
                                     [35, 33, 34],
                                     ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_inside_brackets_after_parameter_type_definition_in_new_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject:(Class   )theObject
                       object2:(id  )theObject2
                       object3:(Foo * )theObject3
{
}'''

        # verify
        self.will_raise_error_with_code(code_string,
                                     [1, 2, 3],
                                     [40, 36, 38],
                                     ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_inside_brackets_on_the_sides_of_parameter_type_definition_in_new_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject:( Class )theObject
                       object2:(   id  )theObject2
                       object3:(    Foo * )theObject3
{
}'''

        # verify
        self.will_raise_error_with_code(code_string,
                                     [1, 1, 2, 2, 3, 3],
                                     [33, 39, 35, 39, 36, 42],
                                     ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_around_colon(self):
        code_string = '''\
- (Class *)fooMethodWithObject :(Class)theObject
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [31], ["Wrong whitespace count"])

        code_string = '''\
line;
+ (Class *)fooMethodWithObject: (id)theObject
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [32], ["Wrong whitespace count"])

        code_string = '''\
line;
line;
+ (Class *)fooMethodWithObject : (Class *)theObject
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3, 3], [31, 33], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_before_colon_in_new_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject  :(Class)theObject
                       object2 :(id)theObject2
                       object3 :(Foo *)theObject3
{
}'''

        # verify
        self.will_raise_error_with_code(code_string,
                                     [1, 2, 3],
                                     [32, 31, 31],
                                     ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_whitespaces_should_not_be_after_colon_in_new_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject:   (Class)theObject
                       object2: (id)theObject2
                       object3:  (Foo *)theObject3
{
}'''

        # verify
        self.will_raise_error_with_code(code_string,
                                     [1, 2, 3],
                                     [34, 32, 33],
                                     ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_on_the_sides_of_colon_in_new_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject : (Class)theObject
                       object2  :   (id)theObject2
                       object3  : (Foo *)theObject3
{
}'''

        # verify
        self.will_raise_error_with_code(code_string,
                                     [1, 1, 2, 2, 3, 3],
                                     [31, 33, 32, 36, 32, 34],
                                     ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_after_type_definition(self):
        code_string = '''\
- (Class *) fooMethod
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [12], ["Wrong whitespace count"])

        code_string = '''\
line;
+ (Class *)fooMethodWithObject:(id) theObject
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [36], ["Wrong whitespace count"])

        code_string = '''\
line;
line;
+ (Class *)fooMethodWithObject:(Class *)theObject object2:(Class *)  theObject2
{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [69], ["Wrong whitespace count"])

    def test_raises_error_whitespaces_should_not_be_after_type_definition_in_new_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject:(Class)  theObject
                       object2:(id) theObject2
                       object3:(Foo *)   theObject3
{
}'''

        # verify
        self.will_raise_error_with_code(code_string,
                                     [1, 2, 3],
                                     [40, 36, 41],
                                     ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_open_brace_should_be_in_new_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject:(Class)theObject
                       object2:(id)theObject2
                       object3:(Foo *)theObject3 {
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Newline character is missed"])

    def test_raises_error_open_brace_should_be_single_character_in_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject:(Class)theObject
                       object2:(id)theObject2
                       object3:(Foo *)theObject3
{ foo
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_should_be_single_character_in_line(self):
        code_string = '''\
- (Class *)fooMethodWithObject:(Class)theObject
                       object2:(id)theObject2
                       object3:(Foo *)theObject3
{
    foo }'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Newline character is missed"])

    def test_raises_error_empty_line_should_not_be_before_open_brace(self):
        code_string = '''\
- (Class *)fooMethodWithObject:(Class)theObject
                       object2:(id)theObject2
                       object3:(Foo *)theObject3

{
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_after_open_brace(self):
        code_string = '''\
- (void)foo
{

    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

        code_string = '''\
- (void)foo
{

}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace(self):
        code_string = '''\
- (void)foo
{
    line;

}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_open_brace_of_method_implementation_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
 {
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
     {
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_method_implementation_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    line;
 }'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    line;
    }'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_method_implementation_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
   line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
     line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
   line;

     line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3, 5], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_one_empty_line_should_be_between_implementation_of_methods(self):
        code_string = '''\
- (void)method1
{
    line;
}
- (void)method2
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong newline count"])

        code_string = '''\
- (void)method1
{
    line;
}


- (void)method2
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong newline count"])

    def test_raises_error_with_several_blank_lines_in_the_end_of_file(self):
        code_string = '''\
+ (void)method
{
}


'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong newline count"])