//
//  EditRecognizedItemCell.h
//  KitchInApp
//
//  Created by DeMoN on 1/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EditRecognizedItemCellDelegate.h"

@interface EditRecognizedItemCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, weak) id<EditRecognizedItemCellDelegate> delegate;

@property(nonatomic, strong) IBOutlet UIButton *textField;
@property(nonatomic, strong) IBOutlet UIButton *unit;
@property(nonatomic, strong) IBOutlet UIButton *deleteButton;
@property(nonatomic, strong) IBOutlet UITextField *countField;

- (IBAction)unrecognize:(id)sender;
- (IBAction)unitAction:(id)sender;
- (IBAction)deleteItem:(id)sender;

@end
