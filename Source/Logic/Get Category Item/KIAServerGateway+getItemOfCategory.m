//
//  KIAServerGateway+getItemOfCategory.m
//  KitchInApp
//
//  Created by DeMoN on 1/20/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+getItemOfCategory.h"

#import "RestKit.h"

#import "KIAServerGateway.h"
#import "KIAgetItem.h"
#import "KIAgetItem+Mapping.h"

@implementation KIAServerGateway (getItemOfCategory)

@dynamic delegate;

- (void)getItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId delegate:(id<serverGatewayDelegate>)delegate
{
    [self getItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId];
}

- (void)setupGetItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId
{
    // create mapping
    RKEntityMapping *mapping = [KIAgetItem mappingForManagedObjectStore:[[self objectManager] managedObjectStore]];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:[NSString stringWithFormat:@"/KitchInAppService.svc/MyKitchen/AllProducts?storeId=%ld&categoryId=%ld", (unsigned long)storeId, (unsigned long)catId]
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
    
    [[[self objectManager] managedObjectStore] createPersistentStoreCoordinator];
    
    [[[self objectManager] managedObjectStore] setManagedObjectCache:[[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:[[[self objectManager] managedObjectStore] persistentStoreManagedObjectContext]]];
}

- (void)getItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId
{
    [self setupGetItemWithCategoyId:catId storeId:storeId];
    
    // выполнение запроса
    [[self objectManager] getObject:nil
                               path:[NSString stringWithFormat:@"/KitchInAppService.svc/MyKitchen/AllProducts?storeId=%ld&categoryId=%ld", (unsigned long)storeId, (unsigned long)catId]
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                            {
                                NSArray *result = [mappingResult array];
         
                                if ([result count] > 0)
                                {
                                    NSLog(@"Success!!!");
                                }
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error)
                            {
                                NSLog(@"Failure: %@", [error localizedDescription]);
                            }];
}

@end
