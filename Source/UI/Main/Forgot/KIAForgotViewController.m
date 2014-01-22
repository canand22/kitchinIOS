//
//  KIAForgotViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/17/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAForgotViewController.h"

#import "KIAServerGateway.h"

@interface KIAForgotViewController ()

@end

@implementation KIAForgotViewController

@synthesize forgotGateway = _forgotGateway;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _forgotGateway = [KIAServerGateway gateway];
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
    frame.origin.y = 20;
    frame.size.height -= MIN(keyboardBounds.size.height, keyboardBounds.size.width) - 40;
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

- (IBAction)forgot:(id)sender
{
    BOOL falseData = NO;
    
    falseData = ([[_email text] length] > 0 && [self validateEmail:[_email text]] && falseData == NO ? NO : YES);
    
    if (falseData)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Incorrectly entered data!!!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        [_forgotGateway forgotPasswordWithEmail:[_email text] delegate:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 0 && [string isEqualToString:@" "])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Not found, so remove keyboard.
    [textField resignFirstResponder];
        
    [self forgot:nil];
    
    return NO; // We do not want UITextField to insert line-breaks.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
