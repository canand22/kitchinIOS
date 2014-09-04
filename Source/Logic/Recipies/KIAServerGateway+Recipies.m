//
//  KIAServerGateway+Recipies.m
//  KitchInApp
//
//  Created by DeMoN on 8/19/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+Recipies.h"

#import "RestKit.h"

#import "KIAFullRecipiesMapping.h"

@implementation KIAServerGateway (Recipies)

- (void)sendRecipiesWithId:(NSString *)recipiesId delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithResipiesId:recipiesId delegate:delegate];
}

- (void)setupRecipiesMapping
{
    // create mapping
    RKObjectMapping *recipiesMapping = [KIAFullRecipiesMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:recipiesMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:nil
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (void)postQueryWithResipiesId:(NSString *)recipiesId delegate:(id<serverGatewayDelegate>)delegate
{
    [self setupRecipiesMapping];
    
    // выполнение запроса
    [[self objectManager] getObject:nil
                               path:[NSString stringWithFormat:@"/KitchInAppService.svc/Recipe/%@", recipiesId]
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                            {
                                NSLog(@"Success!!!");
         
                                NSArray *result = [mappingResult array];
         
                                [delegate showData:result];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error)
                            {
                                KIAFullRecipiesMapping *errorResponse = nil;
         
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
