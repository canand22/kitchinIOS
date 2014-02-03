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
#import "KIAItem.h"
#import "KIAItem+Mapping.h"

#import "RKObjectMappingOperationDataSource.h"

@implementation KIAServerGateway (getItemOfCategory)

@dynamic delegate;

- (void)getItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId delegate:(id<serverGatewayDelegate>)delegate
{
    [self getItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId];
}

- (void)setupGetItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId
{
    // create mapping
    RKEntityMapping *mapping = [KIAItem mappingForManagedObjectStore:[[self objectManager] managedObjectStore]];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:@"/KitchInAppService.svc/MyKitchen/:catId"
                                                                                   keyPath:@"Products"
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];

    [[self objectManager] addResponseDescriptor:descriptor];
    
    [[[self objectManager] managedObjectStore] createPersistentStoreCoordinator];
    
    [[[self objectManager] managedObjectStore] setManagedObjectCache:[[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:[[[self objectManager] managedObjectStore] persistentStoreManagedObjectContext]]];
    
    NSLog(@"%ld", (unsigned long)catId);
}

- (void)getItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId
{
    [self setupGetItemWithCategoyId:catId storeId:storeId];
    
    // выполнение запроса
    [[self objectManager] getObjectsAtPath:[NSString stringWithFormat:@"/KitchInAppService.svc/MyKitchen/AllProducts?storeId=%ld&categoryId=%ld", (unsigned long)storeId, (unsigned long)catId]
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
    
    [[self objectManager] removeResponseDescriptor:[[[self objectManager] responseDescriptors] objectAtIndex:0]];
}

@end
