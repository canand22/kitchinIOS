//
//  KIAFavorite.h
//  KitchInApp
//
//  Created by DeMoN on 9/1/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface KIAFavorite : NSManagedObject

@property(nonatomic, strong) NSString *recipeId;
@property(nonatomic, strong) NSString *recipeName;
@property(nonatomic, strong) NSString *recipeUrl;
@property(nonatomic, strong) NSNumber *rating;
@property(nonatomic, strong) NSNumber *served;
@property(nonatomic, strong) NSNumber *time;
@property(nonatomic, strong) NSString *picture;
@property(nonatomic, strong) NSArray *ingredients;

@end
