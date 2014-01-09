// ************************************************ //
//                                                  //
//  KIAServerGateway+Login.m                        //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/27/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIAServerGateway+Login.h"

#import "RestKit.h"

#import "KIAServerGateway.h"
#import "KIACredentials.h"
#import "KIACredentials+Mapping.h"
#import "KIALoginMapping.h"

@implementation KIAServerGateway (Login)

- (void)loginUser:(NSString *)username withPassword:(NSString *)password delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithLogin:username password:password];
}

- (void)setupLoginMapping
{
    // create mapping
    RKObjectMapping *loginMapping = [KIALoginMapping mapping];

    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:loginMapping
                                                                                    method:RKRequestMethodPOST
                                                                               pathPattern:@"/KitchInAppService.svc/LogIn"
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

- (void)postQueryWithLogin:(NSString *)username password:(NSString *)password
{
    [self setupCredentionsMappingWithUsername:username password:password];
    
    [self setupLoginMapping];
    
    [[[self objectManager] HTTPClient] setAuthorizationHeaderWithUsername:username password:password];
    
    KIACredentials *credentials = [KIACredentials new];
    [credentials setEmail:username];
    [credentials setPassword:password];
    
    // выполнение запроса
    [[self objectManager] postObject:credentials
                                path:@"/KitchInAppService.svc/LogIn"
                          parameters:nil
                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                                {
                                    NSArray *result = [mappingResult array];
         
                                    if ([result count] > 0)
                                    {
                                        if ([[result objectAtIndex:0] Success])
                                        {
                                            [[NSUserDefaults standardUserDefaults] setObject:[[result objectAtIndex:0] SessionId] forKey:@"sessionId"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                         
                                            NSLog(@"Success!!!");
                                        }
                                    }
                                }
                             failure:^(RKObjectRequestOperation *operation, NSError *error)
                                {
                                    KIALoginMapping *errorResponse = nil;
                                    
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
