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

@synthesize dislikeArray = _dislikeArray;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Initialization code
        [self setHeight:180];
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
    [_dislikeList setTagDelegate:self];
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

- (void)setDislikeArray:(NSMutableArray *)dislikeArray
{
    _dislikeArray = [[NSMutableArray alloc] initWithArray:dislikeArray];
    
    [_dislikeList setTags:_dislikeArray];
    
    CGRect frame = [_dislikeView frame];
    frame.size.height = ([_dislikeList fittedSize].height + 6 < 35 ? 35 : [_dislikeList fittedSize].height + 6);
    [_dislikeView setFrame:frame];
    
    [self reloadFrameWithHeight:[_dislikeView frame].size.height + [_dislikeView frame].origin.y];
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

- (IBAction)dislikeAction:(id)sender
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

#pragma mark ***** DWTagList delegate *****

- (void)tagViewWantsToBeDeleted:(DWTagView *)tagView
{
}

- (void)tagListTagsChanged:(DWTagList *)tagList
{
}

- (void)selectedTag:(NSString *)tagName
{
    if ([_dislikeArray containsObject:tagName])
    {
        [_dislikeArray removeObject:tagName];
        
        [_dislikeList setTags:_dislikeArray];
        
        CGRect frame = [_dislikeView frame];
        frame.size.height = ([_dislikeList fittedSize].height + 6 < 35 ? 35 : [_dislikeList fittedSize].height + 6);
        [_dislikeView setFrame:frame];
        
        [self reloadFrameWithHeight:[_dislikeView frame].size.height + [_dislikeView frame].origin.y];
        
        [_delegate updateTableForIndex:[_removeBtn tag] - BUTTON_TAG dislike:_dislikeArray];
    }
}

- (void)reloadFrameWithHeight:(CGFloat)height
{
    CGRect frame = [_dietaryRestrictionsLbl frame];
    frame.origin.y = height + 6;
    [_dietaryRestrictionsLbl setFrame:frame];
    
    frame = [_dietaryRestrictionsBtn frame];
    frame.origin.y = height + 6;
    [_dietaryRestrictionsBtn setFrame:frame];
}

#pragma mark *****

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
