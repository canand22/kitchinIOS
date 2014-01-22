//
//  KIAServerGateway+Forgot.m
//  KitchInApp
//
//  Created by DeMoN on 1/9/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+Forgot.h"

#import "RestKit.h"

#import "KIAServerGateway.h"
#import "KIAForgotMapping.h"

@implementation KIAServerGateway (Forgot)

- (void)forgotPasswordWithEmail:(NSString *)email delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithEmail:email];
}

- (void)setupForgotMappingWithEmail:(NSString *)email
{
    // create mapping
    RKObjectMapping *registerMapping = [KIAForgotMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:registerMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:[NSString stringWithFormat:@"/KitchInAppService.svc/Forgot?email=%@", email]
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (void)postQueryWithEmail:(NSString *)email
{
    [self setupForgotMappingWithEmail:email];
    
    // выполнение запроса
    [[self objectManager] getObject:nil
                               path:[NSString stringWithFormat:@"/KitchInAppService.svc/Forgot?email=%@", email]
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                            {
                                NSArray *result = [mappingResult array];
         
                                if ([result count] > 0)
                                {
                                    if ([[result objectAtIndex:0] IsUserRegistered])
                                    {
                                        NSLog(@"Success!!!");
                                    }
                                }
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error)
                            {
                                NSLog(@"Failure: %@", [error localizedDescription]);
                            }];
}

@end
