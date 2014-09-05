//
//  KIAItem.h
//  KitchInApp
//
//  Created by DeMoN on 2/3/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KIAItem : NSManagedObject

@property(nonatomic, strong) NSNuamber *count;
@property(nonatomic, strong) NSNumber *idCategory;
@property(nonatomic, strong) NSNumber *idItem;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *reduction;
@property(nonatomic, strong) NSString *value;
@property(nonatomic, strong) NSString *yummlyName;

@end
