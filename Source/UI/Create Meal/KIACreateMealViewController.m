//
//  KIACreateMealViewController.m
//  KithInApp
//
//  Created by DeMoN on 8/5/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIACreateMealViewController.h"

@interface KIACreateMealViewController ()

@end

@implementation KIACreateMealViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _mealArray = @[@"Any", @"Breakfast & Brunch", @"Dinner", @"Lunch & Snack"];
        _dishTypeArray = @[@"Any", @"Beverage", @"Bread", @"Dessert", @"Main Dish", @"Salad", @"Side Dish", @"Soup"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)checkMealAction:(id)sender
{
    [_pickerMeal setHidden:![_pickerMeal isHidden]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFonMeal setHidden:![_pickerFonMeal isHidden]];
        [_pickerIndicatorMeal setHidden:![_pickerIndicatorMeal isHidden]];
    }
}

- (IBAction)checkDishTypeAction:(id)sender
{
    [_pickerDishType setHidden:![_pickerDishType isHidden]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFonDishType setHidden:![_pickerFonDishType isHidden]];
        [_pickerIndicatorDishType setHidden:![_pickerIndicatorDishType isHidden]];
    }
}

#pragma mark ***** picker controller *****

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch ([pickerView tag])
    {
        case 100:
            return [_mealArray count];
            break;
        case 200:
            return [_dishTypeArray count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch ([pickerView tag])
    {
        case 100:
            return [_mealArray objectAtIndex:row];
            break;
        case 200:
            return [_dishTypeArray objectAtIndex:row];
            break;
        default:
            return @"";
            break;
    }
}

/*
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_selectStoreTextFild setText:[_storeArray objectAtIndex:row]];
    
    [_picker setHidden:![_picker isHidden]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_pickerFon setHidden:![_pickerFon isHidden]];
        [_pickerIndicator setHidden:![_pickerIndicator isHidden]];
    }
    
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
 */

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
