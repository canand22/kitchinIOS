//
//  KIARemoveIngredientsViewController.m
//  KitchInApp
//
//  Created by DeMoN on 9/4/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIARemoveIngredientsViewController.h"

#import "KIAButtonTableViewCell.h"

#import "KIATabBarViewController.h"

#import "KIAUpdater.h"

#define CHECK_BUTTON_ACTIVE @"ceckbox_active.png"
#define CHECK_BUTTON_DEACTIVE @"ceckbox.png"

@interface KIARemoveIngredientsViewController ()

@end

@implementation KIARemoveIngredientsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _removeArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _ingredientsInMyKitchIn = [[NSMutableArray alloc] initWithArray:_receptIngredient];
    
    for (int i = 0; i < [_receptIngredient count]; i++)
    {
        if (![[KIAUpdater sharedUpdater] whetherThereIsAnIngredient:[[_receptIngredient objectAtIndex:i] objectForKey:@"name"]])
        {
            [_ingredientsInMyKitchIn removeObject:[_receptIngredient objectAtIndex:i]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skipAction:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Selected ingredients will be kept in your Kitchin."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
    
    KIATabBarViewController *tabBarVC = (KIATabBarViewController *)[self tabBarController];
    
    [tabBarVC setSelectedIndex:1];
    [[[tabBarVC viewControllers] objectAtIndex:1] popToRootViewControllerAnimated:NO];
    
    [tabBarVC reloadButtonImageWithIndex:2];
}

- (void)removeIngredients
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Selected ingredients have been removed from your Kitchin."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
    
    for (int j = 0; j < [_removeArray count]; j++)
    {
        for (int i = 0; i < [_ingredientsInMyKitchIn count]; i++)
        {
            if ([[[_ingredientsInMyKitchIn objectAtIndex:i] objectForKey:@"name"] isEqualToString:[_removeArray objectAtIndex:j]])
            {
                [_ingredientsInMyKitchIn removeObjectAtIndex:i];
            }
        }
    }
    
    [[KIAUpdater sharedUpdater] removeItemWithNames:_removeArray];
    
    if ([_ingredientsInMyKitchIn count])
    {
        [_table reloadData];
    }
    else
    {
        KIATabBarViewController *tabBarVC = (KIATabBarViewController *)[self tabBarController];
        
        [tabBarVC setSelectedIndex:1];
        [[[tabBarVC viewControllers] objectAtIndex:1] popToRootViewControllerAnimated:NO];
        
        [tabBarVC reloadButtonImageWithIndex:2];
    }
}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ingredientsInMyKitchIn count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [_ingredientsInMyKitchIn count])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        [[cell textLabel] setText:[[_ingredientsInMyKitchIn objectAtIndex:[indexPath row]] objectForKey:@"ingredient"]];
        
        return cell;
    }
    else
    {
        KIAButtonTableViewCell *cell = (KIAButtonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
        
        [cell setDelegate:self];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [_ingredientsInMyKitchIn count])
    {
        [_skip setHidden:YES];
        
        if ([_removeArray containsObject:[[_ingredientsInMyKitchIn objectAtIndex:[indexPath row]] objectForKey:@"name"]])
        {
            [_removeArray removeObject:[[_ingredientsInMyKitchIn objectAtIndex:[indexPath row]] objectForKey:@"name"]];
        
            [[[tableView cellForRowAtIndexPath:indexPath] imageView] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE]];
        
            if ([_removeArray count] == 0)
            {
                [[(KIAButtonTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[_ingredientsInMyKitchIn count] inSection:0]] removeBtn] setEnabled:NO];
            }
        }
        else
        {
            [_removeArray addObject:[[_ingredientsInMyKitchIn objectAtIndex:[indexPath row]] objectForKey:@"name"]];
        
            [[[tableView cellForRowAtIndexPath:indexPath] imageView] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE]];
        
            [[(KIAButtonTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[_ingredientsInMyKitchIn count] inSection:0]] removeBtn] setEnabled:YES];
        }
    }
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
