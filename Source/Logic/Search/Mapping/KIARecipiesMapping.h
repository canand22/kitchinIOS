//
//  KIARecipiesMapping.h
//  KitchInApp
//
//  Created by DeMoN on 8/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface KIARecipiesMapping : NSObject
{
    NSString *_resipiesID;
    NSArray *_ingredients;
    NSString *_title;
    NSInteger _totalTime;
    CGFloat _kalories;
    NSArray *_photoUrl;
    NSInteger _rating;
}

@property(nonatomic, strong) NSString *ResipiesID;
@property(nonatomic, strong) NSArray *Ingredients;
@property(nonatomic, strong) NSString *Title;
@property(nonatomic, assign) NSInteger TotalTime;
@property(nonatomic, assign) CGFloat Kalories;
@property(nonatomic, strong) NSArray *PhotoUrl;
@property(nonatomic, assign) NSInteger Rating;

@end
