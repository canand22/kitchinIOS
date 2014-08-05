//
//  NIXCrashReporter.m
//  NIXProject
//
//  Created by Nezhelskoy Iliya on 10/7/13.
//  Copyright (c) 2013 NIX. All rights reserved.
//

#if !__has_feature(objc_arc)
#error NIXCrashReporter must be built with ARC.
// You can turn on ARC for only NIXCrashReporter file by adding -fobjc-arc to the build phase for this file.
#endif

#import "CrashReporter.h"
#import "NIXCrashReporter.h"
#import "AFNetworking.h"

static NSString *const NIXPendingReportsFolderName = @"PendingCrashReports";
static NSString *const NIXCrashReportFileName      = @"report.plcrash";

static NSString *const NIXBoundleIDKey          = @"bundle_id";
static NSString *const NIXVersionKey            = @"version";
static NSString *const NIXReportKey             = @"report";
static NSString *const NIXConfigurationKey      = @"configuration";
static NSString *const NIXPlistConfigurationKey = @"Configuration";

@interface NIXCrashReporter ()

+ (NSString *)buildConfiguration;
+ (NSString *)appVersion;
+ (NSString *)bundleID;

@end

@implementation NIXCrashReporter

#pragma mark - Public methode

+ (BOOL)enableCrashReporter
{
    return [[PLCrashReporter sharedReporter] enableCrashReporter];
}

+ (void)sendReportViaRequest
{
    NSData *reportData = [[PLCrashReporter sharedReporter] loadPendingCrashReportData];
    
    if (reportData != nil)
    {
        NSDictionary *parameters = @{
                                        NIXBoundleIDKey : [self bundleID],
                                        NIXVersionKey : [self appVersion],
                                        NIXReportKey : reportData,
                                        NIXConfigurationKey : [self buildConfiguration]
                                    };
        
        AFHTTPRequestOperationManager *requestOperationManager = [AFHTTPRequestOperationManager manager];
        
        [requestOperationManager setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
        [[requestOperationManager responseSerializer] setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        [requestOperationManager POST:@"https://mds.nixsolutions.com/api/upload-crash-report"
                           parameters:parameters
                              success:^(AFHTTPRequestOperation *operation, id responseObject) { [[PLCrashReporter sharedReporter] purgePendingCrashReport]; }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) { }];
    }
}

#pragma mark - Private methods

+ (NSString *)buildConfiguration
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:NIXPlistConfigurationKey];
}

+ (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [NSString stringWithFormat:@"v.%@_%@", infoDictionary[@"CFBundleShortVersionString"], infoDictionary[@"CFBundleVersion"]];
}

+ (NSString *)bundleID
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

@end
