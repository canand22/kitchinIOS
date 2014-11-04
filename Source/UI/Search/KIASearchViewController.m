//
//  KIASearchViewController.m
//  KithInApp
//
//  Created by DeMoN on 8/5/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASearchViewController.h"

#import "KIAServerGateway.h"
#import "KIAUpdater.h"
#import "KIAYamlyMapping.h"

#import "KIASearchRecipiesViewController.h"

#import "KIASearchDefines.h"

#import "KIARemoveOrAddTableViewCell.h"

@interface KIASearchViewController ()

@end

@implementation KIASearchViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _categoriesArray = [NSArray arrayWithObjects:@"Dairy", @"Produce", @"Poultry", @"Meats & Deli", @"Seafood", @"Breads & Bakery", @"Pasta", @"Cereal & Grains", @"Drinks", @"Dry Prepared Foods", @"Canned Foods, Soups, Broths", @"Frozen", @"Snacks", @"Sweets", @"Baking", @"Condiments, Sauces, Oils", @"Spices & Herbs", @"Other", nil];
        
        _whereSearchArray = @[@"In my Kitchin", @"In the store"];
        
        _yummlyGateway = [KIAServerGateway gateway];
        
        _ingredientArray = [[NSMutableArray alloc] init];
        _autocompleteArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    isAlertShow = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_ingredientArray removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickerAction:(id)sender
{
    [_picker setHidden:![_picker isHidden]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFon setHidden:![_pickerFon isHidden]];
        [_pickerIndicator setHidden:![_pickerIndicator isHidden]];
    }
}

- (void)showData:(NSArray *)itemArray
{
    if ([itemArray count] > 0)
    {
        isAlertShow = NO;
    }
    
    if (!isAlertShow)
    {
        [_autocompleteArray removeAllObjects];
        NSMutableSet *names = [NSMutableSet set];
    
        for (id obj in itemArray)
        {
            NSString *yummlyName = [obj yummlyName];
        
            if (![names containsObject:yummlyName])
            {
                [_autocompleteArray addObject:obj];
                [names addObject:yummlyName];
            }
        }
    
        if ([_autocompleteArray count] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bummer! We couldn't find any ingredient based on your selection."
                                                            message:@"Please modify your search and try again!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
            [alert show];
        
            isAlertShow = YES;
        }
    
        [_autocompleteTable reloadData];
    }
}

- (void)reloadQueryWithText:(NSString *)str
{
    if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In the store"])
    {
        [_yummlyGateway searchWithString:str delegate:self];
    }
    
    if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In my Kitchin"])
    {
        _autocompleteArray = [[[KIAUpdater sharedUpdater] findItemForText:str] mutableCopy];
        
        if ([_autocompleteArray count] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bummer! We couldn't find any ingredient based on your selection."
                                                            message:@"Please modify your search and try again!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
            [alert show];
        }
        
        [_autocompleteTable reloadData];
    }
}

#pragma mark ***** text field *****

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
    [self reloadQueryWithText:[_searchField text]];
}

#pragma mark ***** picker view *****

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_whereSearchArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_whereSearchArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_whereSearchBtn setTitle:[_whereSearchArray objectAtIndex:row] forState:UIControlStateNormal];
    
    if (row == 0)
    {
        [_whereSearch setText:@"Ingredients found in your Kitchin:"];
    }
    else
    {
        [_whereSearch setText:@"Ingredients found in store:"];
    }
    
    [_picker setHidden:![_picker isHidden]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFon setHidden:![_pickerFon isHidden]];
        [_pickerIndicator setHidden:![_pickerIndicator isHidden]];
    }
    
    [_ingredientArray removeAllObjects];
    [_autocompleteArray removeAllObjects];
    
    [_autocompleteTable reloadData];
    [_ingreditntsTable reloadData];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_autocompleteTable])
    {
        return [_autocompleteArray count];
    }
    
    if ([tableView isEqual:_ingreditntsTable])
    {
        return [_ingredientArray count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_autocompleteTable])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        [[cell textLabel] setText:[[_autocompleteArray objectAtIndex:[indexPath row]] yummlyName]];
        
        return cell;
    }
    
    if ([tableView isEqual:_ingreditntsTable])
    {
        KIARemoveOrAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ingredientCell"];
        
        [[cell textLabel] setText:[[_ingredientArray objectAtIndex:[indexPath row]] yummlyName]];
        
        if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In my Kitchin"])
        {
            [cell setIsRemoveCell:YES];
        }
        
        if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In the store"])
        {
            [cell setIsRemoveCell:NO];
        }
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_autocompleteTable])
    {
        if (![_ingredientArray containsObject:[_autocompleteArray objectAtIndex:[indexPath row]]])
        {
            [_ingredientArray addObject:[_autocompleteArray objectAtIndex:[indexPath row]]];
            
            [_ingreditntsTable reloadData];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    if ([tableView isEqual:_ingreditntsTable])
    {
        return YES;
    }
    
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In my Kitchin"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected ingredient will be deleted from your Kitchin."
                                                            message:@"Are you sure?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
            
            [alert setTag:[indexPath row]];
            
            [alert show];
        }
        
        if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In the store"])
        {
            [[KIAUpdater sharedUpdater] addItemFromKitchInWihtId:[[[_ingredientArray objectAtIndex:[indexPath row]] itemId] integerValue]
                                                            name:[[_ingredientArray objectAtIndex:[indexPath row]] name]
                                                      categoryId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:[[[_ingredientArray objectAtIndex:[indexPath row]] categoryName] capitalizedString]]
                                                       shortName:[[_ingredientArray objectAtIndex:[indexPath row]] shotName]
                                                           count:1
                                                           value:@""
                                                          yummly:[[_ingredientArray objectAtIndex:[indexPath row]] yummlyName]];
            
            [_ingredientArray removeObjectAtIndex:[indexPath row]];
            
            [_ingreditntsTable reloadData];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"New ingredient is added successfully to your Kitchin"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alert show];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In the store"])
    {
        return @"Add";
    }
    
    if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In my Kitchin"])
    {
        return @"Delete";
    }
    
    return @"";
}

#pragma mark ***** alert view *****

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[KIAUpdater sharedUpdater] removeItem:[_ingredientArray objectAtIndex:[alertView tag]]];
        
        [_ingredientArray removeObjectAtIndex:[alertView tag]];
        
        [_ingreditntsTable reloadData];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SearchRecepies"])
    {
        KIASearchRecipiesViewController *viewController = (KIASearchRecipiesViewController *)[segue destinationViewController];
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [_ingredientArray count]; i++)
        {
            [temp addObject:[[_ingredientArray objectAtIndex:i] yummlyName]];
        }
        
        if ([temp count] == 0)
        {
            for (int i = 0; i < 18; i++)
            {
                NSArray *items = [[KIAUpdater sharedUpdater] itemsForCategoryName:[_categoriesArray objectAtIndex:i]];
                
                if ([items count] > 0)
                {
                    [temp addObject:[[items objectAtIndex:0] name]];
                }
            }
        }
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:[temp componentsJoinedByString:@","]];
        [items addObject:@""];
        [items addObject:@""];
        [items addObject:@""];
        [items addObject:@""];
        [items addObject:@""];
        [items addObject:@""];
        [items addObject:@""];
        [items addObject:@""];
        NSArray *keys = [NSArray arrayWithObjects:COOK_WITH, COOK_WITHOUT, ALLERGIES, DIETS, CUISINE, DISH_TYPE, HOLIDAY, MEAL, TIME, nil];
        
        [viewController setItemForQuery:[NSDictionary dictionaryWithObjects:items forKeys:keys]];
    }
}

@end
