//
//  KIACheckBoxTableViewCell.m
//  KitchInApp
//
//  Created by DeMoN on 8/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIACheckBoxTableViewCell.h"

#import "KIAFilterSettings.h"

#define CHECK_BUTTON_ACTIVE @"ceckbox_active.png"
#define CHECK_BUTTON_DEACTIVE @"ceckbox.png"

@implementation KIACheckBoxTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Initialization code
        _key = [[NSString alloc] init];
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (IBAction)clickButtonAction:(id)sender
{
    NSString *valueClick = [(UIButton *)sender titleForState:UIControlStateNormal];
    
    if ([[self key] isEqualToString:@"Cuisine"])
    {
        if ([[[KIAFilterSettings sharedFilterManager] cuisine] containsObject:valueClick])
        {
            [[[KIAFilterSettings sharedFilterManager] cuisine] removeObject:valueClick];
            [sender setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
        }
        else
        {
            [[[KIAFilterSettings sharedFilterManager] cuisine] addObject:valueClick];
            [sender setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
        }
    }
    
    if ([[self key] isEqualToString:@"Holiday"])
    {
        if ([[[KIAFilterSettings sharedFilterManager] holiday] containsObject:valueClick])
        {
            [[[KIAFilterSettings sharedFilterManager] holiday] removeObject:valueClick];
            [sender setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
        }
        else
        {
            [[[KIAFilterSettings sharedFilterManager] holiday] addObject:valueClick];
            [sender setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
        }
    }
    
    if ([[self key] isEqualToString:@"Allergy"])
    {
        if ([[[KIAFilterSettings sharedFilterManager] allergy] containsObject:valueClick])
        {
            [[[KIAFilterSettings sharedFilterManager] allergy] removeObject:valueClick];
            [sender setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
        }
        else
        {
            [[[KIAFilterSettings sharedFilterManager] allergy] addObject:valueClick];
            [sender setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
        }
    }
    
    if ([[self key] isEqualToString:@"Diet"])
    {
        if ([[[KIAFilterSettings sharedFilterManager] diet] containsObject:valueClick])
        {
            [[[KIAFilterSettings sharedFilterManager] diet] removeObject:valueClick];
            [sender setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
        }
        else
        {
            [[[KIAFilterSettings sharedFilterManager] diet] addObject:valueClick];
            [sender setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTableContent" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
