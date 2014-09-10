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
#import "KIAFindIngrediensViewController.h"

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
    /*_users = [[[KIAUpdater sharedUpdater] getAllUsers] mutableCopy];
    [_users sortUsingComparator:^NSComparisonResult (id obj1, id obj2)
    {
        NSInteger firstID = [[obj1 idUser] integerValue];
        NSInteger secondID = [[obj2 idUser] integerValue];
        
        if (firstID < secondID)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else if (firstID > secondID)
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    if ([_users count] > 0)
    {
        if (![[[_users objectAtIndex:[_users count] - 1] name] isEqualToString:@""])
        {
            [_users addObject:[[KIAUpdater sharedUpdater] addUserWithId:[_users count] name:@""]];
        
            [_table reloadData];
        }
    }*/
    
    _index = -1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_table reloadData];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"])
    {
        [_loginBtn setEnabled:NO];
        [_logoutBtn setEnabled:YES];
        
        [_firstName setText:[NSString stringWithFormat:@"%@ %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"], [[NSUserDefaults standardUserDefaults] objectForKey:@"lastName"]]];
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
    
    _users = [[[KIAUpdater sharedUpdater] getAllUsers] mutableCopy];
    [_users sortUsingComparator:^NSComparisonResult (id obj1, id obj2)
    {
        NSInteger firstID = [[obj1 idUser] integerValue];
        NSInteger secondID = [[obj2 idUser] integerValue];
         
        if (firstID < secondID)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else if (firstID > secondID)
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    if ([_users count] > 0)
    {
        if (![[[_users objectAtIndex:[_users count] - 1] name] isEqualToString:@""])
        {
            [_users addObject:[[KIAUpdater sharedUpdater] addUserWithId:[_users count] name:@"" state:@NO]];
        }
        
        [_table reloadData];
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
    
    KIAUser *temp = [_users objectAtIndex:[indexPath row]];
    
    [[cell removeBtn] setTag:[indexPath row] + BUTTON_TAG];
    [[cell setLabel] setText:[NSString stringWithFormat:@"Set %d:", (int)[indexPath row] + 1]];
    [[cell nameField] setText:[temp name]];
    [cell setIsActive:[temp isActiveState].boolValue];
    [[cell dietaryRestrictionsBtn] setTitle:([[temp dietaryRestrictions] count] > 0 ? [NSString stringWithFormat:@"%d", (int)[[temp dietaryRestrictions] count]] : @"NONE") forState:UIControlStateNormal];
    [cell setDislikeArray:[temp dislikeIngredients]];
    
    if ([indexPath row] == 0)
    {
        [[cell removeBtn] setEnabled:NO];
        [[cell nameField] setUserInteractionEnabled:NO];
    }
    else
    {
        [[cell removeBtn] setEnabled:YES];
        [[cell nameField] setUserInteractionEnabled:YES];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[_users objectAtIndex:[indexPath row]] dislikeIngredients] count] > 0)
    {
        DWTagList *temp = [[DWTagList alloc] initWithFrame:CGRectMake(0, 0, 274, 29)];
        [temp setTags:[[_users objectAtIndex:[indexPath row]] dislikeIngredients]];
        
        CGFloat height = 145 + ([temp fittedSize].height + 6 < 35 ? 35 : [temp fittedSize].height + 6);
        
        return height;
    }
    
    return 180;
}

- (void)updateObjectAtIndex:(NSInteger)index
{
    KIAUser *user = [_users objectAtIndex:index];
    
    KIAMealSettingsTableViewCell *cell = (KIAMealSettingsTableViewCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [user setName:[[cell nameField] text]];
    
    [[KIAUpdater sharedUpdater] updateUsersInfo:user];
    
    [_table reloadData];
}

- (void)removeObjectAtIndex:(NSInteger)index
{
    [[KIAUpdater sharedUpdater] removeUser:[_users objectAtIndex:index]];
    
    [_users removeObjectAtIndex:index];
    
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

- (void)updateTableForIndex:(NSInteger)index dislike:(NSArray *)dislike
{
    KIAUser *temp = [_users objectAtIndex:index];
    [temp setDislikeIngredients:[dislike mutableCopy]];
    
    [[KIAUpdater sharedUpdater] updateUsersInfo:temp];
    
    [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark *****

- (IBAction)addUserAction:(id)sender
{
    if (![[[_users objectAtIndex:[_users count] - 1] name] isEqualToString:@""])
    {
        [[KIAUpdater sharedUpdater] addUserWithId:[_users count] name:@"" state:@NO];
    
        _users = [[[KIAUpdater sharedUpdater] getAllUsers] mutableCopy];
    
        [_table reloadData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Please complete previous user info to continue..."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
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
    
    if ([[segue identifier] isEqualToString:@"dislikeIngredients"])
    {
        KIAFindIngrediensViewController *viewController = (KIAFindIngrediensViewController *)[segue destinationViewController];
        [viewController setUser:[_users objectAtIndex:_index]];
    }
}

@end
