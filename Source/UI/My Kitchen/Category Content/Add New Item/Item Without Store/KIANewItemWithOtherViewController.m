//
//  KIANewItemWithOtherViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/27/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIANewItemWithOtherViewController.h"

@interface KIANewItemWithOtherViewController ()

@end

@implementation KIANewItemWithOtherViewController

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

- (IBAction)submit:(id)sender
{
    
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
