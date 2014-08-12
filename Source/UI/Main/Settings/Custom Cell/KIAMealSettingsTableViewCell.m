//
//  KIAMealSettingsTableViewCell.m
//  KitchInApp
//
//  Created by DeMoN on 8/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAMealSettingsTableViewCell.h"

#define BUTTON_TAG 100
#define BUTTON_ACTIVE_IMAGE @"button_switch_active.png"
#define BUTTON_DEACTIVE_IMAGE @"button_switch.png"

@implementation KIAMealSettingsTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Initialization code
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        // Initialization code
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setIsActive:(BOOL)isActive
{
    _isActive = isActive;
    
    if (_isActive)
    {
        [_activeBtn setBackgroundImage:[UIImage imageNamed:BUTTON_ACTIVE_IMAGE] forState:UIControlStateNormal];
        [_activeBtn setBackgroundImage:[UIImage imageNamed:BUTTON_ACTIVE_IMAGE] forState:UIControlStateHighlighted];
    }
    else
    {
        [_activeBtn setBackgroundImage:[UIImage imageNamed:BUTTON_DEACTIVE_IMAGE] forState:UIControlStateNormal];
        [_activeBtn setBackgroundImage:[UIImage imageNamed:BUTTON_DEACTIVE_IMAGE] forState:UIControlStateHighlighted];
    }
}

#pragma mark ***** text field delegate *****

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [_delegate updateObjectAtIndex:[_removeBtn tag] - BUTTON_TAG];
    
    return YES;
}

- (IBAction)deleteAction:(UIButton *)sender
{
    [_delegate removeObjectAtIndex:[sender tag] - BUTTON_TAG];
}

- (IBAction)dietaryRestrictionsAction:(id)sender
{
    [_delegate dietaryRestrictionsAtIndex:[_removeBtn tag] - BUTTON_TAG];
}

- (IBAction)activeAction:(id)sender
{
    [self setIsActive:!_isActive];
    
    if (_isActive)
    {
        [_activeBtn setBackgroundImage:[UIImage imageNamed:BUTTON_ACTIVE_IMAGE] forState:UIControlStateNormal];
        [_activeBtn setBackgroundImage:[UIImage imageNamed:BUTTON_ACTIVE_IMAGE] forState:UIControlStateHighlighted];
    }
    else
    {
        [_activeBtn setBackgroundImage:[UIImage imageNamed:BUTTON_DEACTIVE_IMAGE] forState:UIControlStateNormal];
        [_activeBtn setBackgroundImage:[UIImage imageNamed:BUTTON_DEACTIVE_IMAGE] forState:UIControlStateHighlighted];
    }
    
    [_delegate activeAtIndex:[_removeBtn tag] - BUTTON_TAG];
}

#pragma mark *****

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
