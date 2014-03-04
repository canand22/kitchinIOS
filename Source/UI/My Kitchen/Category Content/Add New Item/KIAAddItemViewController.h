//
//  KIAAddItemViewController.h
//  KitchInApp
//
//  Created by DeMoN on 1/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "searchItemProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIAAddItemViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, serverGatewayDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    id<searchItemProtocol> _searchItemGateway;
    
    NSArray *_storeArray;
    
    IBOutlet UITableView *_table;
    NSArray *_itemArray;
    
    IBOutlet UITextField *_itemTextField;
    
    NSInteger indexOfItem;
}

@property(nonatomic, strong) id<searchItemProtocol> searchItemGateway;

@property(nonatomic, strong) IBOutlet UIPickerView *picker;

@property(nonatomic, strong) IBOutlet UITextField *selectStoreTextFild;

@property(nonatomic, strong) IBOutlet UIView *addNewItem;
@property(nonatomic, strong) IBOutlet UIView *addKitchInItem;

@property(nonatomic, strong) NSString *categoryName;

@end
