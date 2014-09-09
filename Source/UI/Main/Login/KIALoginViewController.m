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

#import "KIAUpdater.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

#pragma mark ***** keyboard *****

- (void)keyboardDidShow:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[[note userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardBounds];
		
    CGRect frame = [_mainView frame];
    frame.origin.y = 5;
    frame.size.height -= MIN(keyboardBounds.size.height, keyboardBounds.size.width) - 90;
    [_mainView setFrame:frame];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[[note userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];

    CGRect frame = [_mainView frame];
    frame.origin.y = 29;
    frame.size.height += MIN(keyboardBounds.size.height, keyboardBounds.size.width) - 40;
    [_mainView setFrame:frame];
}

#pragma mark *****

- (BOOL)validateEmail:(NSString *)candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

- (IBAction)login:(id)sender
{
    BOOL falseData = NO;

    falseData = ([[_login text] length] > 0 && [self validateEmail:[_login text]] && falseData == NO ? NO : YES);
    falseData = ([[_pass text] length] > 0 && falseData == NO ? NO : YES);
    
    if (falseData)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please enter email and password."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        [_loginGateway loginUser:[_login text] withPassword:[_pass text] delegate:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    
    // Try to find next responder
    UIResponder *nextResponder = [[textField superview] viewWithTag:nextTag];
    
    if (nextResponder)
    {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    }
    else
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        
        [self login:nil];
    }
    
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)loginSuccess:(BOOL)success
{
    if (success)
    {
        NSArray *temp = [[KIAUpdater sharedUpdater] getAllUsers];
        
        if ([temp count] == 0)
        {
            [[KIAUpdater sharedUpdater] addUserWithId:0 name:[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"] state:@YES];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"User is not found. Please ensure that you have entered correct email and password."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
