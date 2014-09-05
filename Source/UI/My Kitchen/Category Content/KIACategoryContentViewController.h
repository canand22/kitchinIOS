// ************************************************ //
//                                                  //
//  KIACategoryContentViewController.h              //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

#import "EditRecognizedItemCellDelegate.h"

@interface KIACategoryContentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, EditRecognizedItemCellDelegate>
{
    NSArray *_categoryItems;
}

@property(nonatomic, strong) NSArray *unitArray;
@property(nonatomic, strong) NSArray *unitReductionArray;

@property(nonatomic, strong) NSString *categoryName;

@property(nonatomic, strong) IBOutlet UILabel *categoryTitle;
@property(nonatomic, strong) IBOutlet UIImageView *categoryImage;

@property(nonatomic, strong) IBOutlet UITableView *table;

@end
