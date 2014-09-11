//
//  KIAMissingIngredientsViewController.m
//  KitchInApp
//
//  Created by DeMoN on 9/11/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAMissingIngredientsViewController.h"

#import "KIAUpdater.h"

#define CHECK_BUTTON_ACTIVE @"ceckbox_active.png"
#define CHECK_BUTTON_DEACTIVE @"ceckbox.png"

@interface KIAMissingIngredientsViewController ()

@end

@implementation KIAMissingIngredientsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _addArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _ingredientsMissingInMyKitchIn = [[NSMutableArray alloc] initWithArray:_receptIngredient];
    
    for (int i = 0; i < [_receptIngredient count]; i++)
    {
        if ([[KIAUpdater sharedUpdater] whetherThereIsAnIngredient:[[_receptIngredient objectAtIndex:i] objectForKey:@"name"]])
        {
            [_ingredientsMissingInMyKitchIn removeObject:[_receptIngredient objectAtIndex:i]];
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
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ingredientsMissingInMyKitchIn count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [_ingredientsMissingInMyKitchIn count])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        [[cell textLabel] setText:[[_ingredientsMissingInMyKitchIn objectAtIndex:[indexPath row]] objectForKey:@"ingredient"]];
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [_receptIngredient count])
    {
        if ([_addArray containsObject:[[_ingredientsMissingInMyKitchIn objectAtIndex:[indexPath row]] objectForKey:@"name"]])
        {
            [_addArray removeObject:[[_ingredientsMissingInMyKitchIn objectAtIndex:[indexPath row]] objectForKey:@"name"]];
            
            [[[tableView cellForRowAtIndexPath:indexPath] imageView] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE]];
        }
        else
        {
            [_addArray addObject:[[_ingredientsMissingInMyKitchIn objectAtIndex:[indexPath row]] objectForKey:@"name"]];
            
            [[[tableView cellForRowAtIndexPath:indexPath] imageView] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE]];
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
