//
//  KIACreateMealViewController.m
//  KithInApp
//
//  Created by DeMoN on 8/5/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIACreateMealViewController.h"

#import "KIAUsersFromHouseholdViewController.h"
#import "KIASelectCategoryViewController.h"
#import "KIASearchRecipiesViewController.h"

#import "KIASearchDefines.h"

#import "KIAUpdater.h"
#import "KIAUser.h"

#import "KIATabBarViewController.h"

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
        
        // _usersCooking = [[NSMutableArray alloc] init];
        
        _cookWith = [[NSMutableArray alloc] init];
        _cookWithout = [[NSMutableArray alloc] init];
        
        _usersCooking = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [_userTagView setTagDelegate:self];
    [_ingredientWithTagView setTagDelegate:self];
    [_ingredientWithoutTagView setTagDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _users = [[[KIAUpdater sharedUpdater] getAllUsers] mutableCopy];
    
    for (int i = (int)[_users count] - 1; i > -1; i--)
    {
        KIAUser *item = [_users objectAtIndex:i];
        
        if ([[item isActiveState] isEqual:@NO] || [[item name] isEqualToString:@""])
        {
            [_users removeObject:item];
        }
        else
        {
            if (![_usersCooking containsObject:[item name]])
            {
                [_usersCooking addObject:[item name]];
            }
        }
    }
    
    [_userTagView setTags:_usersCooking];
    
    CGRect frame = [_userTagFoneView frame];
    frame.size.height = [_userTagView fittedSize].height + 6;
    [_userTagFoneView setFrame:frame];
    
    [self firstTagsReloadFrameWithHeight:([_userTagView fittedSize].height + 6 < 35 ? 35 : [_userTagView fittedSize].height + 6)];
    
    [_ingredientWithTagView setTags:_cookWith];
    
    frame = [_ingredientWithTagFoneView frame];
    frame.origin.y = [_firstSectionView frame].origin.y + [_firstSectionView frame].size.height + 11;
    frame.size.height = ([_ingredientWithTagView fittedSize].height + 6 < 35 ? 35 : [_ingredientWithTagView fittedSize].height + 6);
    [_ingredientWithTagFoneView setFrame:frame];
    
    [self secondTagsReloadFrameWithHeight:[_ingredientWithTagFoneView frame].size.height];
    
    for (KIAUser *user in _users)
    {
        [_cookWithout addObjectsFromArray:[user dislikeIngredients]];
    }
    
    _cookWithout = [[[NSSet setWithArray:_cookWithout] allObjects] mutableCopy];
    
    [_ingredientWithoutTagView setTags:_cookWithout];
    
    frame = [_ingredientWithoutTagFoneView frame];
    frame.size.height = ([_ingredientWithoutTagView fittedSize].height + 6 < 35 ? 35 : [_ingredientWithoutTagView fittedSize].height + 6);
    [_ingredientWithoutTagFoneView setFrame:frame];
    
    [self thirdTagsReloadFrameWithHeight:[_ingredientWithoutTagFoneView frame].size.height];
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

- (void)usersForCooking:(NSArray *)users
{
    [_usersCooking addObjectsFromArray:[users mutableCopy]];

    _usersCooking = [[[NSSet setWithArray:_usersCooking] allObjects] mutableCopy];
    
    [_userTagView setTags:_usersCooking];
    
    CGRect frame = [_userTagFoneView frame];
    frame.size.height = [_userTagView fittedSize].height + 6;
    [_userTagFoneView setFrame:frame];
    
    [self firstTagsReloadFrameWithHeight:[_userTagView fittedSize].height];
}

- (IBAction)cookWithAction:(id)sender
{
    if ([[[KIAUpdater sharedUpdater] getAllItems] count] > 0)
    {
        [self performSegueWithIdentifier:@"categoryItemCookWith" sender:self];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"There are no ingredients in your KitchIn!"
                                                        message:@"Would you like to add ingredients to your KitchIn now?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        
        [alert show];
    }
}

- (IBAction)cookWithoutAction:(id)sender
{
    if ([[[KIAUpdater sharedUpdater] getAllItems] count] > 0)
    {
        [self performSegueWithIdentifier:@"categoryItemCookWithout" sender:self];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"There are no ingredients in your KitchIn!"
                                                        message:@"Would you like to add ingredients to your KitchIn now?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        
        [alert show];
    }
}

#pragma mark ***** alert view *****

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        KIATabBarViewController *tabBarVC = (KIATabBarViewController *)[self tabBarController];
        
        [tabBarVC setSelectedIndex:3];
        [[[tabBarVC viewControllers] objectAtIndex:3] popToRootViewControllerAnimated:NO];
        
        [tabBarVC reloadButtonImageWithIndex:5];
    }
}

#pragma mark ***** DWTagList delegate *****

- (void)tagViewWantsToBeDeleted:(DWTagView *)tagView
{
}

- (void)tagListTagsChanged:(DWTagList *)tagList
{
}

- (void)selectedTag:(NSString *)tagName
{
    if ([_usersCooking containsObject:tagName])
    {
        for (KIAUser *user in _users)
        {
            if ([[user name] isEqualToString:tagName])
            {
                [user setIsActiveState:@NO];
                [[KIAUpdater sharedUpdater] updateUsersInfo:user];
            }
        }
        
        [_usersCooking removeObject:tagName];
        
        [_userTagView setTags:_usersCooking];
        
        CGRect frame = [_userTagFoneView frame];
        frame.size.height = ([_userTagView fittedSize].height + 6 < 35 ? 35 : [_userTagView fittedSize].height + 6);
        [_userTagFoneView setFrame:frame];
        
        [self firstTagsReloadFrameWithHeight:[_userTagFoneView frame].size.height];
    }
    
    if ([_cookWith containsObject:tagName])
    {
        [_cookWith removeObject:tagName];
        
        [_ingredientWithTagView setTags:_cookWith];
        
        CGRect frame = [_ingredientWithTagFoneView frame];
        frame.size.height = ([_ingredientWithTagView fittedSize].height + 6 < 35 ? 35 : [_ingredientWithTagView fittedSize].height + 6);
        [_ingredientWithTagFoneView setFrame:frame];
        
        [self secondTagsReloadFrameWithHeight:[_ingredientWithTagFoneView frame].size.height];
    }
    
    if ([_cookWithout containsObject:tagName])
    {
        [_cookWithout removeObject:tagName];
        
        [_ingredientWithoutTagView setTags:_cookWithout];
        
        CGRect frame = [_ingredientWithoutTagFoneView frame];
        frame.size.height = ([_ingredientWithoutTagView fittedSize].height + 6 < 35 ? 35 : [_ingredientWithoutTagView fittedSize].height + 6);
        [_ingredientWithoutTagFoneView setFrame:frame];
        
        [self thirdTagsReloadFrameWithHeight:[_ingredientWithoutTagFoneView frame].size.height];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch ([pickerView tag])
    {
        case 100:
        {
            [_mealButton setTitle:[_mealArray objectAtIndex:row] forState:UIControlStateNormal];
            
            [_pickerMeal setHidden:![_pickerMeal isHidden]];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                [_pickerFonMeal setHidden:![_pickerFonMeal isHidden]];
                [_pickerIndicatorMeal setHidden:![_pickerIndicatorMeal isHidden]];
            }
            
            break;
        }
        case 200:
        {
            [_dishTypeButton setTitle:[_dishTypeArray objectAtIndex:row] forState:UIControlStateNormal];
            
            [_pickerDishType setHidden:![_pickerDishType isHidden]];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                [_pickerFonDishType setHidden:![_pickerFonDishType isHidden]];
                [_pickerIndicatorDishType setHidden:![_pickerIndicatorDishType isHidden]];
            }
            
            break;
        }
        default:
            
            break;
    }
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"usersFromHousehold"])
    {
        KIAUsersFromHouseholdViewController *viewController = (KIAUsersFromHouseholdViewController *)[segue destinationViewController];
        [viewController setDelegate:self];
        [viewController setCurrentUsers:_usersCooking];
    }

    if ([[segue identifier] isEqualToString:@"categoryItemCookWithout"])
    {
        KIASelectCategoryViewController *viewController = (KIASelectCategoryViewController *)[segue destinationViewController];
        [viewController setMode:selectItems];
        [viewController setSelectedItems:_cookWithout];
    }
    
    if ([[segue identifier] isEqualToString:@"categoryItemCookWith"])
    {
        KIASelectCategoryViewController *viewController = (KIASelectCategoryViewController *)[segue destinationViewController];
        [viewController setMode:selectItems];
        [viewController setSelectedItems:_cookWith];
    }
        
    if ([[segue identifier] isEqualToString:@"SearchRecepies"])
    {
        KIASearchRecipiesViewController *viewController = (KIASearchRecipiesViewController *)[segue destinationViewController];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:[_cookWith componentsJoinedByString:@","]];
        [items addObject:[_cookWithout componentsJoinedByString:@","]];
        [items addObject:@""];
        [items addObject:@""];
        [items addObject:@""];
        [items addObject:[_dishTypeButton titleForState:UIControlStateNormal]];
        [items addObject:@""];
        [items addObject:[_mealButton titleForState:UIControlStateNormal]];
        [items addObject:@""];
        NSArray *keys = [NSArray arrayWithObjects:COOK_WITH, COOK_WITHOUT, ALLERGIES, DIETS, CUISINE, DISH_TYPE, HOLIDAY, MEAL, TIME, nil];
        
        [viewController setItemForQuery:[NSDictionary dictionaryWithObjects:items forKeys:keys]];
    }
}

#pragma mark ***** element position *****

- (void)firstTagsReloadFrameWithHeight:(CGFloat)height
{
    CGRect frame = [_firstSectionView frame];
    frame.origin.y = [_userTagFoneView frame].origin.y + height + 11;
    [_firstSectionView setFrame:frame];
    
    frame = [_ingredientWithTagFoneView frame];
    frame.origin.y = [_userTagFoneView frame].origin.y + height + 119;
    [_ingredientWithTagFoneView setFrame:frame];
 
    frame = [_secondSectionView frame];
    frame.origin.y = [_ingredientWithTagFoneView frame].origin.y + [_ingredientWithTagFoneView frame].size.height + 5;
    [_secondSectionView setFrame:frame];
    
    frame = [_ingredientWithoutTagFoneView frame];
    frame.origin.y = [_secondSectionView frame].origin.y + [_secondSectionView frame].size.height + 5;
    [_ingredientWithoutTagFoneView setFrame:frame];
}

- (void)secondTagsReloadFrameWithHeight:(CGFloat)height
{
    CGRect frame = [_ingredientWithTagFoneView frame];
    frame.origin.y = [_firstSectionView frame].origin.y + [_firstSectionView frame].size.height + 5;
    [_ingredientWithTagFoneView setFrame:frame];
    
    frame = [_secondSectionView frame];
    frame.origin.y = [_ingredientWithTagFoneView frame].origin.y + [_ingredientWithTagFoneView frame].size.height + 5;
    [_secondSectionView setFrame:frame];
    
    frame = [_ingredientWithoutTagFoneView frame];
    frame.origin.y = [_secondSectionView frame].origin.y + [_secondSectionView frame].size.height + 5;
    [_ingredientWithoutTagFoneView setFrame:frame];
}

- (void)thirdTagsReloadFrameWithHeight:(CGFloat)height
{
    CGRect frame = [_ingredientWithoutTagFoneView frame];
    frame.origin.y = [_secondSectionView frame].origin.y + [_secondSectionView frame].size.height + 5;
    [_ingredientWithoutTagFoneView setFrame:frame];
    
    [_scroll setContentSize:CGSizeMake(320, [_ingredientWithoutTagFoneView frame].origin.y + [_ingredientWithoutTagFoneView frame].size.height + 10)];
}

#pragma mark *****

@end
