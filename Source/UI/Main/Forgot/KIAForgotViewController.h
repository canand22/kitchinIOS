//
//  KIAForgotViewController.h
//  KitchInApp
//
//  Created by DeMoN on 1/17/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "forgotProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIAForgotViewController : UIViewController<serverGatewayDelegate, UIAlertViewDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *_email;
    
    __weak id<forgotProtocol> _forgotGateway;
    
    IBOutlet UIView *_mainView;
}

@property(nonatomic, weak) id<forgotProtocol> forgotGateway;

- (IBAction)forgot:(id)sender;
- (IBAction)back:(id)sender;

@end
