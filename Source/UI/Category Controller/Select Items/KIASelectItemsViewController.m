//
//  KIASelectItemsViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/18/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASelectItemsViewController.h"

#import "KIAItem.h"
#import "KIAUpdater.h"

#import "KIAUsersFromHouseholdAddTableViewCell.h"

#define CHECK_BUTTON_ACTIVE @"ceckbox_active.png"
#define CHECK_BUTTON_DEACTIVE @"ceckbox.png"

@interface KIASelectItemsViewController ()

@end

@implementation KIASelectItemsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self reloadDataFromTable];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_categoryItemsCheck == nil)
    {
        _categoryItemsCheck = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [_categoryItems count]; i++)
        {
            [_categoryItemsCheck addObject:@NO];
        }
    }
}

- (void)reloadDataFromTable
{
    _categoryItems = [[KIAUpdater sharedUpdater] itemsForCategoryName:_categoryName];
    
    if ([_categoryItems count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Sorry there are no ingredients in this category"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        [_table reloadData];
    }
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_categoryItems count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([indexPath row] < [_categoryItems count])
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        KIAItem *temp = [_categoryItems objectAtIndex:[indexPath row]];
        
        [[cell textLabel] setText:[temp yummlyName]];
    
        if ([(NSNumber *)[_categoryItemsCheck objectAtIndex:[indexPath row]] boolValue])
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
    if ([indexPath row] < [_categoryItems count])
    {
        if ([(NSNumber *)[_categoryItemsCheck objectAtIndex:[indexPath row]] boolValue])
        {
            [_categoryItemsCheck replaceObjectAtIndex:[indexPath row] withObject:@NO];
        }
        else
        {
            [_categoryItemsCheck replaceObjectAtIndex:[indexPath row] withObject:@YES];
        }
        
        [tableView reloadData];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)addAction
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_categoryItemsCheck count]; i++)
    {
        if ([[_categoryItemsCheck objectAtIndex:i] isEqualToNumber:@YES])
        {
            [temp addObject:[[_categoryItems objectAtIndex:i] yummlyName]];
        }
    }
    
    if ([temp count] > 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    
        [_delegate itemChecked:temp];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please, select at least one ingredient from your Kitchin."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
