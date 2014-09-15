//
//  KIAServerGateway+EditPassword.m
//  KitchInApp
//
//  Created by DeMoN on 9/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+EditPassword.h"

#import "RestKit.h"

#import "KIAServerGateway.h"
#import "KIAChangePasswordMapping.h"
#import "KIASuccessMapping.h"

@implementation KIAServerGateway (EditPassword)

- (void)newPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithNewPassword:newPassword oldPassword:oldPassword delegate:delegate];
}

- (void)setupChangePasswordMapping
{
    // create mapping
    RKObjectMapping *changePasswordMapping = [KIASuccessMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:changePasswordMapping
                                                                                    method:RKRequestMethodPOST
                                                                               pathPattern:@"/KitchInAppService.svc/MyAccount/Update"
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (RKRequestDescriptor *)setupCredentionsMappingForChangePassword
{
    RKObjectMapping *credentialsMapping = [KIAChangePasswordMapping mapping];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[credentialsMapping inverseMapping]
                                                                                   objectClass:[KIAChangePasswordMapping class]
                                                                                   rootKeyPath:nil
                                                                                        method:RKRequestMethodPOST];
    
    [[self objectManager] addRequestDescriptor:requestDescriptor];
    
    return requestDescriptor;
}

- (void)postQueryWithNewPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword delegate:(id<serverGatewayDelegate>)delegate
{
    RKRequestDescriptor *request = [self setupCredentionsMappingForChangePassword];
    
    [self setupChangePasswordMapping];
    
    // [[[self objectManager] HTTPClient] setAuthorizationHeaderWithUsername:username password:password];
    
    KIAChangePasswordMapping *credentials = [KIAChangePasswordMapping new];
    [credentials setPassword:newPassword];
    [credentials setOldPassword:oldPassword];
    [credentials setSessionId:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]];
    
    // выполнение запроса
    [[self objectManager] postObject:credentials
                                path:@"/KitchInAppService.svc/MyAccount/Update"
                          parameters:nil
                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                                {
                                    NSArray *result = [mappingResult array];
         
                                    if ([result count] > 0)
                                    {
                                        if ([[result objectAtIndex:0] success])
                                        {
                                            NSLog(@"Success!!!");
                                        }
             
                                        [delegate loginSuccess:[[result objectAtIndex:0] success]];
             
                                        [[self objectManager] removeRequestDescriptor:request];
                                    }
                                }
                             failure:^(RKObjectRequestOperation *operation, NSError *error)
                                {
                                    // KIALoginMapping *errorResponse = nil;
         
                                    // if ([error code] == kCFURLErrorBadServerResponse)
                                    // {
                                        // There was a custom error
                                        // errorResponse = [[operation mappingResult] firstObject];
             
                                        // NSLog(@"Failure: %d", kCFURLErrorBadServerResponse);
                                    // }
                                    
                                    // NSLog(@"Failure: %@", [error localizedDescription]);
         
                                    [[self objectManager] removeRequestDescriptor:request];
                                }];
}

@end
