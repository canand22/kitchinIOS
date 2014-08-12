//
//  KIAMealSettingsTableViewCell.h
//  KitchInApp
//
//  Created by DeMoN on 8/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KIAMealSettingsTableViewCellProtocol.h"

@interface KIAMealSettingsTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, weak) id<KIAMealSettingsTableViewCellProtocol> delegate;

@property(nonatomic, strong) IBOutlet UILabel *setLabel;

@property(nonatomic, strong) IBOutlet UITextField *nameField;
@property(nonatomic, strong) IBOutlet UIButton *activeBtn;
@property(nonatomic, strong) IBOutlet UIButton *removeBtn;
@property(nonatomic, strong) IBOutlet UIButton *dietaryRestrictionsBtn;

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) BOOL isActive;

@end
