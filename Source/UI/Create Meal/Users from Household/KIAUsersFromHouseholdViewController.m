//
//  KIAUsersFromHouseholdViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/5/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAUsersFromHouseholdViewController.h"

#import "KIAUpdater.h"
#import "KIAUser.h"

#import "KIAUsersFromHouseholdAddTableViewCell.h"

#define CHECK_BUTTON_ACTIVE @"ceckbox_active.png"
#define CHECK_BUTTON_DEACTIVE @"ceckbox.png"

@interface KIAUsersFromHouseholdViewController ()

@end

@implementation KIAUsersFromHouseholdViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _users = [[[KIAUpdater sharedUpdater] getAllUsers] mutableCopy];
        
        for (int i = (int)[_users count] - 1; i > -1; i--)
        {
            KIAUser *item = [_users objectAtIndex:i];
            
            if ([[item isActiveState] isEqual:@YES] || [[item name] isEqualToString:@""])
            {
                [_users removeObject:item];
            }
        }
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
    
    if (_usersCheck == nil)
    {
        _usersCheck = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [_users count]; i++)
        {
            if ([_currentUsers containsObject:[_users objectAtIndex:i]])
            {
                [_usersCheck addObject:@YES];
            }
            else
            {
                [_usersCheck addObject:@NO];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_users count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([indexPath row] < [_users count])
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        [[cell textLabel] setText:[[_users objectAtIndex:[indexPath row]] name]];
        
        if ([(NSNumber *)[_usersCheck objectAtIndex:[indexPath row]] boolValue])
        {
            [[cell imageView] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE]];
        }
        else
        {
            [[cell imageView] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE]];
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
        [(KIAUsersFromHouseholdAddTableViewCell *)cell setDelegate:self];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [_users count])
    {
        if ([(NSNumber *)[_usersCheck objectAtIndex:[indexPath row]] boolValue])
        {
            [_usersCheck replaceObjectAtIndex:[indexPath row] withObject:@NO];
        }
        else
        {
            [_usersCheck replaceObjectAtIndex:[indexPath row] withObject:@YES];
        }
        
        [tableView reloadData];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)addAction
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_usersCheck count]; i++)
    {
        if ([[_usersCheck objectAtIndex:i] isEqualToNumber:@YES])
        {
            [temp addObject:[[_users objectAtIndex:i] name]];
            
            KIAUser *user = [_users objectAtIndex:i];
            [user setIsActiveState:@YES];
            [[KIAUpdater sharedUpdater] updateUsersInfo:user];
        }
    }
    
    if ([temp count] > 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    
        [_delegate usersForCooking:temp];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please, select at least one user from Household to add."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}

#pragma mark *****

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
