//
//  AppDelegateTests.m
//  NIXProject
//
//  Created by Egor Zubkov on 1/22/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//

#import "AppDelegateTests.h"
#import "AppDelegate.h"

@implementation AppDelegateTests

#pragma mark -
#pragma mark GHTestCase methods

- (BOOL)shouldRunOnMainThread
{
    return YES;
}

#pragma mark -
#pragma mark Tests

- (void)testCreatesWindowAndMakesItKeyOnDidFinishLaunching
{
    // init
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    
    // exercise
    [appDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
    
    // verify
    GHAssertNotNil([appDelegate window], @"");
    GHAssertTrue([appDelegate window] == [[UIApplication sharedApplication] keyWindow], @"");
}

@end
