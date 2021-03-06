//
//  KIARegisterViewController.h
//  KitchInApp
//
//  Created by DeMoN on 1/14/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "registerProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIARegisterViewController : UIViewController<serverGatewayDelegate, UIAlertViewDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *_firstName;
    IBOutlet UITextField *_lastName;
    IBOutlet UITextField *_email;
    IBOutlet UITextField *_password;
    IBOutlet UITextField *_replasePassword;
    
    IBOutlet UIView *_mainView;
    IBOutlet UIScrollView *_scroll;
    
    id<registerProtocol> _registerGateway;
    
    BOOL isRequestLoad;
}

@property(nonatomic, strong) id<registerProtocol> registerGateway;

- (IBAction)back:(id)sender;

@end
