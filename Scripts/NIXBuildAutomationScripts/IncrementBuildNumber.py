#!/usr/bin/python

# Created by Yuri Govorushchenko on 11/29/10.
# Copyright 2010 nix. All rights reserved.

import os
import sys
import optparse
import plistlib
import thread
from threading  import Timer
from subprocess import Popen, PIPE

PLIST_BUILD_NUMBER_KEY      = "CFBundleVersion"
DEFAULT_INCREMENT_STEP      = 1
WAITING_TIME_FOR_REPOSITORY = 10.0

timer = None

def main():
    parser = optparse.OptionParser(description='Script gets latest build number from repository, increments it and writes into local info plist file',
                                   prog='IncrementBuildNumber')
	
    parser.add_option("-f", "--plist",     dest="plist_path",     help="full path to project info plist file",                                 metavar="PLIST")
    parser.add_option("-u", "--username",  dest="username",       help="authorization username",                                               metavar="USERNAME")
    parser.add_option("-p", "--password",  dest="password",       help="authorization password",                                               metavar="PASSWORD")
    parser.add_option("-i", "--increment", dest="increment_step", help="increment step. Should be more than 0. Default value is 1.(optional)", metavar="INCREMENT_NUMBER")
    
    (options, args) = parser.parse_args()
    
    if options.plist_path is None or options.username is None or options.password is None:
        parser.error('All arguments must be specified. Use option -h to see the usage.')
    
    increment_step = DEFAULT_INCREMENT_STEP
    
    if options.increment_step is not None:
        parsed_increment_step = int(options.increment_step)
        if parsed_increment_step > 1:
            increment_step = parsed_increment_step
        
    plist_path = options.plist_path
    username   = options.username
    password   = options.password
    
    if not os.path.isfile(plist_path):
        print_error('file does not exist: %s' % plist_path)
        return 1
    
    try:
        head_build_number = get_head_build_number(plist_path, username, password)
        write_build_number(head_build_number, plist_path)
        update_file(plist_path, username, password)
        write_build_number(head_build_number+increment_step, plist_path)
    except Exception, e:
        timer.cancel()
        print_warning("Couldn't get current app build version from repository. App build version is not increased. (exception: %s)" % e)
    
    return 0

def print_error(error_message):
    """ Prints error message with predefined prefix.
        
        Args:
        error_message: Error message.
        """
    
    XCODE_ERROR_PREFIX = 'error: ' # log messages with such prefix are highlighted in XCode as errors
    
    print('%s%s' % (XCODE_ERROR_PREFIX, error_message))

def print_warning(warning_message):
    """ Prints warning message with predefined prefix.
        
        Args:
        warning_message: Warning message.
        """
    
    XCODE_WARNING_PREFIX = 'warning: ' # log messages with such prefix are highlighted in XCode as warning
    
    print('%s%s' % (XCODE_WARNING_PREFIX, warning_message))

def get_head_build_number(plist_path, username, password):
    url = get_svn_url_for_path(plist_path)
    head_build_number = get_build_number_from_svn_plist(url, username, password)
    
    return head_build_number

def get_svn_url_for_path(plist_path):
    svn_info = Popen(["svn", "info", plist_path], stdin=PIPE, stdout=PIPE)
    output = svn_info.communicate()[0]
    
    SVN_INFO_URL_PREFIX = "URL: "
    
    for line in output.split("\n"):
        if line.startswith(SVN_INFO_URL_PREFIX):
            url = line[len(SVN_INFO_URL_PREFIX):]
            return url

def get_build_number_from_svn_plist(url, username, password):
    svn_get = Popen(["svn", "cat", url, "--username", username, "--password", password], stdin=PIPE, stdout=PIPE)
    
    global timer
    timer = Timer(WAITING_TIME_FOR_REPOSITORY, timeout_waiting_for_repository, [svn_get])
    timer.start()
    
    output = svn_get.communicate()[0]
    
    timer.cancel()
    
    plist = plistlib.readPlistFromString(output)
    
    return int(plist[PLIST_BUILD_NUMBER_KEY])

def update_file(plist_path, username, password):
    plist_updating = Popen(["svn", "update", plist_path, "--username", username, "--password", password], stdin=PIPE, stdout=PIPE)
    plist_updating.communicate()

def write_build_number(build_number, plist_path):
    plist = plistlib.readPlist(plist_path)
    plist[PLIST_BUILD_NUMBER_KEY] = str(build_number)
    plistlib.writePlist(plist, plist_path)

def timeout_waiting_for_repository(svn_process):
    print_warning("Timeout waiting for repository. App build version is not increased.")
    
    svn_process.kill()

if __name__ == '__main__':
    sys.exit(main())