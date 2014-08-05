//
//  main.m
//  NIXProject
//
//  Created by Egor Zubkov on 1/22/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//

#import "AppDelegate.h"
#import "NIXCrashReporter.h"

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        [NIXCrashReporter sendReportViaRequest];
        [NIXCrashReporter enableCrashReporter];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
