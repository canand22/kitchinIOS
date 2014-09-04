//
//  KIASelectItemViewController.m
//  KitchInApp
//
//  Created by DeMoN on 3/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASelectItemViewController.h"

#import "KIAEditRecognizeItemsViewController.h"
#import "KIATabBarViewController.h"

#import "KIASendCheckMapping.h"
#import "KIAItem.h"
#import "KIAUpdater.h"

@interface KIASelectItemViewController ()

@end

@implementation KIASelectItemViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self reloadDataFromTable];
}

- (void)reloadDataFromTable
{
    _categoryItems = [[KIAUpdater sharedUpdater] itemsForCategoryName:_categoryName];
    
    [_table reloadData];
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
    return [_categoryItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    KIAItem *temp = [_categoryItems objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[temp name]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *editVC = [[self presentingViewController] presentingViewController];
    
    if ([editVC isKindOfClass:[KIAEditRecognizeItemsViewController class]])
    {
        for (int i = 0; i < [[(KIAEditRecognizeItemsViewController *)editVC itemArray] count]; i++)
        {
            if (![(KIASendCheckMapping *)[[(KIAEditRecognizeItemsViewController *)editVC itemArray] objectAtIndex:i] IsSuccessMatching])
            {
                KIAItem *temp = [_categoryItems objectAtIndex:[indexPath row]];
            
                [(KIASendCheckMapping *)[[(KIAEditRecognizeItemsViewController *)editVC itemArray] objectAtIndex:i] setId:[temp idItem].integerValue];
                [(KIASendCheckMapping *)[[(KIAEditRecognizeItemsViewController *)editVC itemArray] objectAtIndex:i] setItemName:[temp name]];
                [(KIASendCheckMapping *)[[(KIAEditRecognizeItemsViewController *)editVC itemArray] objectAtIndex:i] setCategory:_categoryName];
                [(KIASendCheckMapping *)[[(KIAEditRecognizeItemsViewController *)editVC itemArray] objectAtIndex:i] setItemShortName:[temp reduction]];
                [(KIASendCheckMapping *)[[(KIAEditRecognizeItemsViewController *)editVC itemArray] objectAtIndex:i] setIsSuccessMatching:YES];
            
                break;
            }
        }
    
        [editVC dismissViewControllerAnimated:YES completion:nil];
    }
    
    if ([editVC isKindOfClass:[KIATabBarViewController class]])
    {
        NSLog(@"aeglkiowrg");
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
