//
//  KIAMealSettingsViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAMealSettingsViewController.h"

#import "KIAUpdater.h"
#import "KIAUser.h"

#define BUTTON_TAG 100
#define CHECK_BUTTON_ACTIVE @"ceckbox_active.png"
#define CHECK_BUTTON_DEACTIVE @"ceckbox.png"

@interface KIAMealSettingsViewController ()

@end

@implementation KIAMealSettingsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if ([_user dietaryRestrictions])
    {
        _avaibleItem = [[NSMutableArray alloc] initWithArray:[_user dietaryRestrictions]];
        
        [self updateCheckBoxButton];
    }
    else
    {
        _avaibleItem = [[NSMutableArray alloc] init];
    }
}

- (void)updateCheckBoxButton
{
    for (int i = 0; i < [_avaibleItem count]; i++)
    {
        NSInteger tag = [[_avaibleItem objectAtIndex:i] integerValue] + BUTTON_TAG;
        
        [(UIButton *)[[self view] viewWithTag:tag] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
        [(UIButton *)[[self view] viewWithTag:tag] setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateHighlighted];
    }
}

- (IBAction)checkButtonAction:(UIButton *)sender
{
    if ([_avaibleItem containsObject:[NSNumber numberWithInt:(int)[sender tag] - BUTTON_TAG]])
    {
        [_avaibleItem removeObject:[NSNumber numberWithInt:(int)[sender tag] - BUTTON_TAG]];
        
        [sender setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:CHECK_BUTTON_DEACTIVE] forState:UIControlStateHighlighted];
    }
    else
    {
        [_avaibleItem addObject:[NSNumber numberWithInt:(int)[sender tag] - BUTTON_TAG]];
        
        [sender setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:CHECK_BUTTON_ACTIVE] forState:UIControlStateHighlighted];
    }
}

- (IBAction)back:(id)sender
{
    [_user setDietaryRestrictions:_avaibleItem];
    
    [[KIAUpdater sharedUpdater] updateUsersInfo:_user];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
