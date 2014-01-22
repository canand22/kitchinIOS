//
//  KIAAddItemViewController.h
//  KitchInApp
//
//  Created by DeMoN on 1/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "getCategoryItemProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIAAddItemViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, serverGatewayDelegate>
{
    id<getCategoryItemProtocol> _getItemGateway;
    
    NSArray *_storeArray;
}

@property(nonatomic, strong) id<getCategoryItemProtocol> getItemGateway;

@property(nonatomic, strong) IBOutlet UIPickerView *picker;

@property(nonatomic, strong) IBOutlet UITextField *selectStoreTextFild;

@property(nonatomic, strong) IBOutlet UIView *addNewItem;
@property(nonatomic, strong) IBOutlet UIView *addKitchInItem;

@end
