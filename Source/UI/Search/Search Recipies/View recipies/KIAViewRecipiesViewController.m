//
//  KIAViewRecipiesViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/20/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAViewRecipiesViewController.h"

#import "KIAServerGateway.h"
#import "KIAFullRecipiesMapping.h"
#import "KIAUpdater.h"

#import "KIACacheManager.h"

#import "KIARecipeInstructionsViewController.h"

@interface KIAViewRecipiesViewController ()

@end

@implementation KIAViewRecipiesViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _recipeGateway = [KIAServerGateway gateway];
        
        _tableHeight = .0f;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [_recipeGateway sendRecipiesWithId:_recipiesIdentification delegate:self];
}

- (void)showData:(NSArray *)itemArray
{
    _recipe = [itemArray objectAtIndex:0];
    
    [_recipeName setText:[_recipe RecipeName]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSURL *url = [NSURL URLWithString:[_recipe Picture]];
        NSData *temp = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [_recipeImage setImage:[UIImage imageWithData:temp]];
        });
    });
    
    [_stars setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-star.png", [_recipe Rating]]]];
    
    [_numberServed setText:[NSString stringWithFormat:@"Number served: %d", [_recipe Served]]];
    [_totalTime setText:[NSString stringWithFormat:@"Total time: %@", ([_recipe Time] > 0 ? ([_recipe Time] / 3600 > 0 ? [NSString stringWithFormat:@"%d hr %d min", [_recipe Time] / 3600, [_recipe Time] / 60] : [NSString stringWithFormat:@"%d min", [_recipe Time] / 60]) : @"N/A")]];
    
    [_table reloadData];
    
    CGRect frame = [_table frame];
    frame.size.height = _tableHeight + 80;
    [_table setFrame:frame];
    
    [_scroll setContentSize:CGSizeMake(320, frame.origin.y + _tableHeight + 145)];
    
    frame = [_buttonPanel frame];
    frame.origin.y = [_table frame].origin.y + [_table frame].size.height + 15;
    [_buttonPanel setFrame:frame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)favorite:(id)sender
{
    [[KIAUpdater sharedUpdater] addFavoriteWithId:_recipiesIdentification
                                             name:[_recipe RecipeName]
                                              url:[_recipe RecipeUrl]
                                           rating:[_recipe Rating]
                                           served:[_recipe Served]
                                             time:[_recipe Time]
                                             icon:[_recipe Picture]
                                      ingredients:[_recipe Ingredients]];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return [[_recipe Ingredients] count];
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 25)];
            [label setFont:[UIFont systemFontOfSize:15.0f]];
            [label setTextColor:[UIColor colorWithRed:229.0f / 255.0f green:99.0f / 255.0f blue:59.0f / 255.0f alpha:1.0f]];
            [label setText:@"Ingredients:"];
            return label;
            
            break;
        }
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont systemFontOfSize:13.0f];
    CGRect rect;
    
    switch ([indexPath section])
    {
        case 0:
            rect = [[[_recipe Ingredients] objectAtIndex:[indexPath row]] boundingRectWithSize:CGSizeMake(300, MAXFLOAT)
                                                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                                                    attributes:@{NSFontAttributeName : font}
                                                                                       context:nil];
            break;
        default:
            break;
    }
    
    CGFloat height = ceil(rect.size.height / font.lineHeight) * 16;
    
    _tableHeight += height;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    switch ([indexPath section])
    {
        case 0:
        {
            [[cell textLabel] setText:[NSString stringWithFormat:@"• %@", [[_recipe Ingredients] objectAtIndex:[indexPath row]]]];
            
            if ([[KIAUpdater sharedUpdater] whetherThereIsAnIngredient:[[_recipe Ingredients] objectAtIndex:[indexPath row]]])
            {
                //[cell setAccessoryView:[UIImage imageNamed:@""]];
            }
            else
            {
                //[cell setAccessoryView:[UIImage imageNamed:@""]];
            }
            
            break;
        }
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"recipeInstructionVC"])
    {
        KIARecipeInstructionsViewController *viewController = (KIARecipeInstructionsViewController *)[segue destinationViewController];
        [viewController setUrl:[_recipe RecipeUrl]];
        [viewController setReceptIngredient:[[_recipe Ingredients] mutableCopy]];
    }
}

@end
