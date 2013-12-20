#!/usr/bin/python

# TestBlockSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestBlockSyntax(BaseTestClass):

    def test_does_not_raise_error_with_correct_syntax_of_block_on_one_row_without_arguments(self):
        code_string = '''\
[object setCompletionBlock:^{ line; }];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_block_on_one_row_with_arguments(self):
        code_string = '''\
[object setCompletionBlock:^(Class *theObject, BOOL theIsFinished){ line; }];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_block_on_several_lines_without_arguments(self):
        code_string = '''\
[object setCompletionBlock:^
{
    line;
}];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                    }];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_block_on_several_lines_with_arguments(self):
        code_string = '''\
[object setCompletionBlock:^(Class *theObject, BOOL theIsFinished)
{
    line;
}];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_of_block_on_one_row_without_arguments(self):
        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^{ line; }];
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_of_block_on_one_row_with_arguments(self):
        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^(Class *theObject, BOOL theIsFinished){ line; }];
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_of_block_on_several_lines_without_arguments(self):
        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^{ line; }];
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_of_block_on_several_lines_with_arguments(self):
        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^(Class *theObject, BOOL theIsFinished)
    {
        line;
    }];
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indent_of_method_with_few_block_arguments(self):
        code_string = '''\
[self convertDataToDictionary:theData
            onCompletionBlock:^(NSDictionary *theDictionary)
            {
                line;
            }
           onServerErrorBlock:^
            {
                [UIView animateWithDuration:ANIMATION_DURATION
                                                   animations:^
                                                    {
                                                        line;
                                                    }
                                                    completion:^(BOOL theFinished)
                                                    {
                                                        line;
                                                    }];
            }];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_block_declaration_as_argument_in_method_declaration(self):
        code_string = '''\
- (void)performBlock:(void (^)(Class *theObject))theBlock;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
- (void)performBlock:(Class * (^)(void))theBlock;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
- (void)performBlock:(Class * (^)(Class *theObject, NSInteger theValue, Error *theError))theBlock;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_block_declaration_as_argument_in_method_implementation(self):
        code_string = '''\
- (void)performBlock:(void (^)(Class *theObject))theBlock
{
    line;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
- (void)performBlock:(Class * (^)(void))theBlock
{
    line;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
- (void)performBlock:(Class * (^)(Class *theObject, NSInteger theValue, Error *theError))theBlock
{
    line;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_if_block_inside_block(self):
        code_string = '''\
[object performBlock:^(void)
{
    if (result)
    {
        line;
    }
}];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_block_assignment_without_return_type(self):
        code_string = '''\
void (^blockName)(void) = ^(void)
{
    line;
};'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_of_block_as_C_method_argument(self):
        code_string = '''\
- (void)method
{
    dispatch_sync(dispatch_get_main_queue(), ^
    {
        line;
    });
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_indents_of_block_without_arguments_in_braces(self):
        code_string = '''\
[self performBlock:^()
{
    [self performMethod];
}];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_C_method_after_block_expression_without_arguments(self):
        code_string = '''\
for (i = 0; i < 10; i++)
{
    [self performBlock:^
    {
    }];
}

switch (foo)
{
    case value:
    {
        assert(webServiceManager);
        break;
    }
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_block_arguments_after_block_without_arguments(self):
        code_string = '''\
[object block:^{}];

void (^blockName)(Class *theObject) = ^(Class *theObject){ };'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_argument_in_block_which_conform_to_protocol(self):
        code_string = '''\
[self performBlock:^(id<Protocol> theObject){ }];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_arguments_in_block_which_conform_to_protocol(self):
        code_string = '''\
[self performBlock:^(id<Protocol> theObject, NSObject<Delegate> theFoo){ }];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_block_with_arguments_which_separated_by_newline_character(self):
        code_string = '''\
[object setCompletionBlock:^(NSObject *theObject,
                             BOOL theIsFinished)
{
    line;
}];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[object setOnSuccessBlock:^(NSObject *theObject,
                            BOOL theIsFinished)
{
    line;
}
              onFailBlock:^(NSObject *theObject,
                            BOOL theIsFinished)
                {
                    line;
                }];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_block_declaration_inside_block(self):
        code_string = '''\
[self performBlock:^(Class *theObject)
{
    void (^block)(Class *theObject) = ^(Class *theObject)
    {
        line;
    };
}];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_whitespace_should_not_be_before_block_caret_symbol(self):
        code_string = '''\
[object setCompletionBlock: ^{ line; }];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [28], ["Wrong whitespace count"])

        code_string = '''\
[object setCompletionBlock:    ^{ line; }];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [31], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_block_caret_symbol_without_arguments(self):
        code_string = '''\
[object setCompletionBlock:^ { line; }];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [29], ["Wrong whitespace count"])

        code_string = '''\
[object setCompletionBlock:^    { line; }];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [32], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_open_brace_of_block(self):
        code_string = '''\
[object setCompletionBlock:^{line; }];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [29], ["Wrong whitespace count"])

        code_string = '''\
[object setCompletionBlock:^{  line; }];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [31], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_close_brace_of_block(self):
        code_string = '''\
[object setCompletionBlock:^{ line;}];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [35], ["Wrong whitespace count"])

        code_string = '''\
[object setCompletionBlock:^{ line;  }];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [37], ["Wrong whitespace count"])

    def test_raises_error_empty_line_should_not_be_before_open_brace_of_block(self):
        code_string = '''\
[object setCompletionBlock:^

{
    line;
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

    def test_raises_error_string_of_method_invocation_with_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
   [object setCompletionBlock:^
    {
        line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
     [object setCompletionBlock:^
    {
        line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^
   {
        line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^
     {
        line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    Class *var = [object setCompletionBlock:^
   {
        line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    Class *var = [object setCompletionBlock:^
     {
        line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^
    {
       line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^
    {
         line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^
    {
       line;

         line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5, 7], [None, None], ["Wrong string indent", "Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    Class *var = [object setCompletionBlock:^
    {
       line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    Class *var = [object setCompletionBlock:^
    {
         line;
    }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^
    {
        line;
   }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    [object setCompletionBlock:^
    {
        line;
     }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    Class *var = [object setCompletionBlock:^
    {
        line;
   }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)fooMethod
{
    Class *var = [object setCompletionBlock:^
    {
        line;
     }];
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_block_should_be_single_character_in_line(self):
        code_string = '''\
[object setCompletionBlock:^
{ line;
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_close_brace_of_block_should_be_single_character_in_line(self):
        code_string = '''\
[object setCompletionBlock:^
{
    line; }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Newline character is missed"])

    def test_raises_error_newline_character_should_not_be_after_block_caret_symbol_when_whole_block_on_one_line(self):
        code_string = '''\
[object setCompletionBlock:^
{ line; }];'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Newline character is missed"])

    def test_raises_error_square_brace_should_be_on_the_same_line_where_close_block_brace(self):
        code_string = '''\
[object setCompletionBlock:^{ line; }
];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [None], ["Too much newline characters"])

    def test_raises_error_whitespace_should_not_be_between_square_brace_and_close_block_brace(self):
        code_string = '''\
[object setCompletionBlock:^{ line; } ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [38], ["Wrong whitespace count"])

        code_string = '''\
[object setCompletionBlock:^{ line; }    ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [41], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_pointer_in_block_declaration_as_argument_in_method_declaration(self):
        code_string = '''\
- (void)performBlock:(void (^)(Class*theObject))theBlock;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [36], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(void (^)(Class  *theObject))theBlock;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [38], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(Class* (^)(void))theBlock;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [27], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(Class  * (^)(void))theBlock;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [29], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_pointer_in_block_declaration_as_argument_in_method_declaration(self):
        code_string = '''\
- (void)performBlock:(void (^)(Class * theObject))theBlock;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [39], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(void (^)(Class *  theObject))theBlock;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [40], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_pointer_in_return_type_in_block_declaration(self):
        code_string = '''\
- (void)performBlock:(Class *  (^)(void))theBlock;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [31], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(Class *    (^)(void))theBlock;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [33], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_pointer_in_block_declaration_as_argument_in_method_implementation(self):
        code_string = '''\
- (void)performBlock:(void (^)(Class*theObject))theBlock
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [36], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(void (^)(Class  *theObject))theBlock
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [38], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(Class* (^)(void))theBlock
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [27], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(Class  * (^)(void))theBlock
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [29], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_pointer_in_block_declaration_as_argument_in_method_implementation(self):
        code_string = '''\
- (void)performBlock:(void (^)(Class * theObject))theBlock
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [39], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(void (^)(Class    *theObject))theBlock
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [40], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(Class *  (^)(void))theBlock
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [31], ["Wrong whitespace count"])

        code_string = '''\
- (void)performBlock:(Class     * (^)(void))theBlock
{
    line;
}'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [32], ["Wrong whitespace count"])

    def test_raises_error_if_expression_string_should_have_four_whitespace_symbols_indent_inside_block(self):
        code_string = '''\
[object performBlock:^(void)
{
   if (result)
    {
        line;
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
     if (result)
    {
        line;
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_open_brace_of_if_block_should_have_four_whitespace_symbols_indent_inside_block(self):
        code_string = '''\
[object performBlock:^(void)
{
    if (result)
   {
        line;
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
    if (result)
     {
        line;
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_if_block_should_have_four_whitespace_symbols_indent_inside_block(self):
        code_string = '''\
[object performBlock:^(void)
{
    if (result)
    {
        line;
   }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
    if (result)
    {
        line;
     }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_if_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
[object performBlock:^(void)
{
    if (result)
    {
       line;
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
    if (result)
    {
         line;
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
    if (result)
    {
       line;

         line;
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [5, 7], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_open_brace_of_internal_block_should_have_four_whitespace_symbols_indent_inside_block(self):
        code_string = '''\
[object performBlock:^(void)
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^
                       {
                            line;
                        }];
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^
                         {
                            line;
                        }];
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_internal_block_should_have_four_whitespace_symbols_indent_inside_block(self):
        code_string = '''\
[object performBlock:^(void)
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^
                        {
                            line;
                       }];
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^
                        {
                            line;
                         }];
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [7], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_internal_block_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
[object performBlock:^(void)
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^
                        {
                           line;
                        }];
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^
                        {
                             line;
                        }];
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
[object performBlock:^(void)
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^
                        {
                           line;

                             line;
                        }];
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [6, 8], [None, None], ["Wrong string indent", "Wrong string indent"])

    def test_raises_error_open_brace_of_block_as_C_method_argument_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)method
{
    dispatch_sync(dispatch_get_main_queue(), ^
   {
        line;
    });
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

        code_string = '''\
- (void)method
{
    dispatch_sync(dispatch_get_main_queue(), ^
     {
        line;
    });
}'''

        # verify
        self.will_raise_error_with_code(code_string, [4], [None], ["Wrong string indent"])

    def test_raises_error_code_inside_block_as_C_method_argument_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)method
{
    dispatch_sync(dispatch_get_main_queue(), ^
    {
       line;
    });
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
- (void)method
{
    dispatch_sync(dispatch_get_main_queue(), ^
    {
         line;
    });
}'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_block_as_C_method_argument_should_have_four_whitespace_symbols_indent(self):
        code_string = '''\
- (void)method
{
    dispatch_sync(dispatch_get_main_queue(), ^
    {
        line;
   });
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

        code_string = '''\
- (void)method
{
    dispatch_sync(dispatch_get_main_queue(), ^
    {
        line;
     });
}'''

        # verify
        self.will_raise_error_with_code(code_string, [6], [None], ["Wrong string indent"])

    def test_raises_error_empty_line_should_not_be_after_open_brace_of_block(self):
        code_string = '''\
[object setCompletionBlock:^
{

    line;
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

        code_string = '''\
[object setCompletionBlock:^
{

}];'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [None], ["Too much newline characters"])

    def test_raises_error_empty_line_should_not_be_before_close_brace_of_block(self):
        code_string = '''\
[object setCompletionBlock:^
{
    line;

}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Too much newline characters"])

    def test_raises_error_open_brace_of_block_should_have_whitespace_indent_multiple_of_tab_and_after_first_symbol(self):
        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                {
                        line;
                    }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                 {
                        line;
                    }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                  {
                        line;
                    }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                   {
                        line;
                    }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                     {
                        line;
                    }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                      {
                        line;
                    }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                       {
                        line;
                    }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                        {
                        line;
                    }];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [None], ["Wrong string indent"])

    def test_raises_error_close_brace_of_block_should_have_whitespace_indent_multiple_of_tab_and_after_first_symbol(self):
        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                }];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                 }];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                  }];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                   }];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                     }];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                      }];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                       }];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])

        code_string = '''\
[UIView animateWithDuration:ANIMATION_DURATION
                 animations:^
                    {
                        line;
                        }];'''

        # verify
        self.will_raise_error_with_code(code_string, [5], [None], ["Wrong string indent"])
