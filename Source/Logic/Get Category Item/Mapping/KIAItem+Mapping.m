//
//  KIAItem+Mapping.m
//  KitchInApp
//
//  Created by DeMoN on 1/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAItem+Mapping.h"

#import "RKEntityMapping.h"
#import "RKManagedObjectStore.h"

@implementation KIAItem (Mapping)

+ (RKEntityMapping *)mappingForManagedObjectStore:(RKManagedObjectStore *)store
{
    // create mapping
    RKEntityMapping *itemMapping = [RKEntityMapping mappingForEntityForName:@"KIAItem" inManagedObjectStore:store];
    
    // setup mapping
    [itemMapping addAttributeMappingsFromDictionary:@{@"Id" : @"idItem", @"Name" : @"name", @"ShortName" : @"reduction"}];
    [itemMapping setIdentificationAttributes:@[@"idItem"]];
    
    return itemMapping;
}

+ (NSString *)primaryKeyProperty
{
    return @"idItem";
}

@end
