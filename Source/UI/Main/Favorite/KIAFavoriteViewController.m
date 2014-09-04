//
//  KIAFavoriteViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/8/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAFavoriteViewController.h"
#import "KIAFavorite.h"
#import "KIAUpdater.h"

#import "KIASearchRecipiesTableViewCell.h"

#import "KIAViewRecipiesViewController.h"

@interface KIAFavoriteViewController ()

@end

@implementation KIAFavoriteViewController

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
    _favoriteRecipe = [[[KIAUpdater sharedUpdater] getAllFav] mutableCopy];
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
    return [_favoriteRecipe count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIASearchRecipiesTableViewCell *cell = (KIASearchRecipiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    KIAFavorite *fav = [_favoriteRecipe objectAtIndex:[indexPath row]];
    [[cell title] setText:[fav recipeName]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSURL *url = [NSURL URLWithString:[fav picture]];
        NSData *temp = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [[cell image] setImage:[UIImage imageWithData:temp]];
        });
    });
    
    [[cell stars] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-star.png", [fav rating].integerValue]]];
    
    [[cell kalories] setText:[NSString stringWithFormat:@"Number served: %d", [fav served].integerValue]];
    [[cell time] setText:[NSString stringWithFormat:@"Total time: %@", ([fav time].integerValue > 0 ? ([fav time].integerValue / 3600 > 0 ? [NSString stringWithFormat:@"%d hr %d min", [fav time].integerValue / 3600, [fav time].integerValue / 60] : [NSString stringWithFormat:@"%d min", [fav time].integerValue / 60]) : @"N/A")]];
    
    return cell;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[KIAUpdater sharedUpdater] removeItem:[_favoriteRecipe objectAtIndex:[indexPath row]]];
        
        [_favoriteRecipe removeObjectAtIndex:[indexPath row]];
        
        [_table reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedItem = [indexPath row];
    
    [self performSegueWithIdentifier:@"viewRecipeIdentifier" sender:self];
}

#pragma mark *****

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"viewRecipeIdentifier"])
    {
        KIAViewRecipiesViewController *viewController = (KIAViewRecipiesViewController *)[segue destinationViewController];
        [viewController setRecipiesIdentification:[[_favoriteRecipe objectAtIndex:_selectedItem] recipeId]];
    }
}

@end
