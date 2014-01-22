//
//  KIASelectCategoryViewController.m
//  KitchInApp
//
//  Created by DeMoN on 2/19/13.
//  Copyright (c) 2013 DeMoN. All rights reserved.
//

#import "KIASelectCategoryViewController.h"

#import "KIAAddItemViewController.h"

#import "MyKitchInCell.h"

@interface KIASelectCategoryViewController ()

@end

@implementation KIASelectCategoryViewController

@synthesize mode = _mode;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _categoriesArray = [NSArray arrayWithObjects:@"Dairy", @"Produce", @"Poultry", @"Meats & Deli", @"Seafood", @"Breads & Bakery", @"Pasta", @"Cereal & Grains", @"Drinks", @"Dry Prepared Foods", @"Canned Foods, Soups, Broths", @"Frozen", @"Snacks", @"Sweets", @"Baking", @"Condiments, Sauces, Oils", @"Spices & Herbs", @"Other", nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_categoriesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollCell";
    
    MyKitchInCell *cell = (MyKitchInCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [[cell image] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [_categoriesArray objectAtIndex:[indexPath row]]]]];
    
    [[cell title] setText:[_categoriesArray objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_mode == addNewItem)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIAAddItemViewController *addItemsViewController = (KIAAddItemViewController *)[storyboard instantiateViewControllerWithIdentifier:@"addItemViewController"];
        [self presentViewController:addItemsViewController animated:YES completion:nil];
    }
    
    if (_mode == addKitchInItem)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIAAddItemViewController *addItemsViewController = (KIAAddItemViewController *)[storyboard instantiateViewControllerWithIdentifier:@"addItemViewController"];
        [self presentViewController:addItemsViewController animated:YES completion:nil];
    }
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
