//
//  KIAButtonTableViewCell.m
//  KitchInApp
//
//  Created by DeMoN on 9/4/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAButtonTableViewCell.h"

@implementation KIAButtonTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
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

- (IBAction)removeIngredients:(id)sender
{
    [_delegate removeIngredients];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
