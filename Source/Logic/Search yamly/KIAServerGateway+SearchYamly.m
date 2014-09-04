//
//  KIAServerGateway+SearchYamly.m
//  KitchInApp
//
//  Created by DeMoN on 9/2/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+SearchYamly.h"

#import "RestKit.h"

#import "KIAYamlyMapping.h"

@implementation KIAServerGateway (SearchYamly)

- (void)searchWithString:(NSString *)yamlyString delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithString:yamlyString delegate:delegate];
}

- (void)setupYamlyMapping
{
    // create mapping
    RKObjectMapping *yamlyMapping = [KIAYamlyMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:yamlyMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:nil
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (void)postQueryWithString:(NSString *)yamlyString delegate:(id<serverGatewayDelegate>)delegate
{
    [self setupYamlyMapping];
    
    // выполнение запроса
    [[self objectManager] getObject:nil
                               path:[NSString stringWithFormat:@"/KitchInAppService.svc/YummlyIngredientsRelations/%@", yamlyString]
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                            {
                                NSLog(@"Success!!!");
         
                                NSArray *result = [mappingResult array];
         
                                [delegate showData:result];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error)
                            {
                                KIAYamlyMapping *errorResponse = nil;
         
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
