//
//  KIARemoveOrAddTableViewCell.m
//  KitchInApp
//
//  Created by DeMoN on 9/10/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIARemoveOrAddTableViewCell.h"

@implementation KIARemoveOrAddTableViewCell

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subview in self.subviews)
    {
        for (UIView *subview2 in subview.subviews)
        {
            if ([NSStringFromClass([subview2 class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"])
            {
                if (_isRemoveCell)
                {
                    ((UIView *)[subview2.subviews firstObject]).backgroundColor = [UIColor redColor];
                }
                else
                {
                    ((UIView *)[subview2.subviews firstObject]).backgroundColor = [UIColor blueColor];
                }
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
