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
        _unitArray = @[@"teaspoon", @"tablespoon", @"fluid ounce", @"cups", @"pint", @"quart", @"gallon", @"milliliter", @"liter, litre", @"deciliter", @"pound", @"ounce", @"mcg", @"milligram", @"gram", @"kilogram"];
        _unitReductionArray = @[@"tsp", @"tbsp", @"fl oz", @"cup(s)", @"pt", @"qt", @"gal", @"ml", @"l", @"dl", @"lb", @"oz", @"μg", @"mg", @"g", @"kg"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [[self view] frame].size.height, 320, 162)];
    [picker setShowsSelectionIndicator:YES];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [[self view] addSubview:picker];
    
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
    
    [[cell countIngredient] setText:[NSString stringWithFormat:@"%@", [temp count]]];
    [[cell valueBtn] setTitle:[temp value] forState:UIControlStateNormal];
    [[cell valueBtn] setTag:[indexPath row] + CELL_TAG];
    
    [cell setDelegate:self];
    [cell setTag:[indexPath row] + CELL_TAG];
    
    return cell;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5f];
        
        CGRect frame = [_table frame];
        frame.size.height += [picker frame].size.height;
        [picker setFrame:CGRectMake(0, [[self view] frame].size.height, 320, 162)];
        [_table setFrame:frame];
        
        [UIView commitAnimations];
        
        [self deleteItemFromIndex:[indexPath row]];
    }
}

- (void)deleteItemFromIndex:(NSInteger)index
{
    [[KIAUpdater sharedUpdater] removeItem:[_categoryItems objectAtIndex:index]];
    
    [self reloadDataFromTable];
}

- (void)updateItemFromIndex:(NSInteger)index count:(CGFloat)count
{
    KIAItem *temp = [_categoryItems objectAtIndex:index - CELL_TAG];
    [temp setCount:[NSNumber numberWithDouble:count]];
    [[KIAUpdater sharedUpdater] updateItemInfo:temp];
}

#pragma mark ***** picker view *****

- (void)showPickerView:(NSInteger)numberOfCellRow
{
    [picker setTag:numberOfCellRow];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5f];
    
    CGRect frame = [_table frame];
    frame.size.height = [[self view] frame].size.height - [picker frame].size.height - 250;
    [picker setFrame:CGRectMake(0, [[self view] frame].size.height - 210, 320, 162)];
    [_table setFrame:frame];
    
    [UIView commitAnimations];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_unitArray count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_unitArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    CategoryItemCell *cell = (CategoryItemCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[pickerView tag] - CELL_TAG inSection:0]];
    
    [[(CategoryItemCell *)cell valueBtn] setTitle:[_unitReductionArray objectAtIndex:row] forState:UIControlStateNormal];
    
    KIAItem *temp = [_categoryItems objectAtIndex:[pickerView tag] - CELL_TAG];
    [temp setValue:[_unitReductionArray objectAtIndex:row]];
    [[KIAUpdater sharedUpdater] updateItemInfo:temp];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5f];
    
    CGRect frame = [_table frame];
    frame.size.height += [pickerView frame].size.height;
    [pickerView setFrame:CGRectMake(0, [[self view] frame].size.height, 320, 162)];
    [_table setFrame:frame];
    
    [UIView commitAnimations];
}

#pragma mark *****

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"1000"])
    {
        KIAAddItemViewController *categoryContent = (KIAAddItemViewController *)[segue destinationViewController];
        
        [categoryContent setCategoryName:_categoryName];
        [categoryContent setIsRecognition:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_table setEditing:NO];
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
