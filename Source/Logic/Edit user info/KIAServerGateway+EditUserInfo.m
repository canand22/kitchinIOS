//
//  KIAServerGateway+EditUserInfo.m
//  KitchInApp
//
//  Created by DeMoN on 9/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+EditUserInfo.h"

#import "RestKit.h"

#import "KIAServerGateway.h"
#import "KIAChangeUserInfoMapping.h"
#import "KIASuccessMapping.h"

@implementation KIAServerGateway (EditUserInfo)

- (void)changeFirstName:(NSString *)firstName changeLastName:(NSString *)lastName delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithFirstName:firstName lastName:lastName delegate:delegate];
}

- (void)setupChangeUserInfoMapping
{
    // create mapping
    RKObjectMapping *changeUserNameMapping = [KIASuccessMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:changeUserNameMapping
                                                                                    method:RKRequestMethodPOST
                                                                               pathPattern:@"/KitchInAppService.svc/MyAccount/UpdateUserData"
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (RKRequestDescriptor *)setupChangeUserInfoMappingForLogin
{
    RKObjectMapping *credentialsMapping = [KIAChangeUserInfoMapping mapping];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[credentialsMapping inverseMapping]
                                                                                   objectClass:[KIAChangeUserInfoMapping class]
                                                                                   rootKeyPath:nil
                                                                                        method:RKRequestMethodPOST];
    
    [[self objectManager] addRequestDescriptor:requestDescriptor];
    
    return requestDescriptor;
}

- (void)postQueryWithFirstName:(NSString *)firstName lastName:(NSString *)lastName delegate:(id<serverGatewayDelegate>)delegate
{
    RKRequestDescriptor *request = [self setupChangeUserInfoMappingForLogin];
    
    [self setupChangeUserInfoMapping];
    
    KIAChangeUserInfoMapping *credentials = [KIAChangeUserInfoMapping new];
    [credentials setFirstName:firstName];
    [credentials setLastName:lastName];
    [credentials setEmail:[[NSUserDefaults standardUserDefaults] objectForKey:@"email"]];
    [credentials setSessionId:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]];
    
    // выполнение запроса
    [[self objectManager] postObject:credentials
                                path:@"/KitchInAppService.svc/MyAccount/UpdateUserData"
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
             
                                    //  NSLog(@"Failure: %d", kCFURLErrorBadServerResponse);
                                    // }
         
                                    NSLog(@"Failure: %@", [error localizedDescription]);
         
                                    [[self objectManager] removeRequestDescriptor:request];
                                }];
}

@end
