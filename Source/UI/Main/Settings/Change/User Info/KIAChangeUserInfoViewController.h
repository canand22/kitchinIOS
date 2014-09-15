//
//  KIAChangeUserInfoViewController.h
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "serverGatewayDelegate.h"
#import "editUserInfoProtocol.h"

@interface KIAChangeUserInfoViewController : UIViewController<serverGatewayDelegate, UITextFieldDelegate>
{
    IBOutlet UIView *_mainView;
}

@property(nonatomic, strong) id<editUserInfoProtocol> editUserInfoGateway;

@property(nonatomic, strong) IBOutlet UITextField *firstName;
@property(nonatomic, strong) IBOutlet UITextField *lastName;

@end
