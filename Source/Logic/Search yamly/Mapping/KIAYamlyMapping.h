//
//  KIAYamlyMapping.h
//  KitchInApp
//
//  Created by DeMoN on 9/2/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAYamlyMapping : NSObject

@property(nonatomic, strong) NSNumber *itemId;
@property(nonatomic, strong) NSString *categoryName;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *shotName;
@property(nonatomic, strong) NSString *yummlyName;

+ (RKObjectMapping *)mapping;

@end
