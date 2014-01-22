//
//  KIAgetItem+Mapping.m
//  KitchInApp
//
//  Created by DeMoN on 1/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAgetItem+Mapping.h"

#import "RKEntityMapping.h"
#import "RKManagedObjectStore.h"

@implementation KIAgetItem (Mapping)

+ (RKEntityMapping *)mappingForManagedObjectStore:(RKManagedObjectStore *)store
{
    // create mapping
    RKEntityMapping *itemMapping = [RKEntityMapping mappingForEntityForName:@"KIAgetItem" inManagedObjectStore:store];
    
    // setup mapping
    [itemMapping addAttributeMappingsFromArray:@[@"Id", @"Name"]];
    
    return itemMapping;
}

+ (NSString *)primaryKeyProperty
{
    return @"Id";
}


@end
