//
//  EditRecognizedItemCell.m
//  KitchInApp
//
//  Created by DeMoN on 1/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "EditRecognizedItemCell.h"

@implementation EditRecognizedItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        // Initialization code
    }
    
    return self;
}

- (IBAction)unrecognize:(id)sender
{
    [_delegate showActionSheet:[self tag]];
}

- (IBAction)unitAction:(id)sender
{
    [_delegate showPickerView:[self tag]];
}

- (IBAction)deleteItem:(id)sender
{
    [_delegate deleteItemFromIndex:[self tag]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
