//
//  KIASearchRecipiesViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASearchRecipiesViewController.h"

#import "KIAServerGateway.h"
#import "KIARecipiesMapping.h"

#import "KIASearchRecipiesCollectionVeiwCell.h"
#import "KIASearchRecipiesTableViewCell.h"

#import "KIAViewRecipiesViewController.h"

#import "KIACacheManager.h"
#import "KIAUpdater.h"
#import "KIAFilterSettings.h"
#import "KIASearchDefines.h"

#define BUTTON_ACTIVE   @"button_filter_active.png"
#define BUTTON_INACTIVE @"button_filter.png"

@interface KIASearchRecipiesViewController ()

@end

@implementation KIASearchRecipiesViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _searchGateway = [KIAServerGateway gateway];
        
        _sortOptions = @[@"Missing ingredients", @"Rating"];
        _countRecipiesArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSMutableArray *tempAllergy = [[KIAFilterSettings sharedFilterManager] allergy];
    NSMutableArray *tempDiet = [[KIAFilterSettings sharedFilterManager] diet];
    
    [tempAllergy addObjectsFromArray:[[_itemForQuery objectForKey:ALLERGIES] componentsSeparatedByString:@","]];
    [tempDiet addObjectsFromArray:[[_itemForQuery objectForKey:DIETS] componentsSeparatedByString:@","]];
    
    [[KIAFilterSettings sharedFilterManager] setAllergy:[[[NSSet setWithArray:tempAllergy] allObjects] mutableCopy]];
    [[KIAFilterSettings sharedFilterManager] setDiet:[[[NSSet setWithArray:tempDiet] allObjects] mutableCopy]];
    
    if (![[_itemForQuery objectForKey:DISH_TYPE] isEqualToString:@""])
    {
        [[KIAFilterSettings sharedFilterManager] setDishType:[_itemForQuery objectForKey:DISH_TYPE]];
    }
    
    if (![[_itemForQuery objectForKey:MEAL] isEqualToString:@""])
    {
        [[KIAFilterSettings sharedFilterManager] setMeal:[_itemForQuery objectForKey:MEAL]];
    }
    
    [[KIAFilterSettings sharedFilterManager] saveSettings];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // ALLERGIES, DIETS, CUISINE, DISH_TYPE, HOLIDAY, MEAL, TIME
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[_itemForQuery objectForKey:COOK_WITH]];
    [items addObject:[_itemForQuery objectForKey:COOK_WITHOUT]];
    [items addObject:[[KIAFilterSettings sharedFilterManager] allergy]];
    [items addObject:[[KIAFilterSettings sharedFilterManager] diet]];
    [items addObject:[[KIAFilterSettings sharedFilterManager] cuisine]];
    [items addObject:[[KIAFilterSettings sharedFilterManager] dishType]];
    [items addObject:[[KIAFilterSettings sharedFilterManager] holiday]];
    [items addObject:[[KIAFilterSettings sharedFilterManager] meal]];
    [items addObject:[[KIAFilterSettings sharedFilterManager] time]];
    NSArray *keys = [NSArray arrayWithObjects:COOK_WITH, COOK_WITHOUT, ALLERGIES, DIETS, CUISINE, DISH_TYPE, HOLIDAY, MEAL, TIME, nil];
    
    _itemForQuery = [NSDictionary dictionaryWithObjects:items forKeys:keys];
    
    [_searchGateway sendSearchRecipiesForItem:_itemForQuery delegate:self];
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

- (void)showData:(NSArray *)itemArray
{
    _recipiesArray = itemArray;
    
    for (int i = 0; i < [_recipiesArray count]; i++)
    {
        [_countRecipiesArray addObject:[NSNumber numberWithInteger:[[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[[_recipiesArray objectAtIndex:i] Ingredients]]]];
    }
    
    [self sortForMissingIngredients];
    
    [_collection reloadData];
    [_table reloadData];
}

- (IBAction)showCollectionView:(id)sender
{
    [_collectionView setHidden:NO];
    [_tableView setHidden:YES];
    
    [_showCollection setBackgroundImage:[UIImage imageNamed:BUTTON_ACTIVE] forState:UIControlStateNormal];
    [_showCollection setBackgroundImage:[UIImage imageNamed:BUTTON_ACTIVE] forState:UIControlStateHighlighted];
    [_showTable setBackgroundImage:[UIImage imageNamed:BUTTON_INACTIVE] forState:UIControlStateNormal];
    [_showTable setBackgroundImage:[UIImage imageNamed:BUTTON_INACTIVE] forState:UIControlStateHighlighted];
}

- (IBAction)showTableView:(id)sender
{
    [_collectionView setHidden:YES];
    [_tableView setHidden:NO];
    
    [_showCollection setBackgroundImage:[UIImage imageNamed:BUTTON_INACTIVE] forState:UIControlStateNormal];
    [_showCollection setBackgroundImage:[UIImage imageNamed:BUTTON_INACTIVE] forState:UIControlStateHighlighted];
    [_showTable setBackgroundImage:[UIImage imageNamed:BUTTON_ACTIVE] forState:UIControlStateNormal];
    [_showTable setBackgroundImage:[UIImage imageNamed:BUTTON_ACTIVE] forState:UIControlStateHighlighted];
}

- (IBAction)sortOptionsAction:(id)sender
{
    [_pickerSort setHidden:![_pickerSort isHidden]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFonSort setHidden:![_pickerFonSort isHidden]];
        [_pickerIndicatorSort setHidden:![_pickerIndicatorSort isHidden]];
    }
}

#pragma mark ***** sort metod *****

- (void)sortForMissingIngredients
{
    _recipiesArray = [_recipiesArray sortedArrayUsingComparator:^NSComparisonResult (id obj1, id obj2)
    {
        NSInteger firstObj = [[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[obj1 Ingredients]];
        NSInteger secondObj = [[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[obj2 Ingredients]];
                          
        if (firstObj < secondObj)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else if (firstObj > secondObj)
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    [_collection reloadData];
    [_table reloadData];
}

- (void)sortForRating
{
    _recipiesArray = [_recipiesArray sortedArrayUsingComparator:^NSComparisonResult (id obj1, id obj2)
    {
        NSInteger firstObj = [obj1 Rating];
        NSInteger secondObj = [obj2 Rating];
        
        if (firstObj > secondObj)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else if (firstObj < secondObj)
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    [_collection reloadData];
    [_table reloadData];
}

#pragma mark ***** picker controller *****

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_sortOptions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_sortOptions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_sortButton setTitle:[_sortOptions objectAtIndex:row] forState:UIControlStateNormal];
            
    [_pickerSort setHidden:![_pickerSort isHidden]];
            
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFonSort setHidden:![_pickerFonSort isHidden]];
        [_pickerIndicatorSort setHidden:![_pickerIndicatorSort isHidden]];
    }
    
    switch (row)
    {
        case 0:
            [self sortForMissingIngredients];
            break;
        case 1:
            [self sortForRating];
            break;
        default:
            [self sortForMissingIngredients];
            break;
    }
}

#pragma mark ***** collection view *****

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_recipiesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KIASearchRecipiesCollectionVeiwCell *cell = (KIASearchRecipiesCollectionVeiwCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    KIARecipiesMapping *item = [_recipiesArray objectAtIndex:[indexPath row]];
    NSURL *url = [NSURL URLWithString:[[item PhotoUrl] objectAtIndex:0]];
    
    if ([[KIACacheManager sharedCacheManager] checkImageForCacheWithIdentifier:[item ResipiesID]])
    {
        [[cell image] setImage:[[KIACacheManager sharedCacheManager] fetchCacheImageForIdentifier:[item ResipiesID]]];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
        {
            NSData *temp = [NSData dataWithContentsOfURL:url];
        
            [[KIACacheManager sharedCacheManager] saveCacheImage:[UIImage imageWithData:temp] forIdentifier:[item ResipiesID]];
        
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [[cell image] setImage:[UIImage imageWithData:temp]];
            });
        });
    }
        
    [[cell title] setText:[item Title]];
    
    [[cell countIngridient] setText:[NSString stringWithFormat:@"Missing Ingredients: %d", [[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[item Ingredients]]]];
    [[cell kalories] setText:[NSString stringWithFormat:@"Rating:"]];
    [[cell stars] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-star.png", [item Rating]]]];
    [[cell time] setText:[NSString stringWithFormat:@"Cook Time: %@", ([item TotalTime] > 0 ? ([item TotalTime] / 3600 > 0 ? [NSString stringWithFormat:@"%d hr %d min", [item TotalTime] / 3600, [item TotalTime] / 60] : [NSString stringWithFormat:@"%d min", [item TotalTime] / 60]) : @"N/A")]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedItem = [indexPath row];
    
    [self performSegueWithIdentifier:@"viewRecipeIdentifier" sender:self];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_recipiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIASearchRecipiesTableViewCell *cell = (KIASearchRecipiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    KIARecipiesMapping *item = [_recipiesArray objectAtIndex:[indexPath row]];
    NSURL *url = [NSURL URLWithString:[[item PhotoUrl] objectAtIndex:0]];
    
    if ([[KIACacheManager sharedCacheManager] checkImageForCacheWithIdentifier:[item ResipiesID]])
    {
        [[cell image] setImage:[[KIACacheManager sharedCacheManager] fetchCacheImageForIdentifier:[item ResipiesID]]];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
        {
            NSData *temp = [NSData dataWithContentsOfURL:url];
                           
            [[KIACacheManager sharedCacheManager] saveCacheImage:[UIImage imageWithData:temp] forIdentifier:[item ResipiesID]];
                           
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [[cell image] setImage:[UIImage imageWithData:temp]];
            });
        });
    }
    
    [[cell title] setText:[item Title]];
    
    [[cell countIngridient] setText:[NSString stringWithFormat:@"Missing Ingredients: %d", [[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[item Ingredients]]]];
    [[cell kalories] setText:[NSString stringWithFormat:@"Rating:"]];
    [[cell stars] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-star.png", [item Rating]]]];
    [[cell time] setText:[NSString stringWithFormat:@"Cook Time: %@", ([item TotalTime] > 0 ? ([item TotalTime] / 3600 > 0 ? [NSString stringWithFormat:@"%d hr %d min", [item TotalTime] / 3600, [item TotalTime] / 60] : [NSString stringWithFormat:@"%d min", [item TotalTime] / 60]) : @"N/A")]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedItem = [indexPath row];
    
    [self performSegueWithIdentifier:@"viewRecipeIdentifier" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"viewRecipeIdentifier"])
    {
        KIAViewRecipiesViewController *viewController = (KIAViewRecipiesViewController *)[segue destinationViewController];
        [viewController setRecipiesIdentification:[[_recipiesArray objectAtIndex:_selectedItem] ResipiesID]];
        [viewController setIngredientsArray:[[_recipiesArray objectAtIndex:_selectedItem] Ingredients]];
    }
}

@end
