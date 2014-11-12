// ************************************************ //
//                                                  //
//  KIAEditRecognizeItemsViewController.m           //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIAEditRecognizeItemsViewController.h"

#import "KIASendCheckMapping.h"
#import "EditRecognizedItemCell.h"

#import "KIASelectCategoryViewController.h"
#import "KIATabBarViewController.h"
#import "KIAMyKitchenViewController.h"

#import "KIALoginViewController.h"

#import "KIAServerGateway.h"

#import "KIAUpdater.h"

#define CELL_TAG 100

@interface KIAEditRecognizeItemsViewController ()

@end

@implementation KIAEditRecognizeItemsViewController

@synthesize getItemGateway = _getItemGateway;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _itemArray = [[NSMutableArray alloc] init];
        
        _unitArray = @[@"teaspoon", @"tablespoon", @"fluid ounce", @"cups", @"pint", @"quart", @"gallon", @"milliliter", @"liter, litre", @"deciliter", @"pound", @"ounce", @"mcg", @"milligram", @"gram", @"kilogram"];
        _unitReductionArray = @[@"tsp", @"tbsp", @"fl oz", @"cup(s)", @"pt", @"qt", @"gal", @"ml", @"l", @"dl", @"lb", @"oz", @"μg", @"mg", @"g", @"kg"];
        
        _category = @{@"DAIRY" : @"6", @"PRODUCE" : @"10", @"POULTRY" : @"12", @"MEATS & DELI" : @"14", @"SEAFOOD" : @"13", @"BREADS & BAKERY" : @"2", @"PASTA" : @"11", @"CEREAL & GRAINS" : @"4", @"DRINKS" : @"7", @"DRY PREPARED FOODS" : @"8", @"CANNED FOODS, SOUPS, BROTHS" : @"3", @"FROZEN" : @"9", @"SNACKS" : @"15", @"SWEETS" : @"17", @"BAKING" : @"1", @"CONDIMENTS, SAUCES, OILS" : @"5", @"SPICES & HERBS" : @"16", @"OTHER" : @"18"};
        
        _getItemGateway = [KIAServerGateway gateway];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    if ([_table respondsToSelector:@selector(setBackgroundView:)])
    {
        [_table setBackgroundView:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [[self view] frame].size.height, 320, 160)];
    [picker setShowsSelectionIndicator:YES];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [[self view] addSubview:picker];
    
    [_table reloadData];
}

- (IBAction)addToMyKitchIn:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"])
    {
        NSLog(@"YES");
        
        for (int i = 0; i < [_itemArray count]; i++)
        {
            KIASendCheckMapping *item = [_itemArray objectAtIndex:i];
            
            if ([item IsSuccessMatching])
            {
                EditRecognizedItemCell *cell = (EditRecognizedItemCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i + 1 inSection:0]];
                
                [[KIAUpdater sharedUpdater] addItemFromKitchInWihtId:[item Id] name:[item ItemName] categoryId:[[_category objectForKey:[[item Category] uppercaseString]] integerValue] shortName:[item ItemShortName] count:[[[cell countField] text] integerValue] value:@"" yummly:[item YummlyName]];
                
                KIATabBarViewController *tabBarVC = (KIATabBarViewController *)[[self presentingViewController] presentingViewController];
                [tabBarVC dismissViewControllerAnimated:YES completion:nil];
                
                [tabBarVC setSelectedIndex:1];
                [[[tabBarVC viewControllers] objectAtIndex:1] popToRootViewControllerAnimated:NO];
                
                [tabBarVC reloadButtonImageWithIndex:2];
            }
        }
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIALoginViewController *loginViewController = (KIALoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemArray count] + 2;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0)
    {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg white first.png"]]];
    }
    else if ([indexPath row] == [_itemArray count] + 1)
    {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg white last.png"]]];
    }
    else
    {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg white.png"]]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([indexPath row] == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
    }
    else if ([indexPath row] == [_itemArray count] + 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"lastCell"];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if ([[_itemArray objectAtIndex:[indexPath row] - 1] IsSuccessMatching])
        {
            [[(EditRecognizedItemCell *)cell textField] setTitle:[[_itemArray objectAtIndex:[indexPath row] - 1] ItemName] forState:UIControlStateNormal];
            [[(EditRecognizedItemCell *)cell textField] setEnabled:NO];
        }
        else
        {
            [[(EditRecognizedItemCell *)cell textField] setTitle:@"Unrecognized" forState:UIControlStateNormal];
            [[(EditRecognizedItemCell *)cell textField] setEnabled:YES];
        }
        
        [(EditRecognizedItemCell *)cell setDelegate:self];
        
        [[(EditRecognizedItemCell *)cell deleteButton] setTag:[indexPath row] + CELL_TAG];
    }
    
    [cell setTag:[indexPath row] + CELL_TAG];
    
    return cell;
}

#pragma mark *****

- (void)showActionSheet:(NSInteger)numberOfCellRow
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"])
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Add new item", @"Item from My Kitchin", nil];
    
        [actionSheet setTag:numberOfCellRow];
        [actionSheet showInView:[self view]];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIALoginViewController *loginViewController = (KIALoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KIASelectCategoryViewController *categoryItemsViewController = (KIASelectCategoryViewController *)[storyboard instantiateViewControllerWithIdentifier:@"selectCategoryIdentifier"];
    
    switch (buttonIndex)
    {
        case 0:
        {
            [categoryItemsViewController setMode:addNewItem];
            [self presentViewController:categoryItemsViewController animated:YES completion:nil];
            break;
        }
        case 1:
        {
            [categoryItemsViewController setMode:addKitchInItem];
            [self presentViewController:categoryItemsViewController animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

- (void)deleteItemFromIndex:(NSInteger)index
{
    [_itemArray removeObjectAtIndex:index - CELL_TAG - 1];
    
    [_table reloadData];
}

#pragma mark ***** picker view *****

- (void)showPickerView:(NSInteger)numberOfCellRow
{
    [picker setTag:numberOfCellRow];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5f];

    [picker setFrame:CGRectMake(0, [[self view] frame].size.height - 160, 320, 160)];
    [_table setFrame:CGRectMake(0, 70, 320, [[self view] frame].size.height - 230)];
    
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
    EditRecognizedItemCell *cell = (EditRecognizedItemCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[pickerView tag] - CELL_TAG inSection:0]];
    
    [[cell unit] setTitle:[_unitReductionArray objectAtIndex:row] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5f];
    
    [pickerView setFrame:CGRectMake(0, [[self view] frame].size.height, 320, 160)];
    [_table setFrame:CGRectMake(0, 70, 320, [[self view] frame].size.height)];
    
    [UIView commitAnimations];
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
