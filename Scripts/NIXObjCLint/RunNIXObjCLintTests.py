#!/usr/bin/env python

# RunNIXObjCLintTests.py
# NIXObjCLint
#
# Created by Egor Zubkov on 12/10/12.
# Copyright 2012 nix. All rights reserved.

import os
import nose
import sys

if __name__ == '__main__':
    result = nose.run(argv=['', '--where=%s' % os.path.dirname(__file__), '--verbosity=2', '--nocapture'])
    sys.exit(result is not True)