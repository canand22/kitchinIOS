//
//  KIAFullRecipiesMapping.h
//  KitchInApp
//
//  Created by DeMoN on 8/19/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAFullRecipiesMapping : NSObject

@property(nonatomic, strong) NSArray *Ingredients;
@property(nonatomic, strong) NSArray *Nutritions;
@property(nonatomic, strong) NSString *Picture;
@property(nonatomic, assign) NSInteger Rating;
@property(nonatomic, strong) NSString *RecipeName;
@property(nonatomic, strong) NSString *RecipeUrl;
@property(nonatomic, assign) NSInteger Served;
@property(nonatomic, assign) NSInteger Time;

+ (RKObjectMapping *)mapping;

@end
