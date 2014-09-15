//
//  KIAChangePasswordViewController.h
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "serverGatewayDelegate.h"
#import "editPasswordProtocol.h"

@interface KIAChangePasswordViewController : UIViewController<serverGatewayDelegate, UITextFieldDelegate>
{
    IBOutlet UIView *_mainView;
}

@property(nonatomic, strong) id<editPasswordProtocol> editPasswordGateway;

@property(nonatomic, strong) IBOutlet UITextField *oldPass;
@property(nonatomic, strong) IBOutlet UITextField *pass;
@property(nonatomic, strong) IBOutlet UITextField *confirmPass;

@end
