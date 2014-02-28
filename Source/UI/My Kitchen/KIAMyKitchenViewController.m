// ************************************************ //
//                                                  //
//  KIAMyKitchenViewController.m                    //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/23/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIAMyKitchenViewController.h"

#import "KIACategoryContentViewController.h"
#import "KIAUpdater.h"

#import "MyKitchInCell.h"

@interface KIAMyKitchenViewController ()

@end

@implementation KIAMyKitchenViewController

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
    CGRect frame = [_collectionView frame];
    frame.size.height = [[self view] frame].size.height - frame.origin.x - 120;
    [_collectionView setFrame:frame];
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
    
    //NSArray *temp = [[KIAUpdater sharedUpdater] itemsForCategoryName:[_categoriesArray objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"1000"])
    {
        KIACategoryContentViewController *categoryContent = (KIACategoryContentViewController *)[segue destinationViewController];
        
        [categoryContent setCategoryName:[(UILabel *)[sender title] text]];
    }
}

@end
