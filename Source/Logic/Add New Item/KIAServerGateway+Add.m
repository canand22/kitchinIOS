//
//  KIAServerGateway+Add.m
//  KitchInApp
//
//  Created by DeMoN on 1/29/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+Add.h"

#import "RestKit.h"

#import "KIAAddItemMapping.h"
#import "KIAAddItemResultMapping.h"

@implementation KIAServerGateway (Add)

- (void)addItemWithCategoryId:(NSInteger)catId expirationDate:(NSInteger)expDate ingredientName:(NSString *)ingrName name:(NSString *)name sessionId:(NSString *)sessionId shortName:(NSString *)shortName storeId:(NSInteger)storeId upcCode:(NSString *)upcCode delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithCategoryId:catId expirationDate:expDate ingredientName:ingrName name:name sessionId:sessionId shortName:shortName storeId:storeId upcCode:upcCode delegate:delegate];
}

- (void)setupProductMapping
{
    // create mapping
    RKObjectMapping *resultMapping = [KIAAddItemResultMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:resultMapping
                                                                                    method:RKRequestMethodPOST
                                                                               pathPattern:@"/KitchInAppService.svc/Product"
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (RKRequestDescriptor *)setupAddItemMappingWithName:(NSString *)name shortName:(NSString *)shortName upcCode:(NSString *)upcCode
{
    RKObjectMapping *addItemMapping = [KIAAddItemMapping mapping];
    
    if (name)
    {
        [addItemMapping addAttributeMappingsFromDictionary:@{@"Name" : @"name"}];
    }
    
    if (shortName)
    {
        [addItemMapping addAttributeMappingsFromDictionary:@{@"ShortName" : @"shortName"}];
    }
    
    if (upcCode)
    {
        [addItemMapping addAttributeMappingsFromDictionary:@{@"UpcCode" : @"upcCode"}];
    }
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[addItemMapping inverseMapping]
                                                                                   objectClass:[KIAAddItemMapping class]
                                                                                   rootKeyPath:nil
                                                                                        method:RKRequestMethodPOST];
    
    [[self objectManager] addRequestDescriptor:requestDescriptor];
    
    return requestDescriptor;
}

- (void)postQueryWithCategoryId:(NSInteger)catId expirationDate:(NSInteger)expDate ingredientName:(NSString *)ingrName name:(NSString *)name sessionId:(NSString *)sessionId shortName:(NSString *)shortName storeId:(NSInteger)storeId upcCode:(NSString *)upcCode delegate:(id<serverGatewayDelegate>)delegate
{
    RKRequestDescriptor *request = [self setupAddItemMappingWithName:name shortName:shortName upcCode:upcCode];
    
    [self setupProductMapping];

    KIAAddItemMapping *addItem = [KIAAddItemMapping new];
    [addItem setSessionId:sessionId];
    [addItem setStoreId:storeId];
    
    if (name)
    {
        [addItem setName:name];
    }
    
    if (shortName)
    {
        [addItem setShortName:shortName];
    }
    
    if (upcCode)
    {
        [addItem setUpcCode:upcCode];
    }
    
    // выполнение запроса
    [[self objectManager] postObject:addItem
                                path:@"/KitchInAppService.svc/Product"
                          parameters:nil
                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                                {
                                    NSArray *result = [mappingResult array];

                                    NSLog(@"Success!!!");
                                    
                                    [delegate message:[[result objectAtIndex:0] message] success:[[result objectAtIndex:0] isSuccessfully]];
             
                                    [[self objectManager] removeRequestDescriptor:request];
                                }
                             failure:^(RKObjectRequestOperation *operation, NSError *error)
                                {
                                    NSLog(@"Failure: %@", [error localizedDescription]);
         
                                    [[self objectManager] removeRequestDescriptor:request];
                                }];
}

@end
