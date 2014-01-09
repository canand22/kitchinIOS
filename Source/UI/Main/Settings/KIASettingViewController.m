// ************************************************ //
//                                                  //
//  KIASettingViewController.m                      //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/23/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIASettingViewController.h"

#define BUTTON_TAG 100
#define VIEW_TAG   200

@interface KIASettingViewController ()

@end

@implementation KIASettingViewController

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
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)myAccount:(id)sender
{
    for (int i = 0; i < 4; i++)
    {
        if ([sender tag] != BUTTON_TAG + i)
        {
            [(UIButton *)[[self view] viewWithTag:BUTTON_TAG + i] setBackgroundImage:[UIImage imageNamed:@"top_menu_button.png"]
                                                                            forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:0.0f];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"top_menu_button_active.png"] forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:1.0f];
        }
    }
}

- (IBAction)notifications:(id)sender
{
    for (int i = 0; i < 4; i++)
    {
        if ([sender tag] != BUTTON_TAG + i)
        {
            [(UIButton *)[[self view] viewWithTag:BUTTON_TAG + i] setBackgroundImage:[UIImage imageNamed:@"top_menu_button.png"]
                                                                            forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:0.0f];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"top_menu_button_active.png"] forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:1.0f];
        }
    }
}

- (IBAction)mealSetting:(id)sender
{
    for (int i = 0; i < 4; i++)
    {
        if ([sender tag] != BUTTON_TAG + i)
        {
            [(UIButton *)[[self view] viewWithTag:BUTTON_TAG + i] setBackgroundImage:[UIImage imageNamed:@"top_menu_button.png"]
                                                                            forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:0.0f];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"top_menu_button_active.png"] forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:1.0f];
        }
    }
}

- (IBAction)help:(id)sender
{
    for (int i = 0; i < 4; i++)
    {
        if ([sender tag] != BUTTON_TAG + i)
        {
            [(UIButton *)[[self view] viewWithTag:BUTTON_TAG + i] setBackgroundImage:[UIImage imageNamed:@"top_menu_button.png"]
                                                                            forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:0.0f];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"top_menu_button_active.png"] forState:UIControlStateNormal];
            
            [[[self view] viewWithTag:VIEW_TAG + i] setAlpha:1.0f];
        }
    }
}

#pragma mark ***** My Account Setting *****

- (IBAction)changeUserName:(id)sender
{
    // a
}

- (IBAction)changePassword:(id)sender
{
    // b
}

- (IBAction)facebookClick:(id)sender
{
    // c
}

- (IBAction)twitterClick:(id)sender
{
    // d
}

- (IBAction)pinterestClick:(id)sender
{
    // e
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
