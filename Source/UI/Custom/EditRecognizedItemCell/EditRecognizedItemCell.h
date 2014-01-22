//
//  EditRecognizedItemCell.h
//  KitchInApp
//
//  Created by DeMoN on 1/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EditRecognizedItemCellDelegate.h"

@interface EditRecognizedItemCell : UITableViewCell

@property(nonatomic, assign) id<EditRecognizedItemCellDelegate> delegate;

@property(nonatomic, strong) IBOutlet UIButton *textField;
@property(nonatomic, strong) IBOutlet UIButton *unit;

- (IBAction)unrecognize:(id)sender;
- (IBAction)unitAction:(id)sender;

@end
