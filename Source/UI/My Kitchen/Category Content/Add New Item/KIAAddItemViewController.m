//
//  KIAAddItemViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAAddItemViewController.h"

#import "KIAServerGateway.h"
#import "KIASearchItemMapping.h"

#import "KIANewItemWithStoreViewController.h"
#import "KIANewItemWithOtherViewController.h"

#import "KIAUpdater.h"

#import "KIAItem.h"

@interface KIAAddItemViewController ()

@end

@implementation KIAAddItemViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _searchItemGateway = [KIAServerGateway gateway];
        
        _storeArray = @[@"Potash store", @"Other"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark ***** picker view *****

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_storeArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_storeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_selectStoreTextFild setText:[_storeArray objectAtIndex:row]];
    [_picker setHidden:![_picker isHidden]];
    
    if ([[_storeArray objectAtIndex:row] isEqualToString:@"Other"])
    {
        [_addNewItem setHidden:NO];
        [_addKitchInItem setHidden:YES];
        
        [_addNewItem setFrame:CGRectMake(0, 180, 320, 55)];
    }
    else
    {
        [_addKitchInItem setHidden:NO];
        [_addNewItem setHidden:NO];
        
        [_addNewItem setFrame:CGRectMake(0, [[self view] frame].size.height - 55, 320, 55)];
    }
}

#pragma mark *****

- (IBAction)checkStore:(id)sender
{
    [_picker setHidden:![_picker isHidden]];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)manually:(id)sender
{
    if ([[_selectStoreTextFild text] isEqualToString:@"Other"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIANewItemWithOtherViewController *addItemsViewController = (KIANewItemWithOtherViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newItemWithOtherViewController"];
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
        [self presentViewController:addItemsViewController animated:YES completion:nil];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIANewItemWithStoreViewController *addItemsViewController = (KIANewItemWithStoreViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newItemWithStoreViewController"];
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
        [addItemsViewController setCategoryName:_categoryName];
        [self presentViewController:addItemsViewController animated:YES completion:nil];
    }
}

- (IBAction)addItem:(id)sender
{
    KIASearchItemMapping *item = [_itemArray objectAtIndex:indexOfItem];
    
    [[KIAUpdater sharedUpdater] addItemFromKitchInWihtId:[item itemId]
                                                    name:[item itemName]
                                              categoryId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:_categoryName]
                                               shortName:[item itemShortName]
                                                   count:0
                                                   value:@""];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ***** text delegate *****

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [_searchItemGateway searchItemWithText:[[textField text] stringByAppendingString:string] categoyId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:_categoryName] storeId:1 delegate:self];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark *****
#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [[cell textLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [[cell textLabel] setText:[[_itemArray objectAtIndex:[indexPath row]] itemName]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_itemTextField setText:[[_itemArray objectAtIndex:[indexPath row]] itemName]];
    
    indexOfItem = [indexPath row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark *****

- (void)showData:(NSArray *)data
{
    _itemArray = data;
    
    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
