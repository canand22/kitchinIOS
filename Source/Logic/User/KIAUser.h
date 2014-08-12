//
//  KIAUser.h
//  KitchInApp
//
//  Created by DeMoN on 8/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KIAUser : NSManagedObject

@property(nonatomic, strong) NSNumber *idUser;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) NSNumber *isActiveState;
@property(nonatomic, strong) NSMutableArray *dislikeIngredients;
@property(nonatomic, strong) NSMutableArray *dietaryRestrictions;

@end
