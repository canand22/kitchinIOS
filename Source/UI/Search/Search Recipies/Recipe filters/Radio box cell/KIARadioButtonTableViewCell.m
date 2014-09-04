//
//  KIARadioButtonTableViewCell.m
//  KitchInApp
//
//  Created by DeMoN on 8/22/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIARadioButtonTableViewCell.h"

#import "KIAFilterSettings.h"

@implementation KIARadioButtonTableViewCell

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
    
    if ([_key isEqualToString:@"Meal"])
    {
        [[KIAFilterSettings sharedFilterManager] setMeal:valueClick];
    }
    
    if ([_key isEqualToString:@"Dish Type"])
    {
        [[KIAFilterSettings sharedFilterManager] setDishType:valueClick];
    }
    
    if ([_key isEqualToString:@"Time"])
    {
        [[KIAFilterSettings sharedFilterManager] setTime:valueClick];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTableContent" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
