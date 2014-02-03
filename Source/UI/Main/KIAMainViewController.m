// ************************************************ //
//                                                  //
//  KIAMainViewController.m                         //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 2/12/13.                    //
//  Copyright (c) 2013 DeMoN. All rights reserved.  //
//                                                  //
// ************************************************ //

#import "KIAMainViewController.h"

#import "KIACategory.h"

@interface KIAMainViewController ()

@end

@implementation KIAMainViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    
    [_fio setText:(name ? [NSString stringWithFormat:@"Hi, %@!", name] : @"")];
}

- (IBAction)myKitchin:(id)sender
{
    [[self tabBarController] setSelectedIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
