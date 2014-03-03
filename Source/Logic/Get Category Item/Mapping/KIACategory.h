//
//  KIACategory.h
//  KitchInApp
//
//  Created by DeMoN on 1/22/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface KIACategory : NSManagedObject

@property(nonatomic, strong) NSNumber *idCategory;
@property(nonatomic, strong) NSString *name;

@end
