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

#import "KIAEditRecognizeItemsViewController.h"

#import "KIAUpdater.h"

#import "KIAItem.h"
#import "KIASendCheckMapping.h"
#import "KIAYamlyMapping.h"

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
        _yummlySearchItemGateway = [KIAServerGateway gateway];
        
        _storeArray = @[@"Potash Market", @"Other"];
        
        isBlock = YES;
        
        _itemArray = [[NSMutableArray alloc] init];
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
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFon setHidden:![_pickerFon isHidden]];
        [_pickerIndicator setHidden:![_pickerIndicator isHidden]];
    }
    
    [_addKitchInItem setHidden:NO];
    [_addNewItem setHidden:NO];
        
    [_addNewItem setFrame:CGRectMake(0, [[self view] frame].size.height - 55, 320, 55)];
}

#pragma mark *****

- (IBAction)checkStore:(id)sender
{
    [_picker setHidden:![_picker isHidden]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFon setHidden:![_pickerFon isHidden]];
        [_pickerIndicator setHidden:![_pickerIndicator isHidden]];
    }
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
        [addItemsViewController setCategoryName:_categoryName];
        [addItemsViewController setIsRecognition:_isRecognition];
        [self presentViewController:addItemsViewController animated:YES completion:nil];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIANewItemWithStoreViewController *addItemsViewController = (KIANewItemWithStoreViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newItemWithStoreViewController"];
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
        [addItemsViewController setCategoryName:_categoryName];
        [addItemsViewController setIsRecognition:_isRecognition];
        [self presentViewController:addItemsViewController animated:YES completion:nil];
    }
}

- (IBAction)addItem:(id)sender
{
    if (!isBlock)
    {
        if (_isRecognition)
        {
            KIASearchItemMapping *item = [_itemArray objectAtIndex:indexOfItem];
            
            KIAEditRecognizeItemsViewController *editVC = (KIAEditRecognizeItemsViewController *)[[self presentingViewController] presentingViewController];
            
            for (int i = 0; i < [[editVC itemArray] count]; i++)
            {
                if (![(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] IsSuccessMatching])
                {
                    [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setId:[item itemId]];
                    [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setItemName:[item itemName]];
                    [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setCategory:_categoryName];
                    [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setItemShortName:[item itemShortName]];
                    [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setYummlyName:[item yummlyName]];
                    [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setIsSuccessMatching:YES];
                    
                    break;
                }
            }
            
            [editVC dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            if ([[_selectStoreTextFild text] isEqualToString:@"Other"])
            {
                KIAYamlyMapping *item = [_itemArray objectAtIndex:indexOfItem];
                
                [[KIAUpdater sharedUpdater] addItemFromKitchInWihtId:[[item itemId] integerValue]
                                                                name:[item name]
                                                          categoryId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:_categoryName]
                                                           shortName:[item shotName]
                                                               count:1
                                                               value:@""
                                                              yummly:[item yummlyName]];
            }
            else
            {
                KIASearchItemMapping *item = [_itemArray objectAtIndex:indexOfItem];
                
                [[KIAUpdater sharedUpdater] addItemFromKitchInWihtId:[item itemId]
                                                                name:[item itemName]
                                                          categoryId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:_categoryName]
                                                           shortName:[item itemShortName]
                                                               count:1
                                                               value:@""
                                                              yummly:[item yummlyName]];
            }
    
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please search an item to add"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

#pragma mark ***** text delegate *****

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)search:(id)sender
{
    if ([[_selectStoreTextFild text] isEqualToString:@"Other"])
    {
        [_yummlySearchItemGateway searchWithString:[_itemTextField text] delegate:self];
    }
    else
    {
        [_searchItemGateway searchItemWithText:[_itemTextField text] categoyId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:_categoryName] storeId:1 delegate:self];
    }
    
    isBlock = YES;
}

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
    
    if ([[_selectStoreTextFild text] isEqualToString:@"Other"])
    {
        [[cell textLabel] setText:[[_itemArray objectAtIndex:[indexPath row]] yummlyName]];
    }
    else
    {
        if ([[_itemArray objectAtIndex:[indexPath row]] isKindOfClass:[KIAYamlyMapping class]])
        {
            [[cell textLabel] setText:[[_itemArray objectAtIndex:[indexPath row]] name]];
        }
        else
        {
            [[cell textLabel] setText:[[_itemArray objectAtIndex:[indexPath row]] itemName]];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_selectStoreTextFild text] isEqualToString:@"Other"])
    {
        [_itemTextField setText:[[_itemArray objectAtIndex:[indexPath row]] yummlyName]];
    }
    else
    {
        [_itemTextField setText:[[_itemArray objectAtIndex:[indexPath row]] itemName]];
    }
    
    indexOfItem = [indexPath row];
    
    isBlock = NO;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark *****

- (void)showData:(NSArray *)data
{
    [_itemArray removeAllObjects];
    NSMutableSet *names = [NSMutableSet set];
    
    for (id obj in data)
    {
        if ([obj yummlyName])
        {
            NSString *yummlyName = [obj yummlyName];
        
            if (![names containsObject:yummlyName])
            {
                [_itemArray addObject:obj];
                [names addObject:yummlyName];
            }
        }
    }
    
    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
