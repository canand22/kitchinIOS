//
//  KIANewItemWithStoreViewController.h
//  KitchInApp
//
//  Created by DeMoN on 1/27/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "addNewItemProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIANewItemWithStoreViewController : UIViewController<serverGatewayDelegate>
{
    id<addNewItemProtocol> _addItemGateway;
}

@property(nonatomic, strong) id<addNewItemProtocol> addItemGateway;

@property(nonatomic, strong) IBOutlet UITextField *foodType;
@property(nonatomic, strong) IBOutlet UITextField *itemText;

@property(nonatomic, strong) NSString *categoryName;

@property(nonatomic, assign) BOOL isRecognition;

@end
