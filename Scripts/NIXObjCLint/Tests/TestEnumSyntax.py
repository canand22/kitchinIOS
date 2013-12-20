#!/usr/bin/python

# TestEnumSyntax.py
# NIXObjCLint
#
# Created by Egor Zubkov on 05/10/12.
# Copyright 2012 nix. All rights reserved.

from BaseTestClass import BaseTestClass

class TestEnumSyntax(BaseTestClass):

    def test_does_not_raise_error_with_correct_NS_ENUM_syntax(self):
        code_string = '''\
typedef NS_ENUM(NSInteger, ClassType)
{
    ClassType_1,
    ClassType_2
};'''

        # verify
        self.will_not_raise_error_with_code(code_string)