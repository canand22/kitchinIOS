//
//  KIARegisterViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/14/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIARegisterViewController.h"

#import "KIAServerGateway.h"

@interface KIARegisterViewController ()

@end

@implementation KIARegisterViewController

@synthesize registerGateway = _registerGateway;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _registerGateway = [KIAServerGateway gateway];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [_scroll setContentSize:CGSizeMake(268, 296)];
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

- (IBAction)register:(id)sender
{
    BOOL falseData = NO;
    
    NSString *errorMessage;
    
    if (!([[_firstName text] length] > 0 && falseData == NO) || !([[_lastName text] length] > 0 && falseData == NO))
    {
        falseData = YES;
        errorMessage = @"Please enter first name or last name.";
    }
    
    if (!([[_email text] length] > 0 && [self validateEmail:[_email text]] && falseData == NO))
    {
        falseData = YES;
        errorMessage = @"Please enter valid email address.";
    }

    if ([[_password text] length] > 0 && [[_password text] isEqualToString:[_replasePassword text]] && falseData == NO)
    {
        falseData = YES;
        errorMessage = @"Passwords do not match.";
    }
    
    if (falseData)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        [_registerGateway registerUser:[_email text] withPassword:[_password text] firstName:[_firstName text] lastName:[_lastName text] delegate:self];
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
        
        [self register:nil];
    }
    
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)loginSuccess:(BOOL)success
{
    if (success)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Congratulations, you are registered. Enjoy your digital kitchen"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Email account already registered."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender
{
    [_firstName resignFirstResponder];
    [_lastName resignFirstResponder];
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    [_replasePassword resignFirstResponder];
    
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
