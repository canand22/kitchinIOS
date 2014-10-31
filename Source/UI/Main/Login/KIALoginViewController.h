// ************************************************ //
//                                                  //
//  KIALoginViewController.h                        //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/27/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

#import "autorizationProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIALoginViewController : UIViewController<serverGatewayDelegate, UITextFieldDelegate>
{
    id<autorizationProtocol> _loginGateway;
    
    IBOutlet UIView *_mainView;
    IBOutlet UIScrollView *_scroll;
    
    CGRect _mainFrame;
    CGRect _scrollFrame;
    
    BOOL isRequestLoad;
}

@property(nonatomic, strong) id<autorizationProtocol> loginGateway;

@property(nonatomic, strong) IBOutlet UITextField *login;
@property(nonatomic, strong) IBOutlet UITextField *pass;

@end
