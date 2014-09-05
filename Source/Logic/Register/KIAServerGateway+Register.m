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

#import "KIAAutorization.h"
#import "KIARegisterMapping.h"

@implementation KIAServerGateway (Register)

- (void)registerUser:(NSString *)username withPassword:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithRegister:username password:password firstName:firstName lastName:lastName delegate:(id<serverGatewayDelegate>)delegate];
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

- (RKRequestDescriptor *)setupCredentionsMappingForRegister
{
    RKObjectMapping *autorizMapping = [KIAAutorization mapping];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[autorizMapping inverseMapping]
                                                                                   objectClass:[KIAAutorization class]
                                                                                   rootKeyPath:nil
                                                                                        method:RKRequestMethodPOST];
    
    [[self objectManager] addRequestDescriptor:requestDescriptor];
    
    return requestDescriptor;
}

- (void)postQueryWithRegister:(NSString *)username password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName delegate:(id<serverGatewayDelegate>)delegate
{
    RKRequestDescriptor *request = [self setupCredentionsMappingForRegister];
    
    [self setupRegisterMapping];
    
    [[[self objectManager] HTTPClient] setAuthorizationHeaderWithUsername:username password:password];
    
    KIAAutorization *credentials = [KIAAutorization new];
    [credentials setFirstName:firstName];
    [credentials setLastName:lastName];
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
                                            [[NSUserDefaults standardUserDefaults] setObject:firstName forKey:@"firstName"];
                                            [[NSUserDefaults standardUserDefaults] setObject:lastName forKey:@"lastName"];
                                            [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"email"];
                                            [[NSUserDefaults standardUserDefaults] setObject:[[result objectAtIndex:0] SessionId] forKey:@"sessionId"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            
                                            NSLog(@"Success!!!");
                                        }
                                        
                                        [delegate loginSuccess:[[result objectAtIndex:0] IsUserRegistered]];
                                        
                                        [[self objectManager] removeRequestDescriptor:request];
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
                                    
                                    [[self objectManager] removeRequestDescriptor:request];
                                }];
}

@end
