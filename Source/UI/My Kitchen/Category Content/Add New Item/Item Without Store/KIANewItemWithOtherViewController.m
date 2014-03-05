//
//  KIANewItemWithOtherViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/27/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIANewItemWithOtherViewController.h"

#import "KIAUpdater.h"

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
    [[KIAUpdater sharedUpdater] addItemFromKitchInWihtId:-1
                                                    name:[_foodType text]
                                              categoryId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:_categoryName]
                                               shortName:nil
                                                   count:1
                                                   value:nil];
    
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
