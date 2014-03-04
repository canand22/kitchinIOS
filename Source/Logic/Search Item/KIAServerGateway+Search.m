//
//  KIAServerGateway+Search.m
//  KitchInApp
//
//  Created by DeMoN on 1/30/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+Search.h"

#import "RestKit.h"

#import "KIAServerGateway.h"
#import "KIASearchItemMapping.h"

@implementation KIAServerGateway (Search)

- (void)searchItemWithText:(NSString *)text categoyId:(NSUInteger)catId storeId:(NSUInteger)storeId delegate:(id<serverGatewayDelegate>)delegate
{
    [self getItemWithText:text categoyId:catId storeId:storeId delegate:delegate];
}

- (void)setupSearchItemWithText:(NSString *)text categoyId:(NSUInteger)catId storeId:(NSUInteger)storeId
{
    // create mapping
    RKObjectMapping *searchMapping = [KIASearchItemMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:searchMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:nil
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (void)getItemWithText:(NSString *)text categoyId:(NSUInteger)catId storeId:(NSUInteger)storeId delegate:(id<serverGatewayDelegate>)delegate
{
    [self setupSearchItemWithText:text categoyId:catId storeId:storeId];
    
    // выполнение запроса
    [[self objectManager] getObjectsAtPath:[NSString stringWithFormat:@"KitchInAppService.svc/SearchProduct?product=%@&categoryId=%ld&storeId=%ld", text, (unsigned long)catId, (unsigned long)storeId]
                                parameters:nil
                                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                                    {
                                        NSArray *result = [mappingResult array];
                                        
                                        [delegate showData:result];
                                            
                                        NSLog(@"Success!!!");
                                    }
                                   failure:^(RKObjectRequestOperation *operation, NSError *error)
                                    {
                                        NSLog(@"Failure: %@", [error localizedDescription]);
                                    }];
}

@end
