//
//  KIASearchRecipiesViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASearchRecipiesViewController.h"

#import "KIAServerGateway.h"
#import "KIASearchRecipiesMapping.h"

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
        
        _recipiesArray = [[NSMutableArray alloc] init];
        
        countRecept = 0;
        currentCountRecept = 1;
        
        isLoadContent = NO;
        isFilterSettings = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSMutableArray *tempAllergy = [[KIAFilterSettings sharedFilterManager] allergy];
    NSMutableArray *tempDiet = [[KIAFilterSettings sharedFilterManager] diet];
    
    if (![[_itemForQuery objectForKey:ALLERGIES] isEqualToString:@""])
    {
        [tempAllergy addObjectsFromArray:[[_itemForQuery objectForKey:ALLERGIES] componentsSeparatedByString:@","]];
    }
    
    if (![[_itemForQuery objectForKey:DIETS] isEqualToString:@""])
    {
        [tempDiet addObjectsFromArray:[[_itemForQuery objectForKey:DIETS] componentsSeparatedByString:@","]];
    }
    
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
    
    [self showTableView:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (isFilterSettings)
    {
        // ALLERGIES, DIETS, CUISINE, DISH_TYPE, HOLIDAY, MEAL, TIME
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:[_itemForQuery objectForKey:COOK_WITH]];
        [items addObject:[_itemForQuery objectForKey:COOK_WITHOUT]];
        [items addObject:[[[KIAFilterSettings sharedFilterManager] allergy] componentsJoinedByString:@","]];
        [items addObject:[[[KIAFilterSettings sharedFilterManager] diet] componentsJoinedByString:@","]];
        [items addObject:[[[KIAFilterSettings sharedFilterManager] cuisine] componentsJoinedByString:@","]];
        [items addObject:[[KIAFilterSettings sharedFilterManager] dishType]];
        [items addObject:[[[KIAFilterSettings sharedFilterManager] holiday] componentsJoinedByString:@","]];
        [items addObject:[[KIAFilterSettings sharedFilterManager] meal]];
        [items addObject:[[KIAFilterSettings sharedFilterManager] time]];
        NSArray *keys = [NSArray arrayWithObjects:COOK_WITH, COOK_WITHOUT, ALLERGIES, DIETS, CUISINE, DISH_TYPE, HOLIDAY, MEAL, TIME, nil];
    
        _itemForQuery = [NSDictionary dictionaryWithObjects:items forKeys:keys];
    
        isLoadContent = YES;
    
        [_recipiesArray removeAllObjects];
    
        [_searchGateway sendSearchRecipiesForItem:_itemForQuery page:currentCountRecept delegate:self];
    }
    
    isFilterSettings = NO;
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

- (void)showDic:(NSDictionary *)itemDic;
{
    [_recipiesArray addObjectsFromArray:[(KIASearchRecipiesMapping *)itemDic Recipes]];
    
    countRecept = [(KIASearchRecipiesMapping *)itemDic TotalCount];
    
    for (int i = 0; i < [_recipiesArray count]; i++)
    {
        [_countRecipiesArray addObject:[NSNumber numberWithInteger:[[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[[_recipiesArray objectAtIndex:i] objectForKey:@"Ingredients"]]]];
    }
    
    [self sortForMissingIngredients];
    
    isLoadContent = NO;
    
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
    [_recipiesArray sortUsingComparator:^NSComparisonResult (id obj1, id obj2)
    {
        NSInteger firstObj = [[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[obj1 objectForKey:@"Ingredients"]];
        NSInteger secondObj = [[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[obj2 objectForKey:@"Ingredients"]];
                          
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
    [_recipiesArray sortUsingComparator:^NSComparisonResult (id obj1, id obj2)
    {
        NSInteger firstObj = [[obj1 objectForKey:@"Rating"] integerValue];
        NSInteger secondObj = [[obj2 objectForKey:@"Rating"] integerValue];
        
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
    return isLoadContent ? [_recipiesArray count] + 1 : [_recipiesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [_recipiesArray count])
    {
        KIASearchRecipiesCollectionVeiwCell *cell = (KIASearchRecipiesCollectionVeiwCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
        NSDictionary *item = [_recipiesArray objectAtIndex:[indexPath row]];
        NSURL *url = [NSURL URLWithString:[[item objectForKey:@"PhotoUrl"] objectAtIndex:0]];
    
        if ([[KIACacheManager sharedCacheManager] checkImageForCacheWithIdentifier:[item objectForKey:@"Id"]])
        {
            [[cell image] setImage:[[KIACacheManager sharedCacheManager] fetchCacheImageForIdentifier:[item objectForKey:@"Id"]]];
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
            {
                NSData *temp = [NSData dataWithContentsOfURL:url];
        
                [[KIACacheManager sharedCacheManager] saveCacheImage:[UIImage imageWithData:temp] forIdentifier:[item objectForKey:@"Id"]];
        
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    [[cell image] setImage:[UIImage imageWithData:temp]];
                });
            });
        }
        
        [[cell title] setText:[item objectForKey:@"Title"]];
    
        [[cell countIngridient] setText:[NSString stringWithFormat:@"Missing Ingredients: %ld", (long)[[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[item objectForKey:@"Ingredients"]]]];
        [[cell kalories] setText:[NSString stringWithFormat:@"Rating:"]];
        [[cell stars] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld-star.png", (long)[[item objectForKey:@"Rating"] integerValue]]]];
        [[cell time] setText:[NSString stringWithFormat:@"Cook Time: %@", ([[item objectForKey:@"TotalTime"] integerValue] > 0 ? ([[item objectForKey:@"TotalTime"] integerValue] / 3600 > 0 ? [NSString stringWithFormat:@"%d hr %@", [[item objectForKey:@"TotalTime"] integerValue] / 3600, (([[item objectForKey:@"TotalTime"] integerValue] - [[item objectForKey:@"TotalTime"] integerValue] / 3600 * 3600) / 60 > 0 ? [NSString stringWithFormat:@"%d min", ([[item objectForKey:@"TotalTime"] integerValue] - [[item objectForKey:@"TotalTime"] integerValue] / 3600 * 3600) / 60] : @"")] : [NSString stringWithFormat:@"%d min", [[item objectForKey:@"TotalTime"] integerValue] / 60]) : @"N/A")]];
    
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpdateCell" forIndexPath:indexPath];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedItem = [indexPath row];
    
    [self performSegueWithIdentifier:@"viewRecipeIdentifier" sender:self];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return isLoadContent ? [_recipiesArray count] + 1 : [_recipiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [_recipiesArray count])
    {
        KIASearchRecipiesTableViewCell *cell = (KIASearchRecipiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        NSDictionary *item = [_recipiesArray objectAtIndex:[indexPath row]];
        NSURL *url = [NSURL URLWithString:[[item objectForKey:@"PhotoUrl"] objectAtIndex:0]];
    
        if ([[KIACacheManager sharedCacheManager] checkImageForCacheWithIdentifier:[item objectForKey:@"Id"]])
        {
            [[cell image] setImage:[[KIACacheManager sharedCacheManager] fetchCacheImageForIdentifier:[item objectForKey:@"Id"]]];
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
            {
                NSData *temp = [NSData dataWithContentsOfURL:url];
                           
                [[KIACacheManager sharedCacheManager] saveCacheImage:[UIImage imageWithData:temp] forIdentifier:[item objectForKey:@"Id"]];
                           
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    [[cell image] setImage:[UIImage imageWithData:temp]];
                });
            });
        }
    
        [[cell title] setText:[item objectForKey:@"Title"]];
    
        [[cell countIngridient] setText:[NSString stringWithFormat:@"Missing Ingredients: %ld", (long)[[KIAUpdater sharedUpdater] howMuchIsMissingIngredient:[item objectForKey:@"Ingredients"]]]];
        [[cell kalories] setText:[NSString stringWithFormat:@"Rating:"]];
        [[cell stars] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld-star.png", (long)[[item objectForKey:@"Rating"] integerValue]]]];
        [[cell time] setText:[NSString stringWithFormat:@"Cook Time: %@", ([[item objectForKey:@"TotalTime"] integerValue] > 0 ? ([[item objectForKey:@"TotalTime"] integerValue] / 3600 > 0 ? [NSString stringWithFormat:@"%d hr %@", [[item objectForKey:@"TotalTime"] integerValue] / 3600, (([[item objectForKey:@"TotalTime"] integerValue] - [[item objectForKey:@"TotalTime"] integerValue] / 3600 * 3600) / 60 > 0 ? [NSString stringWithFormat:@"%d min", ([[item objectForKey:@"TotalTime"] integerValue] - [[item objectForKey:@"TotalTime"] integerValue] / 3600 * 3600) / 60] : @"")] : [NSString stringWithFormat:@"%d min", [[item objectForKey:@"TotalTime"] integerValue] / 60]) : @"N/A")]];
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UpdateCell"];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedItem = [indexPath row];
    
    [self performSegueWithIdentifier:@"viewRecipeIdentifier" sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_recipiesArray count] == [indexPath row])
    {
        return 60;
    }
    
    return 95;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    BOOL endOfTable = (scrollView.contentOffset.y >= (([_recipiesArray count] * 60) - scrollView.frame.size.height)); // Here 56 is row height
    
    if (countRecept > [_recipiesArray count] - 1 && endOfTable && !scrollView.dragging && !scrollView.decelerating)
    {
        isLoadContent = YES;
        
        [_table reloadData];
        [_collection reloadData];
        
        NSLog(@"reload");
        [_searchGateway sendSearchRecipiesForItem:_itemForQuery page:++currentCountRecept delegate:self];
    }
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
        [viewController setRecipiesIdentification:[[_recipiesArray objectAtIndex:_selectedItem] objectForKey:@"Id"]];
        [viewController setIngredientsArray:[[_recipiesArray objectAtIndex:_selectedItem] objectForKey:@"Ingredients"]];
        
        isFilterSettings = NO;
    }
    else
    {
        isFilterSettings = YES;
    }
}

@end
