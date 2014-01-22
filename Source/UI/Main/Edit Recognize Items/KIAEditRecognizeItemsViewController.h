// ************************************************ //
//                                                  //
//  KIAEditRecognizeItemsViewController.h           //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

#import "EditRecognizedItemCellDelegate.h"

@interface KIAEditRecognizeItemsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, EditRecognizedItemCellDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic, strong) NSArray *itemArray;
@property(nonatomic, strong) NSArray *unitArray;
@property(nonatomic, strong) NSArray *unitReductionArray;
@property(nonatomic, strong) IBOutlet UITableView *table;

- (IBAction)addToMyKitchIn:(id)sender;

@end
