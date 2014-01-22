//
//  KIAgetItem+Mapping.h
//  KitchInApp
//
//  Created by DeMoN on 1/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAgetItem.h"

@class RKEntityMapping;
@class RKManagedObjectStore;

@interface KIAgetItem (Mapping)

+ (RKEntityMapping *)mappingForManagedObjectStore:(RKManagedObjectStore *)store;
+ (NSString*)primaryKeyProperty;

@end
