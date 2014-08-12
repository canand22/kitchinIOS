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

@property(nonatomic, assign) NSString *ResipiesID;
@property(nonatomic, strong) NSString *Title;
@property(nonatomic, strong) NSString *PhotoUrl;
@property(nonatomic, assign) NSInteger TotalTime;
@property(nonatomic, assign) CGFloat Kalories;
@property(nonatomic, strong) NSArray *Ingredients;

+ (RKObjectMapping *)mapping;

@end
