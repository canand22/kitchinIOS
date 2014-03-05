// ************************************************ //
//                                                  //
//  KIACategoryContentViewController.m              //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIACategoryContentViewController.h"

#import "CategoryItemCell.h"

#import "KIAUpdater.h"
#import "KIAItem.h"

#import "KIAAddItemViewController.h"

#define CELL_TAG 100

@interface KIACategoryContentViewController ()

@end

@implementation KIACategoryContentViewController

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
    [_categoryTitle setText:_categoryName];
    [_categoryImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_category.png", _categoryName]]];
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
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark ***** table view *****

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
    CategoryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    KIAItem *temp = [_categoryItems objectAtIndex:[indexPath row]];
    
    [[cell itemName] setText:[temp name]];
    
    [cell setDelegate:self];
    [[cell removeButton] setTag:[indexPath row] + CELL_TAG];
    
    return cell;
}

- (void)deleteItemFromIndex:(NSInteger)index
{
    [[KIAUpdater sharedUpdater] removeItem:[_categoryItems objectAtIndex:index - CELL_TAG]];
    
    [self reloadDataFromTable];
    
    [_table reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"1000"])
    {
        KIAAddItemViewController *categoryContent = (KIAAddItemViewController *)[segue destinationViewController];
        
        [categoryContent setCategoryName:_categoryName];
        [categoryContent setIsRecognition:NO];
    }
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
