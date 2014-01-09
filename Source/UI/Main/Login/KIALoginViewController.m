// ************************************************ //
//                                                  //
//  KIALoginViewController.m                        //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/27/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIALoginViewController.h"

#import "KIAServerGateway.h"

@interface KIALoginViewController ()

@end

@implementation KIALoginViewController

@synthesize loginGateway = _loginGateway;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _loginGateway = [KIAServerGateway gateway];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)login:(id)sender
{
    NSString *loginString = [_login text];
    NSString *passString = [_pass text];
    
    [_loginGateway loginUser:loginString withPassword:passString delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
