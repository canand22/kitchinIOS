//
//  KIAMealSettingsViewController.h
//  KitchInApp
//
//  Created by DeMoN on 8/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KIAUser;

@interface KIAMealSettingsViewController : UIViewController

@property(nonatomic, assign) KIAUser *user;
@property(nonatomic, strong) NSMutableArray *avaibleItem;

@end
