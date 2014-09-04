//
//  KIARecipeFiltersViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/20/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIARecipeFiltersViewController.h"

#import "KIACheckBoxTableViewCell.h"
#import "KIARadioButtonTableViewCell.h"

#import "KIAFilterSettings.h"

#define CHECK_BUTTON_ACTIVE @"ceckbox_active.png"
#define CHECK_BUTTON_DEACTIVE @"ceckbox.png"
#define RADIO_BUTTON_ACTIVE @"radio_active.png"
#define RADIO_BUTTON_DEACTIVE @"radio.png"

@interface KIARecipeFiltersViewController ()

@end

@implementation KIARecipeFiltersViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _filtersList = @{@"Cuisine" : @[@"American", @"Italian", @"Asian", @"Mexican", @"Southern & Soul Food", @"French", @"Southwestern", @"Barbecue", @"Indian", @"Chinese", @"Cajun & Creole", @"English", @"Mediterranean", @"Greek", @"Spanish", @"German", @"Thai", @"Moroccan", @"Irish", @"Japanese", @"Cuban", @"Hawaiian", @"Swedish", @"Hungarian", @"Portuguese"],
                         @"Meal" : @[@"Any", @"Breakfast & Brunch", @"Dinner", @"Lunch & Snack"],
                         @"Dish Type" : @[@"Any", @"Beverage", @"Bread", @"Dessert", @"Main Dish", @"Salad", @"Side Dish", @"Soup"],
                         @"Time" : @[@"Any", @"Less than 15 mins", @"Less than 30 mins", @"Less than 45 mins", @"Less than 1 hour", @"Less than 2 hours", @"Less than 3 hours"],
                         @"Holiday" : @[@"Christmas", @"Summer", @"Thanksgiving", @"New Year", @"Super Bowl / Game Day", @"Halloween", @"Hanukkah", @"4th of July"],
                         @"Allergy" : @[@"Dairy", @"Egg", @"Peanut", @"Seafood", @"Sesame", @"Soy", @"Sulfite", @"Tree Nut", @"Wheat", @"Gluten"],
                         @"Diet" : @[@"Low-Calorie", @"Low-Fat", @"Low-Carbohydrate", @"Low-Sodium", @"High-Fiber", @"Vegan", @"Vegetarian", @"Lacto vegetarian", @"Ovo vegetarian", @"Pescetarian"]};
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:@"updateTableContent" object:nil];
    
    _cellStatus = [[NSMutableArray alloc] initWithCapacity:7];
    
    for (int i = 0; i < 7; i++)
    {
        [_cellStatus addObject:@NO];
    }
}

- (void)updateTable
{
    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [[KIAFilterSettings sharedFilterManager] saveSettings];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[_cellStatus objectAtIndex:section] isEqual:@YES])
    {
        switch (section)
        {
            case 0:
                return ceil([[_filtersList objectForKey:@"Cuisine"] count] / 2.0) + 1;
                
                break;
            case 1:
                return ceil([[_filtersList objectForKey:@"Meal"] count] / 2.0) + 1;
                
                break;
            case 2:
                return ceil([[_filtersList objectForKey:@"Dish Type"] count] / 2.0) + 1;
                
                break;
            case 3:
                return ceil([[_filtersList objectForKey:@"Time"] count] / 2.0) + 1;
                
                break;
            case 4:
                return ceil([[_filtersList objectForKey:@"Holiday"] count] / 2.0) + 1;
                
                break;
            case 5:
                return ceil([[_filtersList objectForKey:@"Allergy"] count] / 2.0) + 1;
                
                break;
            case 6:
                return ceil([[_filtersList objectForKey:@"Diet"] count] / 2.0) + 1;
                
                break;
            default:
                return 1;
                
                break;
        }
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell;
    
    switch ([indexPath section])
    {
        case 0:
        {
            if ([indexPath row])
            {
                NSArray *temp = [_filtersList objectForKey:@"Cuisine"];
                
                KIACheckBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkButtonCell"];
                
                [cell setKey:@"Cuisine"];
                
                [[cell leftButton] setTitle:[temp objectAtIndex:[indexPath row] - 1] forState:UIControlStateNormal];
                
                if ([[[KIAFilterSettings sharedFilterManager] cuisine] containsObject:[temp objectAtIndex:[indexPath row] - 1]])
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
                }
                else
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                }
                
                if (ceil([temp count] / 2.0) + [indexPath row] - 1 < [temp count])
                {
                    [[cell rightButton] setTitle:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1] forState:UIControlStateNormal];
                    
                    if ([[[KIAFilterSettings sharedFilterManager] cuisine] containsObject:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1]])
                    {
                        [[(KIACheckBoxTableViewCell *)cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [[cell rightButton] setTitle:@"" forState:UIControlStateNormal];
                    [[cell rightButton] setImage:nil forState:UIControlStateNormal];
                }
                
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                [[cell textLabel] setText:@"Cuisine"];
                
                return cell;
            }
            
            break;
        }
        case 1:
        {
            if ([indexPath row])
            {
                NSArray *temp = [_filtersList objectForKey:@"Meal"];
                
                KIARadioButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioButtonCell"];
                
                [cell setKey:@"Meal"];
                
                [[cell leftButton] setTitle:[temp objectAtIndex:[indexPath row] - 1] forState:UIControlStateNormal];
                
                if ([[[KIAFilterSettings sharedFilterManager] meal] isEqualToString:[temp objectAtIndex:[indexPath row] - 1]])
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_ACTIVE] forState:UIControlStateNormal];
                }
                else
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                }
                
                if (ceil([temp count] / 2.0) + [indexPath row] - 1 < [temp count])
                {
                    [[cell rightButton] setTitle:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1] forState:UIControlStateNormal];
                    
                    if ([[[KIAFilterSettings sharedFilterManager] meal] isEqualToString:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1]])
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_ACTIVE] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [[cell rightButton] setTitle:@"" forState:UIControlStateNormal];
                    [[cell rightButton] setImage:nil forState:UIControlStateNormal];
                }
                
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                [[cell textLabel] setText:@"Meal"];
                return cell;
            }
            
            break;
        }
        case 2:
        {
            if ([indexPath row])
            {
                NSArray *temp = [_filtersList objectForKey:@"Dish Type"];
                
                KIARadioButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioButtonCell"];
                
                [cell setKey:@"Dish Type"];
                
                [[cell leftButton] setTitle:[temp objectAtIndex:[indexPath row] - 1] forState:UIControlStateNormal];
                
                if ([[[KIAFilterSettings sharedFilterManager] dishType] isEqualToString:[temp objectAtIndex:[indexPath row] - 1]])
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_ACTIVE] forState:UIControlStateNormal];
                }
                else
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                }
                
                if (ceil([temp count] / 2.0) + [indexPath row] - 1 < [temp count])
                {
                    [[cell rightButton] setTitle:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1] forState:UIControlStateNormal];
                    
                    if ([[[KIAFilterSettings sharedFilterManager] dishType] isEqualToString:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1]])
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_ACTIVE] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [[cell rightButton] setTitle:@"" forState:UIControlStateNormal];
                    [[cell rightButton] setImage:nil forState:UIControlStateNormal];
                }
                
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                [[cell textLabel] setText:@"Dish Type"];
                return cell;
            }
            
            break;
        }
        case 3:
        {
            if ([indexPath row])
            {
                NSArray *temp = [_filtersList objectForKey:@"Time"];
                
                KIARadioButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioButtonCell"];
                
                [cell setKey:@"Time"];
                
                [[cell leftButton] setTitle:[temp objectAtIndex:[indexPath row] - 1] forState:UIControlStateNormal];
                
                if ([[[KIAFilterSettings sharedFilterManager] time] isEqualToString:[temp objectAtIndex:[indexPath row] - 1]])
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_ACTIVE] forState:UIControlStateNormal];
                }
                else
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                }
                
                if (ceil([temp count] / 2.0) + [indexPath row] - 1 < [temp count])
                {
                    [[cell rightButton] setTitle:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1] forState:UIControlStateNormal];
                    
                    if ([[[KIAFilterSettings sharedFilterManager] time] isEqualToString:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1]])
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_ACTIVE] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:RADIO_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [[cell rightButton] setTitle:@"" forState:UIControlStateNormal];
                    [[cell rightButton] setImage:nil forState:UIControlStateNormal];
                }
                
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                [[cell textLabel] setText:@"Time"];
                return cell;
            }
            
            break;
        }
        case 4:
        {
            if ([indexPath row])
            {
                NSArray *temp = [_filtersList objectForKey:@"Holiday"];
                
                KIACheckBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkButtonCell"];
                
                [cell setKey:@"Holiday"];
                
                [[cell leftButton] setTitle:[temp objectAtIndex:[indexPath row] - 1] forState:UIControlStateNormal];
                
                if ([[[KIAFilterSettings sharedFilterManager] holiday] containsObject:[temp objectAtIndex:[indexPath row] - 1]])
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
                }
                else
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                }
                
                if (ceil([temp count] / 2.0) + [indexPath row] - 1 < [temp count])
                {
                    [[cell rightButton] setTitle:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1] forState:UIControlStateNormal];
                    
                    if ([[[KIAFilterSettings sharedFilterManager] holiday] containsObject:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1]])
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [[cell rightButton] setTitle:@"" forState:UIControlStateNormal];
                    [[cell rightButton] setImage:nil forState:UIControlStateNormal];
                }
                
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                [[cell textLabel] setText:@"Holiday"];
                return cell;
            }
            
            break;
        }
        case 5:
        {
            if ([indexPath row])
            {
                NSArray *temp = [_filtersList objectForKey:@"Allergy"];
                
                KIACheckBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkButtonCell"];
                
                [cell setKey:@"Allergy"];
                
                [[cell leftButton] setTitle:[temp objectAtIndex:[indexPath row] - 1] forState:UIControlStateNormal];
                
                if ([[[KIAFilterSettings sharedFilterManager] allergy] containsObject:[temp objectAtIndex:[indexPath row] - 1]])
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
                }
                else
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                }
                
                if (ceil([temp count] / 2.0) + [indexPath row] - 1 < [temp count])
                {
                    [[cell rightButton] setTitle:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1] forState:UIControlStateNormal];
                    
                    if ([[[KIAFilterSettings sharedFilterManager] allergy] containsObject:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1]])
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [[cell rightButton] setTitle:@"" forState:UIControlStateNormal];
                    [[cell rightButton] setImage:nil forState:UIControlStateNormal];
                }
                
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                [[cell textLabel] setText:@"Allergy"];
                return cell;
            }
            
            break;
        }
        case 6:
        {
            if ([indexPath row])
            {
                NSArray *temp = [_filtersList objectForKey:@"Diet"];
                
                KIACheckBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkButtonCell"];
                
                [cell setKey:@"Diet"];
                
                [[cell leftButton] setTitle:[temp objectAtIndex:[indexPath row] - 1] forState:UIControlStateNormal];
                
                if ([[[KIAFilterSettings sharedFilterManager] diet] containsObject:[temp objectAtIndex:[indexPath row] - 1]])
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
                }
                else
                {
                    [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                }
                
                if (ceil([temp count] / 2.0) + [indexPath row] - 1 < [temp count])
                {
                    [[cell rightButton] setTitle:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1] forState:UIControlStateNormal];
                    
                    if ([[[KIAFilterSettings sharedFilterManager] diet] containsObject:[temp objectAtIndex:ceil([temp count] / 2.0) + [indexPath row] - 1]])
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [[cell rightButton] setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [[cell rightButton] setTitle:@"" forState:UIControlStateNormal];
                    [[cell rightButton] setImage:nil forState:UIControlStateNormal];
                }
                
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                [[cell textLabel] setText:@"Diet"];
                return cell;
            }
            
            break;
        }
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row])
    {
        // TODO: aaaaa
        NSLog(@"aaaaaaaa: %ld", (long)[indexPath section]);
    }
    else
    {
        if ([[_cellStatus objectAtIndex:[indexPath section]] isEqual:@NO])
        {
            [_cellStatus replaceObjectAtIndex:[indexPath section] withObject:@YES];
        }
        else
        {
            [_cellStatus replaceObjectAtIndex:[indexPath section] withObject:@NO];
        }
        
        [tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row])
    {
        return 30;
    }
    else
    {
        return 44;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateTableContent" object:nil];
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
