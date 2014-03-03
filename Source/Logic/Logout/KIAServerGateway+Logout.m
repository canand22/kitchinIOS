//
//  KIAServerGateway+Logout.m
//  KitchInApp
//
//  Created by DeMoN on 1/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+Logout.h"

#import "RestKit.h"

#import "KIALogoutMapping.h"

@implementation KIAServerGateway (Logout)

- (void)logoutWithDelegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithLogout];
}

- (void)setupLogoutMapping
{
    // create mapping
    RKObjectMapping *logoutMapping = [KIALogoutMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:logoutMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:@"/KitchInAppService.svc/:id"
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (void)postQueryWithLogout
{
    [self setupLogoutMapping];

    // выполнение запроса
    [[self objectManager] getObject:nil
                               path:[NSString stringWithFormat:@"/KitchInAppService.svc/LogOut?id=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]]
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                            {
                                NSLog(@"Success!!!");
                                        
                                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"sessionId"];
                                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"firstName"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error)
                            {
                                KIALogoutMapping *errorResponse = nil;
         
                                if ([error code] == kCFURLErrorBadServerResponse)
                                {
                                    // There was a custom error
                                    errorResponse = [[operation mappingResult] firstObject];
             
                                    NSLog(@"Failure: %d", kCFURLErrorBadServerResponse);
                                }
         
                                NSLog(@"Failure: %@", [error localizedDescription]);
                            }];
}

@end
