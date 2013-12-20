//
//  AppDelegate.m
//  NIXProject
//
//  Created by Egor Zubkov on 1/22/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//

#import "AppDelegate.h"
#import "NIXCrashReporter.h"

@implementation AppDelegate

@synthesize window = window_;

- (BOOL)application:(UIApplication *)theApplication didFinishLaunchingWithOptions:(NSDictionary *)theLaunchOptions
{
    [NIXCrashReporter sendReportViaMail];
    
    return YES;
}

@end
