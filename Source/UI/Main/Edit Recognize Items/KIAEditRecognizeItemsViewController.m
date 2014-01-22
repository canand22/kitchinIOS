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

#import "KIALoginViewController.h"

#define CELL_TAG 100

@interface KIAEditRecognizeItemsViewController ()

@end

@implementation KIAEditRecognizeItemsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _itemArray = [[NSArray alloc] init];
        
        _unitArray = @[@"teaspoon", @"tablespoon", @"fluid ounce", @"cups", @"pint", @"quart", @"gallon", @"milliliter", @"liter, litre", @"deciliter", @"pound", @"ounce", @"mcg", @"milligram", @"gram", @"kilogram"];
        _unitReductionArray = @[@"tsp", @"tbsp", @"fl oz", @"cup(s)", @"pt", @"qt", @"gal", @"ml", @"l", @"dl", @"lb", @"oz", @"μg", @"mg", @"g", @"kg"];
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

- (IBAction)addToMyKitchIn:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"])
    {
        NSLog(@"YES");
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
    }
    
    [cell setTag:[indexPath row] + CELL_TAG];
    
    return cell;
}

#pragma mark *****

- (void)showActionSheet:(NSInteger)numberOfCellRow
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Add new item", @"Item from My Kitchen", nil];
    
    [actionSheet setTag:numberOfCellRow];
    [actionSheet showInView:[self view]];
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

#pragma mark ***** picker view *****

- (void)showPickerView:(NSInteger)numberOfCellRow
{
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    [picker setShowsSelectionIndicator:YES];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [picker setTag:numberOfCellRow];
    [[self view] addSubview:picker];
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
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
