//
//  KIASearchViewController.h
//  KithInApp
//
//  Created by DeMoN on 8/5/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "yamlyProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIASearchViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, serverGatewayDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    id<yamlyProtocol> _yummlyGateway;
    
    NSArray *_whereSearchArray;
    
    NSMutableArray *_autocompleteArray;
    NSMutableArray *_ingredientArray;
    
    BOOL isAlertShow;
    
    NSArray *_categoriesArray;
}

@property(nonatomic, strong) IBOutlet UIImageView *pickerFon;
@property(nonatomic, strong) IBOutlet UIPickerView *picker;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicator;

@property(nonatomic, strong) IBOutlet UIButton *whereSearchBtn;

@property(nonatomic, strong) IBOutlet UITableView *autocompleteTable;
@property(nonatomic, strong) IBOutlet UITableView *ingreditntsTable;

@property(nonatomic, strong) IBOutlet UILabel *whereSearch;

@property(nonatomic, strong) IBOutlet UITextField *searchField;

@end
