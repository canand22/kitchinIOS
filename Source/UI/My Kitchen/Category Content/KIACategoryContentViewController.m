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
    
    _categoryItems = [[KIAUpdater sharedUpdater] itemsForCategoryName:_categoryName];
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
    
    return cell;
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
