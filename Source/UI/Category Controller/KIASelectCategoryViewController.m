//
//  KIASelectCategoryViewController.m
//  KitchInApp
//
//  Created by DeMoN on 2/19/13.
//  Copyright (c) 2013 DeMoN. All rights reserved.
//

#import "KIASelectCategoryViewController.h"

#import "KIAAddItemViewController.h"
#import "KIASelectItemViewController.h"
#import "KIASelectItemsViewController.h"

#import "MyKitchInCell.h"

#import "KIAUpdater.h"

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
        _categoriesArray = @[@"Dairy", @"Produce", @"Poultry", @"Meats & Deli", @"Seafood", @"Breads & Bakery", @"Pasta", @"Cereal & Grains", @"Drinks", @"Dry Prepared Foods", @"Canned Foods, Soups, Broths", @"Frozen", @"Snacks", @"Sweets", @"Baking", @"Condiments, Sauces, Oils", @"Spices & Herbs", @"Other"];
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
    
    NSArray *temp = [[KIAUpdater sharedUpdater] itemsForCategoryName:[_categoriesArray objectAtIndex:[indexPath row]]];
    
    if ([temp count] > 0)
    {
        [[cell circle] setHidden:NO];
        [[cell circleText] setText:[NSString stringWithFormat:@"%lu", (unsigned long)[temp count]]];
        [[cell circleText] setHidden:NO];
    }
    else
    {
        [[cell circle] setHidden:YES];
        [[cell circleText] setHidden:YES];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_mode == addNewItem)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIAAddItemViewController *addItemsViewController = (KIAAddItemViewController *)[storyboard instantiateViewControllerWithIdentifier:@"addItemViewController"];
        [addItemsViewController setCategoryName:[_categoriesArray objectAtIndex:[indexPath row]]];
        [addItemsViewController setIsRecognition:YES];
        [self presentViewController:addItemsViewController animated:YES completion:nil];
    }
    
    if (_mode == addKitchInItem)
    {
        _categoryName = [_categoriesArray objectAtIndex:[indexPath row]];
        
        [self performSegueWithIdentifier:@"SelectItemVC" sender:self];
    }
    
    if (_mode == selectItems)
    {
        _categoryName = [_categoriesArray objectAtIndex:[indexPath row]];
        
        [self performSegueWithIdentifier:@"SelectItemsVC" sender:self];
    }
}

- (void)itemChecked:(NSArray *)items
{
    [_selectedItems addObjectsFromArray:items];
    
    _selectedItems = [[[NSSet setWithArray:_selectedItems] allObjects] mutableCopy];
}

- (IBAction)back:(id)sender
{
    if (_mode == selectItems)
    {
        // TODO:
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SelectItemVC"])
    {
        KIASelectItemViewController *categoryContent = (KIASelectItemViewController *)[segue destinationViewController];
        
        [categoryContent setCategoryName:_categoryName];
    }
    
    if ([[segue identifier] isEqualToString:@"SelectItemsVC"])
    {
        KIASelectItemsViewController *categoryContent = (KIASelectItemsViewController *)[segue destinationViewController];
        
        [categoryContent setCategoryName:_categoryName];
        [categoryContent setDelegate:self];
    }
}

@end
