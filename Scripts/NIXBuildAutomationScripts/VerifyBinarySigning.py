#!/usr/bin/python

import os
import optparse
import sys

def main():
    parser = optparse.OptionParser(description='Verifies that iOS binary has expected keychain-access-group. Using the same keychain-access-group insures\
that app will have access to its keychain after updates.',
                                   prog='VerifyBinarySigning')
    
    parser.add_option("-b", "--binary", dest="path_to_binary", help="Full path to app binary", metavar="BINARY")
    parser.add_option("-s", "--keychain_access_group", dest="keychain_access_group", help="Expected keychain-access-group", metavar="KEYCHAIN-ACCESS-GROUP")
    
    (options, args) = parser.parse_args()
    
    if options.path_to_binary is None or options.keychain_access_group is None:
        parser.error('All arguments must be specified. Use option -h to see the usage.')
    
    logfile = open(options.path_to_binary, "r").readlines()

    currentLineNumber = 0

    """
    example from the binary:
    
    .
    .
    .
    <key>keychain-access-groups</key>
    <array>
    <string>KEYCHAIN-ACCESS-GROUP</string>
    </array>
    .
    .
    .
    """
    
    for line in logfile:
        if line.find('keychain-access-groups') != -1:
            currentLineNumber += 1
            
            if logfile[currentLineNumber].strip() != "<array>":
                print_error("Something wrong happened, there is no <array> in the <key>keychain-access-groups</key>")
                return 1
            
            currentLineNumber += 1
            
            while logfile[currentLineNumber].strip() != "</array>":
                line_with_access_group = logfile[currentLineNumber].strip().replace("<string>","").replace("</string>","")
                
                print line_with_access_group
                
                if line_with_access_group == options.keychain_access_group:
                    print 'App is signed correctly'
                    return 0
                        
                currentLineNumber += 1
            
            print_error("App is signed incorrectly, specified keychain access group '%s' was not found" % options.keychain_access_group)
            return 1
        
        currentLineNumber += 1
            
    print_error('App must be signed')
    return 1

def print_error(error_message):
    """ Prints error message with predefined prefix.
        
    Args:
        error_message: Error message.
    """
    
    XCODE_ERROR_PREFIX = 'error: ' # log messages with such prefix are highlighted in XCode as errors
    
    print('%s%s' % (XCODE_ERROR_PREFIX, error_message))

if __name__ == '__main__':
    sys.exit(main())