#!/usr/bin/python

# TestWhitespaceSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestWhitespaceSyntax(BaseTestClass):

    def test_does_not_raise_error_without_whitespace_after_pointer_symbol(self):
        code_string = '''\
NSString *string;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_before_semicolon(self):
        code_string = '''\
NSString *string = @"some text";

int value = [object someValue];
BOOL isExist = YES;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_before_and_inside_interface_block_in_object_definition(self):
        code_string = '''\
id<InterfaceProtocol> object;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
id<InterfaceProtocol> object;

NSObject<InterfaceProtocol> *object;
Class<InterfaceProtocol> object;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_after_property_word(self):
        code_string = '''\
@property(nonatomic, strong) NSInteger currentValue;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@property(nonatomic, strong) Class *currentValue;
@property(nonatomic, assign) id currentValue;

@property(nonatomic) BOOL currentValue;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespaces_after_open_brace_and_before_close_brace_in_method_invocation(self):
        code_string = '''\
[self performMethod];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespaces_around_colon_in_method_invocation(self):
        code_string = '''\
[self performMethodWithName:theName];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[object performMethodWithName:theName age:theAge];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[self performMethodWithName:theName
                        age:theAge];

[self performMethodWithName:theName age:[self age]];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_any_whitespace_symbols_before_assignment_operator(self):
        code_string = '''\
int count = 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSString string    = @"Some text";'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count += 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count    -= 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count   *= 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count      /= 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
object     = [self currentFoo];
count += 3;
count    -= 3;
count   *= 3;
count      /= 3;
Class *object     = temp;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_any_whitespace_symbols_after_assignment_operator(self):
        code_string = '''\
int count = 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count += 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count -=    3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count *=   3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count /=      3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSString string =    @"Some text";'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
object =     [self currentFoo];

Class *object =     temp;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_any_whitespace_symbols_before_compare_operator(self):
        code_string = '''\
count > 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
string    == @"Some text";'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
3    < 1'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isSelected    != YES'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
object     <= [self currentFoo];
object != temp;
object   == temp;
object    >= temp;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_any_whitespace_symbols_after_compare_operator(self):
        code_string = '''\
count > 3;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
string ==    @"Some text";'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
3 <    1'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isSelected !=    YES'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
object <=     [self currentFoo];
object != temp;
object ==   temp;
object >=    temp;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_any_whitespace_symbols_before_boolean_operator(self):
        code_string = '''\
isExist || [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isExist   || [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isExist && [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isExist    && [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isExist    && [self isSelected];

isExist   || [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_any_whitespace_symbols_after_boolean_operator(self):
        code_string = '''\
isExist || [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isExist ||   [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isExist && [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isExist &&    [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
isExist &&     [self isSelected];

isExist ||   [self isSelected];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_before_or_after_increment_operator(self):
        code_string = '''\
count++;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
++count;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count++;

++count;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_before_or_after_decrement_operator(self):
        code_string = '''\
count--;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
--count;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
count--;

--count;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_selector_definition(self):
        code_string = '''\
@selector(foo)'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_whitespace_in_separated_list_by_comma(self):
        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1, InterfaceProtocol2, InterfaceProtocol3>

@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSArray *list = [NSArray arrayWithObjects:@"text", [NSNumber numberWithBool:YES], [NSNull null], nil];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
@property(nonatomic, copy) void (^loginCompletionBlock)(NSArray *theList, Class *theObject, BOOL theIsSelected);'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_whitespace_around_arithmetic_symbols(self):
        code_string = '''\
value = 3 + foo;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
value = 3 - foo;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
value = 3 * foo;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
value = 3 / foo;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
value = (3 - foo) * 4;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
value = (3 + foo) / 4;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_between_pointers(self):
        code_string = '''\
- (void)performMethodWithError:(NSError **)theError;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_around_colon_of_ternary_operator_as_method_argument(self):
        code_string = '''\
[object setText:isExist == NO ? @"" : [self someText]];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[object setText:(isExist == NO) ? @"" : [self someText]];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_method_in_ternary_operator(self):
        code_string = '''\
[self isUserAuthorized] ? [self performMethodWithObject:foo] : nil;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[self isUserAuthorized] ? [[[DBSession sharedSession] userIds] objectAtIndex:0] : nil;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_without_whitespace_before_open_brace_of_C_method(self):
        code_string = '''\
method();'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[method() performMethod];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[method() performMethodWithObject:object];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_symbol_around_XOR_operator(self):
        code_string = '''\
NSInteger val = val1 ^ val2;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
NSInteger val = [self val1] ^ val2 ^ [object val3];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_method_syntax_inside_for_expression(self):
        code_string = '''\
for (id object in [self objectsWithParameter:parameter])
{
    line;
}'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_after_close_brace_of_type_conversion(self):
        code_string = '''\
[(Class *)object performMethod];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
int x = (int)charValue * 10;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_syntax_of_blocks_as_property_where_the_first_one_without_parameters(self):
        code_string = '''\
@property(nonatomic, copy) void (^successBlock)();
@property(nonatomic, copy) void (^errorBlock)(NSError *theError);'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_whitespace_around_star_symbol_in_for_expression_inside_block(self):
        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (Class *object in objects)
    {
    }
}];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (int i = width * height; i < 100; i++)
    {
    }
}];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_string_which_contains_only_whitespace_symbols(self):
        code_string = '''\

line;

line;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_symbol_after_double_slash_in_single_comment_in_line(self):
        code_string = '''\
// comment'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_symbol_after_double_slash_in_comment_after_code(self):
        code_string = '''\
line; // comment'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_several_whitespace_symbols_after_double_slash_in_single_comment_in_line(self):
        code_string = '''\
//  comment'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
//       comment'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_several_whitespace_symbols_after_double_slash_in_comment_after_code(self):
        code_string = '''\
line; //  comment'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
line; //          comment'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_around_protocol_braces(self):
        code_string = '''\
[(id<Protocol>)object performMethod];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_without_whitespace_around_scope_resolution_operator(self):
        code_string = '''\
std::foo'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
class ClassName : public ClassName
{
    std::foo;
};
'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_several_whitespace_symbols_between_type_and_name_of_variable(self):
        code_string = '''\
NSUinteger  count;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

        code_string = '''\
int    count = 10;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_before_and_after_keyword_between_two_pointer_stars(self):
        code_string = '''\
- (void)error:(NSError * __strong *)theError;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_dictionary_literal_syntax_as_method_parameter(self):
        code_string = '''\
[self foo:@{key : value}
    value:value];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_IBOutletCollection_syntax(self):
        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView) NSArray *views;'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_one_whitespace_after_number_literal(self):
        code_string = '''\
[@(5) stringValue];'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_does_not_raise_error_with_correct_static_variable_syntax_in_class_implementation(self):
        code_string = '''\
@implementation Class ()
static NSString *const VisiblePopoverAssociationKey;
@end'''

        # verify
        self.will_not_raise_error_with_code(code_string)

    def test_raises_error_whitespace_should_not_be_after_pointer_symbol_for_static_variable_syntax_in_class_implementation(self):
        code_string = '''\
@implementation Class ()
static NSString * const VisiblePopoverAssociationKey;
@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [18], ["Wrong whitespace count"])

        code_string = '''\
@implementation Class ()
static NSString *      const VisiblePopoverAssociationKey;
@end'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [23], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_pointer_symbol(self):
        code_string = '''\
NSString * string;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
NSString   *    string;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [16], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_semicolon(self):
        code_string = '''\
NSString *string ;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [17], ["Wrong whitespace count"])

        code_string = '''\
NSString *string = @"some text"   ;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [34], ["Wrong whitespace count"])

        code_string = '''\
NSString *string = @"some text"   ;

int value = [object someValue]  ;
BOOL isExist = YES     ;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3, 4], [34, 32, 23], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_interface_block_in_object_definition(self):
        code_string = '''\
id <InterfaceProtocol> object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [3], ["Wrong whitespace count"])

        code_string = '''\
id   <InterfaceProtocol> object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
id   <InterfaceProtocol> object;

NSObject  <InterfaceProtocol> *object;
Class <InterfaceProtocol> object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3, 4], [5, 10, 6], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_of_interface_block_in_object_definition(self):
        code_string = '''\
id< InterfaceProtocol> object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [4], ["Wrong whitespace count"])

        code_string = '''\
id<     InterfaceProtocol> object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
id<   InterfaceProtocol> object;

NSObject<  InterfaceProtocol> *object;
Class< InterfaceProtocol> object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3, 4], [6, 11, 7], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_close_brace_of_interface_block_in_object_definition(self):
        code_string = '''\
id<InterfaceProtocol > object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [21], ["Wrong whitespace count"])

        code_string = '''\
id<InterfaceProtocol       > object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [27], ["Wrong whitespace count"])

        code_string = '''\
id<InterfaceProtocol   > object;

NSObject<InterfaceProtocol  > *object;
Class<InterfaceProtocol > object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3, 4], [23, 28, 24], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_property_word(self):
        code_string = '''\
@property (nonatomic, strong) NSInteger currentValue;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

        code_string = '''\
@property (nonatomic, strong) Class *currentValue;
@property   (nonatomic, assign) id currentValue;

@property     (nonatomic) BOOL currentValue;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 2, 4], [10, 12, 14], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_in_method_invocation(self):
        code_string = '''\
[ self performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [2], ["Wrong whitespace count"])

        code_string = '''\
[      self performMethodWithName:theName
                        age:theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_in_method_invocation(self):
        code_string = '''\
[self performMethod ];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [20], ["Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName:theName
                        age:theAge     ];'''

        # verify
        self.will_raise_error_with_code(code_string, [2], [39], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_colon_in_method_invocation(self):
        code_string = '''\
[self performMethodWithName :theName];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [28], ["Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName :theName age     :theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [28, 45], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName :theName
                        age     :theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 2], [28, 32], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName   :theName];

[self performMethodWithName  :theName age   :theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3, 3], [30, 29, 44], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_colon_in_method_invocation(self):
        code_string = '''\
[self performMethodWithName: theName];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [29], ["Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName: theName age:     theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [29, 46], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName: theName
                        age:     theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 2], [29, 33], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName:   theName];

[self performMethodWithName:  theName age:   theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3, 3], [31, 30, 45], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_around_colon_in_method_invocation(self):
        code_string = '''\
[self performMethodWithName  : theName];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [29, 31], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName   : theName age   :     theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1, 1, 1], [30, 32, 46, 52], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName   : theName
                        age  :     theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1, 2, 2], [30, 32, 29, 35], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
[self performMethodWithName     :   theName];

[self performMethodWithName     :  theName age  :   theAge];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1, 3, 3, 3, 3], [32, 36, 32, 35, 48, 52], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_be_before_assignment_operator(self):
        code_string = '''\
NSString string= @"Some text";'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [15], ["Wrong whitespace count"])

        code_string = '''\
count+= 3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
count-= 3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
count*= 3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
count/= 3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
object= [self currentFoo];

Class *object= temp;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3], [6, 13], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_be_before_assignment_operator(self):
        code_string = '''\
NSString string =@"Some text";'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [17], ["Wrong whitespace count"])

        code_string = '''\
count +=3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
count -=3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
count *=3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
count /=3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
object =[self currentFoo];

Class *object =temp;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3], [8, 15], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_be_before_compare_operator(self):
        code_string = '''\
count> 3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
string== @"Some text";'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Wrong whitespace count"])

        code_string = '''\
3< 1'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [1], ["Wrong whitespace count"])

        code_string = '''\
isSelected!= YES'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

        code_string = '''\
object<= [self currentFoo];
object!= temp;
object== temp;
object>= temp;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 2, 3, 4], [6, 6, 6, 6], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_be_before_compare_operator(self):
        code_string = '''\
count >3;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
string ==@"Some text";'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

        code_string = '''\
3 <1'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [3], ["Wrong whitespace count"])

        code_string = '''\
isSelected !=YES'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

        code_string = '''\
object <=[self currentFoo];
object !=temp;
object ==temp;
object >=temp;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 2, 3, 4], [9, 9, 9, 9], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_be_before_boolean_operator(self):
        code_string = '''\
isExist|| [self isSelected];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
isExist&& [self isSelected];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
isExist&& [self isSelected];

isExist|| [self isSelected];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3], [7, 7], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_be_after_boolean_operator(self):
        code_string = '''\
isExist ||[self isSelected];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

        code_string = '''\
isExist &&[self isSelected];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

        code_string = '''\
isExist &&[self isSelected];

isExist ||[self isSelected];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 3], [10, 10], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_or_after_increment_operator(self):
        code_string = '''\
count ++;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Wrong whitespace count"])

        code_string = '''\
count    ++;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

        code_string = '''\
++ count;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [3], ["Wrong whitespace count"])

        code_string = '''\
++     count;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
count ++;
++  count;
count    ++;
++   count;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 2, 3, 4], [6, 4, 9, 5], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_or_after_decrement_operator(self):
        code_string = '''\
count --;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Wrong whitespace count"])

        code_string = '''\
count    --;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

        code_string = '''\
-- count;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [3], ["Wrong whitespace count"])

        code_string = '''\
--     count;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
count --;
--  count;
count    --;
--   count;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 2, 3, 4], [6, 4, 9, 5], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_selector_word(self):
        code_string = '''\
@selector (foo)'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_brace_of_selector_definition(self):
        code_string = '''\
@selector( foo)'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
@selector(     foo)'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [15], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_brace_of_selector_definition(self):
        code_string = '''\
@selector(foo )'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [14], ["Wrong whitespace count"])

        code_string = '''\
@selector(foo     )'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [18], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_comma_in_separated_list_by_comma(self):
        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1 , InterfaceProtocol2   , InterfaceProtocol3>

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [49, 72], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
NSArray *list = [NSArray arrayWithObjects:@"text"   , [NSNumber numberWithBool:YES] , [NSNull null], nil];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [52, 84], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
@property(nonatomic, copy) void (^loginCompletionBlock)(NSArray *theList  , Class *theObject    , BOOL theIsSelected);'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [74, 96], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_comma_in_separated_list_by_comma(self):
        code_string = '''\
@interface Class : Superclass<InterfaceProtocol1,InterfaceProtocol2,  InterfaceProtocol3>

@end'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [49, 70], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
NSArray *list = [NSArray arrayWithObjects:@"text",  [NSNumber numberWithBool:YES],[NSNull null], nil];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [52, 82], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
@property(nonatomic, copy) void (^loginCompletionBlock)(NSArray *theList,Class *theObject,   BOOL theIsSelected);'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [73, 93], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_around_sum_sign(self):
        code_string = '''\
value = 3+ foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

        code_string = '''\
value = 3  + foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
value = 3 +foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
value = 3 +  foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_around_minus_sign(self):
            code_string = '''\
value = 3- foo'''

            # verify
            self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

            code_string = '''\
value = 3  - foo'''

            # verify
            self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

            code_string = '''\
value = 3 -foo'''

            # verify
            self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

            code_string = '''\
value = 3 -  foo'''

            # verify
            self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_around_multiplication_sign(self):
        code_string = '''\
value = 3* foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

        code_string = '''\
value = 3  * foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
value = 3 *foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
value = 3 *  foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_around_division_sign(self):
        code_string = '''\
value = 3/ foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

        code_string = '''\
value = 3  / foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
value = 3 /foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
value = 3 /  foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [13], ["Wrong whitespace count"])

    def test_raises_error_whitespace_symbol_should_not_be_between_pointers(self):
        code_string = '''\
- (void)performMethodWithError:(NSError * *)theError;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [42], ["Wrong whitespace count"])

        code_string = '''\
- (void)performMethodWithError:(NSError *    *)theError;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [45], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_before_colon_of_ternary_operator_as_method_argument(self):
        code_string = '''\
[object setText:isExist == NO ? @"": [self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [35], ["Wrong whitespace count"])

        code_string = '''\
[object setText:isExist == NO ? @""  : [self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [37], ["Wrong whitespace count"])

        code_string = '''\
[object setText:(isExist == NO) ? @"": [self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [37], ["Wrong whitespace count"])

        code_string = '''\
[object setText:(isExist == NO) ? @""  : [self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [39], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_after_colon_of_ternary_operator_as_method_argument(self):
        code_string = '''\
[object setText:isExist == NO ? @"" :[self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [37], ["Wrong whitespace count"])

        code_string = '''\
[object setText:isExist == NO ? @"" :  [self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [39], ["Wrong whitespace count"])

        code_string = '''\
[object setText:(isExist == NO) ? @"" :[self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [39], ["Wrong whitespace count"])

        code_string = '''\
[object setText:(isExist == NO) ? @"" :  [self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [41], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_symbol_should_be_around_colon_of_ternary_operator_as_method_argument(self):
        code_string = '''\
[object setText:isExist == NO ? @"":[self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [35, 36], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
[object setText:(isExist == NO) ? @""  :  [self someText]];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [39, 42], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_open_brace_of_C_method(self):
        code_string = '''\
method ();'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
method   ();'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_open_brace_of_C_method_inside_OC_method(self):
        code_string = '''\
[method () performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
[method    () performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
[method () performMethodWithObject:object];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

        code_string = '''\
[method   () performMethodWithObject:object];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [10], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_open_brace_of_C_method_inside_OC_method_as_parameter(self):
        code_string = '''\
[object performMethodWithObject:method ()];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [39], ["Wrong whitespace count"])

        code_string = '''\
[object performMethodWithObject:method     ()];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [43], ["Wrong whitespace count"])

    def test_raises_error_code_one_whitespace_symbol_should_be_before_XOR_operator(self):
        code_string = '''\
NSInteger val = val1^ val2;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [20], ["Wrong whitespace count"])

        code_string = '''\
NSInteger val = val1  ^ val2;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [22], ["Wrong whitespace count"])

        code_string = '''\
NSInteger val = [self val1]  ^ val2^ [object val3];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [29, 35], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_code_one_whitespace_symbol_should_be_after_XOR_operator(self):
        code_string = '''\
NSInteger val = val1 ^val2;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [22], ["Wrong whitespace count"])

        code_string = '''\
NSInteger val = val1 ^  val2;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [24], ["Wrong whitespace count"])

        code_string = '''\
NSInteger val = [self val1] ^  val2 ^[object val3];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [31, 37], ["Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_code_one_whitespace_symbol_should_be_around_XOR_operator(self):
        code_string = '''\
NSInteger val = val1^val2;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [20, 21], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
NSInteger val = val1  ^  val2;'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1], [22, 25], ["Wrong whitespace count", "Wrong whitespace count"])

        code_string = '''\
NSInteger val = [self val1]  ^val2^  [object val3];'''

        # verify
        self.will_raise_error_with_code(code_string, [1, 1, 1, 1], [29, 30, 34, 37], ["Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count", "Wrong whitespace count"])

    def test_raises_error_code_whitespace_should_not_be_after_close_brace_of_type_conversion(self):
        code_string = '''\
[(Class *) object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])

        code_string = '''\
[(Class *)     object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [15], ["Wrong whitespace count"])

        code_string = '''\
int x = (int) charValue * 10;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [14], ["Wrong whitespace count"])

        code_string = '''\
int x = (int)    charValue * 10;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [17], ["Wrong whitespace count"])

    def test_raises_error_code_without_whitespace_before_pointer(self):
        code_string = '''\
Class*object;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
Class*object = [self object];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

    def test_raises_error_code_one_whitespace_symbol_should_be_before_pointer_symbol_in_for_expression_inside_block(self):
        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (Class*object in objects)
    {
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [14], ["Wrong whitespace count"])

        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (Class  *object in objects)
    {
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [16], ["Wrong whitespace count"])

    def test_raises_error_code_whitespace_should_not_be_after_pointer_symbol_in_for_expression_inside_block(self):
        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (Class * object in objects)
    {
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [17], ["Wrong whitespace count"])

        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (Class *    object in objects)
    {
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [20], ["Wrong whitespace count"])

    def test_raises_error_code_one_whitespace_symbol_should_be_before_arithmetic_symbol_in_for_expression_inside_block(self):
        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (int i = width* height; i < 100; i++)
    {
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [22], ["Wrong whitespace count"])

        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (int i = width  * height; i < 100; i++)
    {
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [24], ["Wrong whitespace count"])

    def test_raises_error_code_one_whitespace_symbol_should_be_after_arithmetic_symbol_in_for_expression_inside_block(self):
        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (int i = width *height; i < 100; i++)
    {
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [24], ["Wrong whitespace count"])

        code_string = '''\
[self methodWithCompletionBlock:^(void)
{
    for (int i = width *  height; i < 100; i++)
    {
    }
}];'''

        # verify
        self.will_raise_error_with_code(code_string, [3], [26], ["Wrong whitespace count"])

    def test_raises_error_with_whitespace_in_the_end_of_string(self):
        code_string = '''\
line; '''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Should not be whitespace in the end of the line"])

        code_string = '''\
line;    '''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Should not be whitespace in the end of the line"])

        code_string = '''\
line;

line; '''

        # verify
        self.will_raise_error_with_code(code_string, [3], [6], ["Should not be whitespace in the end of the line"])

    def test_raises_error_whitespace_should_not_be_before_open_protocol_brace(self):
        code_string = '''\
[(id <Protocol>)object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
[(id   <Protocol>)object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_open_protocol_brace(self):
        code_string = '''\
[(id< Protocol>)object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Wrong whitespace count"])

        code_string = '''\
[(id<    Protocol>)object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_close_protocol_brace(self):
        code_string = '''\
[(id<Protocol >)object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [14], ["Wrong whitespace count"])

        code_string = '''\
[(id<Protocol    >)object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [17], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_close_protocol_brace(self):
        code_string = '''\
[(id<Protocol> )object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [15], ["Wrong whitespace count"])

        code_string = '''\
[(id<Protocol>     )object performMethod];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [19], ["Wrong whitespace count"])

    def test_raises_error_without_whitespace_after_double_slash_in_single_comment_in_line(self):
        code_string = '''\
//comment'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [2], ["Wrong whitespace count"])

    def test_raises_error_without_whitespace_after_double_slash_in_comment_after_code(self):
        code_string = '''\
line; //comment'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [8], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_before_scope_resolution_operator(self):
        code_string = '''\
std ::foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [4], ["Wrong whitespace count"])

        code_string = '''\
std    ::foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_between_colons_in_scope_resolution_operator(self):
        code_string = '''\
std: :foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

        code_string = '''\
std:   :foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

    def test_raises_error_whitespace_should_not_be_after_scope_resolution_operator(self):
        code_string = '''\
std:: foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [6], ["Wrong whitespace count"])

        code_string = '''\
std::    foo'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [9], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_should_be_before_keyword_between_two_pointer_stars(self):
        code_string = '''\
- (void)error:(NSError *__strong *)theError;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [24], ["Wrong whitespace count"])

        code_string = '''\
- (void)error:(NSError *  __strong *)theError;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [26], ["Wrong whitespace count"])

        code_string = '''\
- (void)error:(NSError *      __strong *)theError;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [30], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_should_be_after_keyword_between_two_pointer_stars(self):
        code_string = '''\
- (void)error:(NSError * __strong*)theError;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [33], ["Wrong whitespace count"])

        code_string = '''\
- (void)error:(NSError * __strong  *)theError;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [35], ["Wrong whitespace count"])

        code_string = '''\
- (void)error:(NSError * __strong      *)theError;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [39], ["Wrong whitespace count"])

    def test_raises_error_without_whitespace_before_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic)IBOutletCollection(UIView) NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [28], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_should_be_before_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic)  IBOutletCollection(UIView) NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [30], ["Wrong whitespace count"])

    def test_raises_error_with_whitespace_after_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic) IBOutletCollection (UIView) NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [48], ["Wrong whitespace count"])

        code_string = '''\
@property(strong, nonatomic) IBOutletCollection    (UIView) NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [51], ["Wrong whitespace count"])

    def test_raises_error_with_whitespace_after_open_brace_of_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic) IBOutletCollection( UIView) NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [49], ["Wrong whitespace count"])

        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(     UIView) NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [53], ["Wrong whitespace count"])

    def test_raises_error_with_whitespace_before_close_brace_of_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView ) NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [55], ["Wrong whitespace count"])

        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView     ) NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [59], ["Wrong whitespace count"])

    def test_raises_error_without_whitespace_after_close_brace_of_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView)NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [55], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_should_be_after_close_brace_of_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView)  NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [57], ["Wrong whitespace count"])

        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView)      NSArray *array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [61], ["Wrong whitespace count"])

    def test_raises_error_without_whitespace_after_type_object_of_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView) NSArray*array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [63], ["Wrong whitespace count"])

    def test_raises_error_with_whitespace_after_pointer_star_with_IBOutletCollection_keyword(self):
        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView) NSArray * array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [66], ["Wrong whitespace count"])

        code_string = '''\
@property(strong, nonatomic) IBOutletCollection(UIView) NSArray *    array;'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [69], ["Wrong whitespace count"])

    def test_raises_error_without_whitespace_after_number_literal(self):
        code_string = '''\
[@(5)stringValue];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [5], ["Wrong whitespace count"])

    def test_raises_error_one_whitespace_should_be_after_number_literal(self):
        code_string = '''\
[@(5)  stringValue];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [7], ["Wrong whitespace count"])

        code_string = '''\
[@(5)      stringValue];'''

        # verify
        self.will_raise_error_with_code(code_string, [1], [11], ["Wrong whitespace count"])