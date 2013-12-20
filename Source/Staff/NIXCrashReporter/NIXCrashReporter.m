//
//  NIXCrashReporter.m
//  NIXProject
//
//  Created by Nezhelskoy Iliya on 10/7/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//

#import "NIXCrashReporter.h"
#import "AFNetworking.h"
#import <CrashReporter/CrashReporter.h>

#if !__has_feature(objc_arc)
#error NIXCrashReporter must be built with ARC.
// You can turn on ARC for only NIXCrashReporter file by adding -fobjc-arc to the build phase for this file.
#endif

@implementation NIXCrashReporter

static BOOL requestFinished;
static BOOL mailingFinished;

__strong static NIXCrashReporter *currentReporter = nil;

static NSString *const pendingReportsFolderName = @"PendingCrashReports";
static NSString *const defaultFileName = @"report.plcrash";

#pragma mark - Public
+ (BOOL)enableCrashReporterAndReturnError:(NSError * __autoreleasing *)outError
{
    return [[PLCrashReporter sharedReporter] enableCrashReporterAndReturnError:outError];
}

+ (void)sendReportViaRequest
{
    requestFinished = NO;
    
    if ([[PLCrashReporter sharedReporter] hasPendingCrashReport])
    {
        [NIXCrashReporter savePendingReport];
    }
    
    NSData *reportData = [NIXCrashReporter savedReportData];
    
    if (reportData)
    {
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://mds.nixsolutions.com"]];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSDictionary *parameters = @{
                                        @"bundle_id" : infoDictionary[@"CFBundleIdentifier"],
                                        @"version" : [NSString stringWithFormat:@"v.%@_%@", infoDictionary[@"CFBundleShortVersionString"], infoDictionary[@"CFBundleVersion"]],
                                        @"report" : reportData
                                    };
        NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                             path:@"api/uploadCrashReport"
                                                                       parameters:parameters
                                                        constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                                        {
                                                            [formData appendPartWithFileData:reportData
                                                                                        name:@"report"
                                                                                    fileName:@"crashreport.plcrash"
                                                                                    mimeType:@"application/octet-stream"];
                                                        }];
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *theOperation, id theResponseObject)
        {
            [NIXCrashReporter clearPendingReport];
            requestFinished = YES;
            [NIXCrashReporter finish];
        }
                                                failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                {
                                                    requestFinished = YES;
                                                    [NIXCrashReporter finish];
                                                }];
        [requestOperation start];
    }
    else
    {
        requestFinished = YES;
    }
}

+ (void)sendReportViaMail
{
    mailingFinished = NO;
    
    if ([[PLCrashReporter sharedReporter] hasPendingCrashReport])
    {
        currentReporter = [[NIXCrashReporter alloc] initInstance];
        
        if ([MFMailComposeViewController canSendMail] && ([[NIXCrashReporter mailRecipients] count] > 0))
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Reporter:AlertTitle", @"")
                                                            message:NSLocalizedString(@"Reporter:AlertMessage", @"")
                                                           delegate:currentReporter
                                                  cancelButtonTitle:NSLocalizedString(@"Reporter:AlertCancel", @"")
                                                  otherButtonTitles:NSLocalizedString(@"Reporter:AlertConfirm", @""), nil];
            [alert show];
        }
        else
        {
            mailingFinished = YES;
            [NIXCrashReporter finish];
        }
    }
    else
    {
        mailingFinished = YES;
    }
}

+ (NSArray *)mailRecipients
{
    // Enter email addresses.
    return @[
            ];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)theButtonIndex
{
    if (theButtonIndex == [theAlertView cancelButtonIndex])
    {
        mailingFinished = YES;
        [NIXCrashReporter finish];
        return;
    }
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [NSString stringWithFormat:@"v.%@_%@", infoDictionary[@"CFBundleShortVersionString"], infoDictionary[@"CFBundleVersion"]];
    NSString *subject = [NSString stringWithFormat:@"CrashReport: %@ %@", infoDictionary[@"CFBundleIdentifier"], version];
    
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    [composer setMailComposeDelegate:currentReporter];
    [composer setSubject:subject];
    [composer setToRecipients:[NIXCrashReporter mailRecipients]];
    [composer addAttachmentData:[[PLCrashReporter sharedReporter] loadPendingCrashReportData]
                       mimeType:@"application/octet-stream"
                       fileName:@"crashreport.plcrash"];
    
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [rootViewController presentViewController:composer
                                     animated:YES completion:^{}];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)theController
          didFinishWithResult:(MFMailComposeResult)theResult
                        error:(NSError *)theError
{
    [theController dismissViewControllerAnimated:YES completion:^{}];
    
    mailingFinished = YES;
    [NIXCrashReporter finish];
}

#pragma mark - Private
- (id)initInstance
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

+ (void)finish
{
    if (mailingFinished)
    {
        // Release instance
        currentReporter = nil;
    }
    
    if (requestFinished && mailingFinished)
    {
        [[PLCrashReporter sharedReporter] purgePendingCrashReport];
    }
}

+ (BOOL)savePendingReport
{
    NSString *reportsFolderPath = [NSTemporaryDirectory() stringByAppendingPathComponent:pendingReportsFolderName];
    BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:reportsFolderPath
                                               withIntermediateDirectories:YES
                                                                attributes:nil
                                                                     error:nil];
    
    if (isSuccess)
    {
        // At the same time there can be only 1 file
        isSuccess &= [[NSFileManager defaultManager] createFileAtPath:[reportsFolderPath stringByAppendingPathComponent:defaultFileName]
                                                             contents:[[PLCrashReporter sharedReporter] loadPendingCrashReportData]
                                                           attributes:nil];
    }
    
    return isSuccess;
}

+ (BOOL)clearPendingReport
{
    NSString *filePath = [[NSTemporaryDirectory () stringByAppendingPathComponent:pendingReportsFolderName] stringByAppendingPathComponent:defaultFileName];
    
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (NSData *)savedReportData
{
    NSError *error = nil;
    NSData *fileData = nil;
    
    if (!error)
    {
        NSString *filePath = [[NSTemporaryDirectory () stringByAppendingPathComponent:pendingReportsFolderName] stringByAppendingPathComponent:defaultFileName];
        fileData = [[NSFileManager defaultManager] contentsAtPath:filePath];
    }
    
    return fileData;
}

@end