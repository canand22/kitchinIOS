//
//  KIAAddItemMapping.h
//  KitchInApp
//
//  Created by DeMoN on 1/29/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAAddItemMapping : NSObject
{
    NSInteger _categoryId;
    NSInteger _expirationDate;
    NSString *_ingredientName;
    NSString *_name;
    NSString *_sessionId;
    NSString *_shortName;
    NSInteger _storeId;
    NSString *_upcCode;
}

@property(nonatomic, assign) NSInteger categoryId;
@property(nonatomic, assign) NSInteger expirationDate;
@property(nonatomic, strong) NSString *ingredientName;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *sessionId;
@property(nonatomic, strong) NSString *shortName;
@property(nonatomic, assign) NSInteger storeId;
@property(nonatomic, strong) NSString *upcCode;

+ (RKObjectMapping *)mapping;

@end
