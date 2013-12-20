//
//  NIXCrashReporter.h
//  NIXProject
//
//  Created by Nezhelskoy Iliya on 10/7/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface NIXCrashReporter : NSObject<UIAlertViewDelegate, MFMailComposeViewControllerDelegate>

- (id)init __attribute__ ((unavailable ("Method is not available")));

+ (BOOL)enableCrashReporterAndReturnError:(NSError **)outError;

+ (void)sendReportViaRequest;
+ (void)sendReportViaMail;

+ (NSArray *)mailRecipients;

@end