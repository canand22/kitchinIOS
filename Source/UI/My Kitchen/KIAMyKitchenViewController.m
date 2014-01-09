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
        _categoriesArray = [NSArray arrayWithObjects:@"Fruits", @"Grains", @"Dairy", @"Meat", @"Veggie", @"Poultry", @"Pasta", @"Snacks", @"Drinks", @"Fish", @"Frozen Foods", @"Other", @"Sweets", @"Spice Cabinet", @"Groseries", @"Preserved Food", nil];
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
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollCell";
    
    MyKitchInCell *cell = (MyKitchInCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [[cell image] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [_categoriesArray objectAtIndex:[indexPath row]]]]];
    
    [[cell title] setText:[_categoriesArray objectAtIndex:[indexPath row]]];
    
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
