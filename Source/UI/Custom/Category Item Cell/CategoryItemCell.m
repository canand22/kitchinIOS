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

- (IBAction)deleteItem:(id)sender
{
    [_delegate deleteItemFromIndex:[sender tag]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
