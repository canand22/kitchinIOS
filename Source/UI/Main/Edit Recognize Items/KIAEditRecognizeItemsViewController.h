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

#import "getCategoryItemProtocol.h"
#import "serverGatewayDelegate.h"

#import "EditRecognizedItemCellDelegate.h"

@interface KIAEditRecognizeItemsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, EditRecognizedItemCellDelegate, UIPickerViewDataSource, UIPickerViewDelegate, serverGatewayDelegate>
{
    id<getCategoryItemProtocol> _getItemGateway;
}

@property(nonatomic, strong) NSMutableArray *itemArray;
@property(nonatomic, strong) NSArray *unitArray;
@property(nonatomic, strong) NSArray *unitReductionArray;
@property(nonatomic, strong) NSDictionary *category;

@property(nonatomic, strong) id<getCategoryItemProtocol> getItemGateway;

@property(nonatomic, strong) IBOutlet UITableView *table;

- (IBAction)addToMyKitchIn:(id)sender;

@end
