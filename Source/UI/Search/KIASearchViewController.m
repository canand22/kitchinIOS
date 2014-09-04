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

@interface KIASearchViewController ()

@end

@implementation KIASearchViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _whereSearchArray = @[@"In my Kitchin", @"In the store"];
        
        _yummlyGateway = [KIAServerGateway gateway];
        
        _ingredientArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    _autocompleteArray = itemArray;
    
    [_autocompleteTable reloadData];
}

#pragma mark ***** text field *****

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In the store"])
    {
        [_yummlyGateway searchWithString:[[textField text] stringByAppendingString:string] delegate:self];
    }
    
    if ([[_whereSearchBtn titleForState:UIControlStateNormal] isEqualToString:@"In my Kitchin"])
    {
        _autocompleteArray = [[KIAUpdater sharedUpdater] findItemForText:[[textField text] stringByAppendingString:string]];
        
        [_autocompleteTable reloadData];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ingredientCell"];
        
        [[cell textLabel] setText:[[_ingredientArray objectAtIndex:[indexPath row]] yummlyName]];
        
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SearchRecepies"])
    {
        KIASearchRecipiesViewController *viewController = (KIASearchRecipiesViewController *)[segue destinationViewController];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:[_ingredientArray componentsJoinedByString:@","]];
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
