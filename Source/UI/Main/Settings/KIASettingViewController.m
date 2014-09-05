// ************************************************ //
//                                                  //
//  KIASettingViewController.m                      //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/23/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIASettingViewController.h"
#import "KIALoginViewController.h"

#import "KIAServerGateway.h"

#import "KIAMealSettingsTableViewCell.h"
#import "KIAMealSettingsViewController.h"

#import "KIAUpdater.h"
#import "KIAUser.h"

#define BUTTON_TAG 100
#define VIEW_TAG   200

@interface KIASettingViewController ()

@end

@implementation KIASettingViewController

@synthesize logoutGateway = _logoutGateway;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _logoutGateway = [KIAServerGateway gateway];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _users = [[[KIAUpdater sharedUpdater] getAllUsers] mutableCopy];
    
    [_table reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"])
    {
        [_loginBtn setEnabled:NO];
        [_logoutBtn setEnabled:YES];
        
        [_firstName setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"]];
        [_lastName setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"email"]];
    }
    else
    {
        [_loginBtn setEnabled:YES];
        [_logoutBtn setEnabled:NO];
    }
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)myAccount:(id)sender
{
    for (int i = 0; i < 4; i++)
    {
        if ([sender tag] != BUTTON_TAG + i)
        {
            [(UIButton *)[[self view] viewWithTag:BUTTON_TAG + i] setBackgroundImage:[UIImage imageNamed:@"top_menu_button.png"]
                                                                            forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:0.0f];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"top_menu_button_active.png"] forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:1.0f];
        }
    }
}

- (IBAction)notifications:(id)sender
{
    for (int i = 0; i < 4; i++)
    {
        if ([sender tag] != BUTTON_TAG + i)
        {
            [(UIButton *)[[self view] viewWithTag:BUTTON_TAG + i] setBackgroundImage:[UIImage imageNamed:@"top_menu_button.png"]
                                                                            forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:0.0f];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"top_menu_button_active.png"] forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:1.0f];
        }
    }
}

- (IBAction)mealSetting:(id)sender
{
    for (int i = 0; i < 4; i++)
    {
        if ([sender tag] != BUTTON_TAG + i)
        {
            [(UIButton *)[[self view] viewWithTag:BUTTON_TAG + i] setBackgroundImage:[UIImage imageNamed:@"top_menu_button.png"]
                                                                            forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:0.0f];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"top_menu_button_active.png"] forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:1.0f];
        }
    }
}

- (IBAction)help:(id)sender
{
    for (int i = 0; i < 4; i++)
    {
        if ([sender tag] != BUTTON_TAG + i)
        {
            [(UIButton *)[[self view] viewWithTag:BUTTON_TAG + i] setBackgroundImage:[UIImage imageNamed:@"top_menu_button.png"]
                                                                            forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:0.0f];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"top_menu_button_active.png"] forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:1.0f];
        }
    }
}

#pragma mark ***** My Account Setting *****

- (IBAction)changeUserName:(id)sender
{
    // a
}

- (IBAction)changePassword:(id)sender
{
    // b
}

- (IBAction)facebookClick:(id)sender
{
    // c
}

- (IBAction)twitterClick:(id)sender
{
    // d
}

- (IBAction)pinterestClick:(id)sender
{
    // e
}

- (IBAction)login:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"])
    {
        NSLog(@"YES");
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIALoginViewController *loginViewController = (KIALoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (IBAction)logout:(id)sender
{
    [_logoutGateway logoutWithDelegate:self];
}

- (void)loginSuccess:(BOOL)success
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"])
    {
        [_loginBtn setEnabled:NO];
        [_logoutBtn setEnabled:YES];
    }
    else
    {
        [_loginBtn setEnabled:YES];
        [_logoutBtn setEnabled:NO];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark *****
#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIAMealSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setDelegate:self];
    
    [[cell removeBtn] setTag:[indexPath row] + BUTTON_TAG];
    [[cell setLabel] setText:[NSString stringWithFormat:@"Set %d:", (int)[indexPath row] + 1]];
    [[cell nameField] setText:[[_users objectAtIndex:[indexPath row]] name]];
    [cell setIsActive:[[_users objectAtIndex:[indexPath row]] isActiveState].boolValue];
    [[cell dietaryRestrictionsBtn] setTitle:([[[_users objectAtIndex:[indexPath row]] dietaryRestrictions] count] > 0 ? [NSString stringWithFormat:@"%d", (int)[[[_users objectAtIndex:[indexPath row]] dietaryRestrictions] count]] : @"NONE") forState:UIControlStateNormal];
    
    return cell;
}

- (void)updateObjectAtIndex:(NSInteger)index
{
    KIAUser *user = [_users objectAtIndex:index];
    
    KIAMealSettingsTableViewCell *cell = (KIAMealSettingsTableViewCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [user setName:[[cell nameField] text]];
    
    [[KIAUpdater sharedUpdater] updateUsersInfo:user];
}

- (void)removeObjectAtIndex:(NSInteger)index
{
    [[KIAUpdater sharedUpdater] removeUser:[_users objectAtIndex:index]];
    
    _users = [[[KIAUpdater sharedUpdater] getAllUsers] mutableCopy];
    
    [_table reloadData];
}

- (void)dietaryRestrictionsAtIndex:(NSInteger)index
{
    _index = index;
}

- (void)activeAtIndex:(NSInteger)index
{
    KIAUser *user = [_users objectAtIndex:index];
    
    KIAMealSettingsTableViewCell *cell = (KIAMealSettingsTableViewCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [user setIsActiveState:[NSNumber numberWithBool:[cell isActive]]];
    
    [[KIAUpdater sharedUpdater] updateUsersInfo:user];
}

#pragma mark *****

- (IBAction)addUserAction:(id)sender
{
    [[KIAUpdater sharedUpdater] addUserWithId:[_users count] name:@""];
    
    _users = [[[KIAUpdater sharedUpdater] getAllUsers] mutableCopy];
    
    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark ***** Navigation *****
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"mealSettingSegue"])
    {
        KIAMealSettingsViewController *viewController = (KIAMealSettingsViewController *)[segue destinationViewController];
        [viewController setUser:[_users objectAtIndex:_index]];
    }
 }

@end
