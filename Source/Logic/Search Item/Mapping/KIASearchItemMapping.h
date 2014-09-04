//
//  KIASearchItemMapping.h
//  KitchInApp
//
//  Created by DeMoN on 1/30/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIASearchItemMapping : NSObject
{
    NSString *_category;
    NSInteger _itemId;
    BOOL _isSuccessMatching;
    NSString *_itemName;
    NSString *_itemShortName;
    NSString *_yummlyName;
}

@property(nonatomic, strong) NSString *category;
@property(nonatomic, assign) NSInteger itemId;
@property(nonatomic, assign) BOOL isSuccessMatching;
@property(nonatomic, strong) NSString *itemName;
@property(nonatomic, strong) NSString *itemShortName;
@property(nonatomic, strong) NSString *yummlyName;

+ (RKObjectMapping *)mapping;

@end
