//
//  NIXCrashReporter.h
//  NIXProject
//
//  Created by Nezhelskoy Iliya on 10/7/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//

@interface NIXCrashReporter : NSObject

+ (BOOL)enableCrashReporter;
+ (void)sendReportViaRequest;

@end