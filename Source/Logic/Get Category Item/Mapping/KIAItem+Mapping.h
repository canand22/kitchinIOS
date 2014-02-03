//
//  KIAItem+Mapping.h
//  KitchInApp
//
//  Created by DeMoN on 1/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAItem.h"

@class RKEntityMapping;
@class RKManagedObjectStore;

@interface KIAItem (Mapping)

+ (RKEntityMapping *)mappingForManagedObjectStore:(RKManagedObjectStore *)store;
+ (NSString *)primaryKeyProperty;

@end
