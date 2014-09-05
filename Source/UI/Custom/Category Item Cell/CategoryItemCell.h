//
//  CategoryItemCell.h
//  KitchInApp
//
//  Created by DeMoN on 3/3/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EditRecognizedItemCellDelegate.h"

@interface CategoryItemCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, weak) id<EditRecognizedItemCellDelegate> delegate;

@property(nonatomic, strong) IBOutlet UILabel *itemName;

@property(nonatomic, strong) IBOutlet UITextField *countIngredient;
@property(nonatomic, strong) IBOutlet UIButton *valueBtn;

- (IBAction)unitAction:(id)sender;

@end
