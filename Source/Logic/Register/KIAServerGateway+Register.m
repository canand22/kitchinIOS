// ************************************************ //
//                                                  //
//  KIAServerGateway+Register.m                     //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/9/14.                     //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIAServerGateway+Register.h"

#import "RestKit.h"

#import "KIAServerGateway.h"
#import "KIACredentials.h"
#import "KIACredentials+Mapping.h"
#import "KIARegisterMapping.h"

@implementation KIAServerGateway (Register)

- (void)registerUser:(NSString *)username withPassword:(NSString *)password delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithRegister:username password:password];
}

- (void)setupRegisterMapping
{
    // create mapping
    RKObjectMapping *registerMapping = [KIARegisterMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:registerMapping
                                                                                    method:RKRequestMethodPOST
                                                                               pathPattern:@"/KitchInAppService.svc/Register"
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (void)setupCredentionsMappingWithUsername:(NSString *)username password:(NSString *)password
{
    RKObjectMapping *credentialsMapping = [KIACredentials mapping];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[credentialsMapping inverseMapping]
                                                                                   objectClass:[KIACredentials class]
                                                                                   rootKeyPath:nil
                                                                                        method:RKRequestMethodPOST];
    
    [[self objectManager] addRequestDescriptor:requestDescriptor];
}

- (void)postQueryWithRegister:(NSString *)username password:(NSString *)password
{
    [self setupCredentionsMappingWithUsername:username password:password];
    
    [self setupRegisterMapping];
    
    [[[self objectManager] HTTPClient] setAuthorizationHeaderWithUsername:username password:password];
    
    KIACredentials *credentials = [KIACredentials new];
    [credentials setEmail:username];
    [credentials setPassword:password];
    
    // выполнение запроса
    [[self objectManager] postObject:credentials
                                path:@"/KitchInAppService.svc/Register"
                          parameters:nil
                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                                {
                                    NSArray *result = [mappingResult array];
         
                                    if ([result count] > 0)
                                    {
                                        if ([[result objectAtIndex:0] IsUserRegistered])
                                        {
                                            [[NSUserDefaults standardUserDefaults] setObject:[[result objectAtIndex:0] SessionId] forKey:@"sessionId"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            
                                            NSLog(@"Success!!!");
                                        }
                                    }
                                }
                             failure:^(RKObjectRequestOperation *operation, NSError *error)
                                {
                                    KIARegisterMapping *errorResponse = nil;
         
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
