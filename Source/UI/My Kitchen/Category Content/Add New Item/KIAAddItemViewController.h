//
//  KIAAddItemViewController.h
//  KitchInApp
//
//  Created by DeMoN on 1/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "searchItemProtocol.h"
#import "yamlyProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIAAddItemViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, serverGatewayDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    id<searchItemProtocol> _searchItemGateway;
    id<yamlyProtocol> _yummlySearchItemGateway;
    
    NSArray *_storeArray;
    
    IBOutlet UITableView *_table;
    NSMutableArray *_itemArray;
    
    IBOutlet UITextField *_itemTextField;
    
    NSInteger indexOfItem;
    
    BOOL isBlock;
}

@property(nonatomic, strong) id<searchItemProtocol> searchItemGateway;
@property(nonatomic, strong) id<yamlyProtocol> yummlySearchItemGateway;

@property(nonatomic, strong) IBOutlet UIImageView *pickerFon;
@property(nonatomic, strong) IBOutlet UIPickerView *picker;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicator;

@property(nonatomic, strong) IBOutlet UITextField *selectStoreTextFild;

@property(nonatomic, strong) IBOutlet UIView *addNewItem;
@property(nonatomic, strong) IBOutlet UIView *addKitchInItem;

@property(nonatomic, strong) NSString *categoryName;

@property(nonatomic, assign) BOOL isRecognition;

@end
