//
//  KIASearchRecipiesMapping.h
//  KitchInApp
//
//  Created by DeMoN on 8/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIASearchRecipiesMapping : NSObject
{
    NSUInteger _totalCount;
    NSArray *_recipes;
}

@property(nonatomic, assign) NSUInteger TotalCount;
@property(nonatomic, strong) NSArray *Recipes;

+ (RKObjectMapping *)mapping;

@end
