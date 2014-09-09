//
//  KIAFindIngrediensViewController.m
//  KitchInApp
//
//  Created by DeMoN on 9/8/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAFindIngrediensViewController.h"

#import "KIAServerGateway.h"
#import "KIAUpdater.h"
#import "KIAYamlyMapping.h"

@interface KIAFindIngrediensViewController ()

@end

@implementation KIAFindIngrediensViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _yummlyGateway = [KIAServerGateway gateway];
        
        _ingredientSearch = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showData:(NSArray *)itemArray
{
    [_ingredientSearch removeAllObjects];
    NSMutableSet *names = [NSMutableSet set];
    
    for (id obj in itemArray)
    {
        NSString *yummlyName = [obj yummlyName];
        
        if (![names containsObject:yummlyName])
        {
            [_ingredientSearch addObject:obj];
            [names addObject:yummlyName];
        }
    }
    
    [_table reloadData];
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
    return [_ingredientSearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [[cell textLabel] setText:[[_ingredientSearch objectAtIndex:[indexPath row]] yummlyName]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![_ingredients containsObject:[[_ingredientSearch objectAtIndex:[indexPath row]] yummlyName]])
    {
        [_ingredients addObject:[[_ingredientSearch objectAtIndex:[indexPath row]] yummlyName]];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ***** search controller *****

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [_yummlyGateway searchWithString:[[searchBar text] stringByAppendingString:text] delegate:self];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_yummlyGateway searchWithString:[searchBar text] delegate:self];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
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
