//
//  KIAChangeUserInfoViewController.m
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAChangeUserInfoViewController.h"

#import "KIAServerGateway.h"

@interface KIAChangeUserInfoViewController ()

@end

@implementation KIAChangeUserInfoViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _editUserInfoGateway = [KIAServerGateway gateway];
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
    
    falseData = ([[_firstName text] length] > 0 && [[_lastName text] length] > 0 && falseData == NO ? NO : YES);
    
    if (falseData)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please enter valid first name or last name."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        [_editUserInfoGateway changeFirstName:[_firstName text] changeLastName:[_lastName text] delegate:self];
    }
}

- (void)loginSuccess:(BOOL)success
{
    if (success)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[_firstName text] forKey:@"firstName"];
        [[NSUserDefaults standardUserDefaults] setObject:[_lastName text] forKey:@"lastName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
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
