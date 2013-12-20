#!/usr/bin/python

# TestFileTemplateValidator.py
# NIXObjCLint
#
# Created by Egor Zubkov on 03/01/13.
# Copyright 2013 nix. All rights reserved.

import os
from BaseTestClass import BaseTestClass

class TestFileTemplateValidator(BaseTestClass):

    def test_does_not_raise_error_when_file_conforms_to_default_template(self):
        source_filename = "FileToValidate.m"
        code_string = '''\
//
//  %s
//  ProjectName
//
//  Created by Firstname Lastname on 11/11/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//
''' % source_filename

        # verify
        self.will_not_raise_error_with_code(code_string, source_filename, None)

        code_string = '''\
//
//  %s
//  ProjectName
//
//  Created by Firstname Lastname on 7.7.13.
//  Copyright (c) 2013 NIX. All rights reserved.
//
''' % source_filename

        # verify
        self.will_not_raise_error_with_code(code_string, source_filename, None)

    def test_does_not_raise_error_when_file_conforms_to_specify_template(self):
        code_string = '''\
//
// line_1
//
// line_2
//
'''

        # verify
        self.will_not_raise_error_with_code(code_string, "File.h", "^//\n//\sline_1\n//\n//\sline_2\n//\n")

        code_string = '''\
//
line_1
//

line_2;
'''

        # verify
        self.will_not_raise_error_with_code(code_string, "File.h", "^//\nline_1\n//\n.*")

    def test_does_not_raise_error_when_filename_contains_reserved_symbols(self):
        source_filename = "Class+CategoryName.m"
        code_string = '''\
//
//  %s
//  ProjectName
//
//  Created by Firstname Lastname on 11/11/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//
''' % source_filename

        # verify
        self.will_not_raise_error_with_code(code_string, source_filename, None)

    def test_raise_error_when_empty_file_does_not_conform_to_default_template(self):
        code_string = ''''''

        self.will_raise_error_when_file_does_not_conform_to_default_template(code_string, "File.m")

    def test_raise_error_when_file_does_not_conform_to_default_template(self):
        source_filename = "FileToValidate.m"
        code_string = '''\
line;
//
//  %s
//  ProjectName
//
//  Created by Firstname Lastname on 7.7.13.
//  Copyright (c) 2013 NIX. All rights reserved.
//
''' % source_filename

        self.will_raise_error_when_file_does_not_conform_to_default_template(code_string, source_filename)

        code_string = '''\
line;

line;

//
//  %s
//  ProjectName
//
//  Created by Firstname Lastname on 7.7.13.
//  Copyright (c) 2013 NIX. All rights reserved.
//
''' % source_filename

        self.will_raise_error_when_file_does_not_conform_to_default_template(code_string, source_filename)

        code_string = '''\
//
//  Filename
//  ProjectName
//
//  Created by Firstname Lastname on 7.7.13.
//  Copyright (c) 2013 NIX. All rights reserved.
//
'''

        self.will_raise_error_when_file_does_not_conform_to_default_template(code_string, "File.m")

    def test_raise_error_when_file_does_not_conform_to_specify_template(self):
        code_string = '''\
//
// line
//
// line_2
//
'''

        # verify
        self.will_raise_error_when_file_does_not_conform_to_specify_template(code_string, "^//\n//\sline_1\n//\n//\sline_2\n//\n")

        code_string = '''aBc1De'''

        # verify
        self.will_raise_error_when_file_does_not_conform_to_specify_template(code_string, "^[a-zA-Z]+$")

    def will_raise_error_when_file_does_not_conform_to_default_template(self, code_string, source_filename):
        message = '''\
File should conform to default template
See template:

^//
//\s\s%FILE_NAME%
//\s\s[a-zA-Z]{3,}
//
//\s\sCreated\sby\s[A-Z][a-z]+\s[A-Z][a-z]+\son\s(\d){1,2}[/\.](\d){1,2}[/\.](\d){2}.
//\s\sCopyright\s\(c\)\s(\d){4}\sNIX.\sAll\srights\sreserved.
//
.*\n\n'''

        self.will_raise_error_with_code(code_string, [1], [None], [message], source_filename, None)

    def will_raise_error_when_file_does_not_conform_to_specify_template(self, code_string, file_template):
        message = '''\
File should conform to specify template
See template in the file by path:

%s\n\n''' % self.file_template_path

        self.will_raise_error_with_code(code_string, [1], [None], [message], "File.m", file_template)