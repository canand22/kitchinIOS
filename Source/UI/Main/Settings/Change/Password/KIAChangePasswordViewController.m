//
//  KIAChangePasswordViewController.m
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAChangePasswordViewController.h"

#import "KIAServerGateway.h"

@interface KIAChangePasswordViewController ()

@end

@implementation KIAChangePasswordViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _editPasswordGateway = [KIAServerGateway gateway];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)save:(id)sender
{
    BOOL falseData = NO;
    
    falseData = ([[_oldPass text] length] > 0 && [[_pass text] length] > 0 && [[_pass text] isEqualToString:[_confirmPass text]] && falseData == NO ? NO : YES);
    
    if (falseData)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please enter valid password."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        [_editPasswordGateway newPassword:[_pass text] oldPassword:[_oldPass text] delegate:self];
    }
}

- (void)loginSuccess:(BOOL)success
{
    if (success)
    {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark ***** keyboard *****

- (void)keyboardDidShow:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[[note userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardBounds];
    
    CGRect frame = [_mainView frame];
    frame.origin.y = 5;
    [_mainView setFrame:frame];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[[note userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    CGRect frame = [_mainView frame];
    frame.origin.y = 56;
    [_mainView setFrame:frame];
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
        
        [self save:nil];
    }
    
    return NO; // We do not want UITextField to insert line-breaks.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
