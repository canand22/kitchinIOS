//
//  CategoryItemCell.m
//  KitchInApp
//
//  Created by DeMoN on 3/3/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "CategoryItemCell.h"

@implementation CategoryItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        // Initialization code
    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_countIngredient resignFirstResponder];
    
    return YES;
}

- (IBAction)unitAction:(id)sender
{
    [_delegate showPickerView:[self tag]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
