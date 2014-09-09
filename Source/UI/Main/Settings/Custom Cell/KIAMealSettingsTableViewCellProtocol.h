//
//  KIAMealSettingsTableViewCellProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 8/7/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KIAMealSettingsTableViewCellProtocol<NSObject>

- (void)updateObjectAtIndex:(NSInteger)index;
- (void)removeObjectAtIndex:(NSInteger)index;
- (void)dietaryRestrictionsAtIndex:(NSInteger)index;
- (void)activeAtIndex:(NSInteger)index;
- (void)updateTableForIndex:(NSInteger)index;

@end
