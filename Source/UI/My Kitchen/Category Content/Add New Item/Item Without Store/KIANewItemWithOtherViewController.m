//
//  KIANewItemWithOtherViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/27/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIANewItemWithOtherViewController.h"

#import "KIAEditRecognizeItemsViewController.h"

#import "KIASendCheckMapping.h"

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
    if (_isRecognition)
    {
        KIAEditRecognizeItemsViewController *editVC = (KIAEditRecognizeItemsViewController *)[[[self presentingViewController] presentingViewController] presentingViewController];
        
        for (int i = 0; i < [[editVC itemArray] count]; i++)
        {
            if (![(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] IsSuccessMatching])
            {
                [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setId:-1];
                [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setItemName:[_foodType text]];
                [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setCategory:_categoryName];
                [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setItemShortName:nil];
                [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setYummlyName:[_foodType text]];
                [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setIsSuccessMatching:YES];
                
                break;
            }
        }
        
        [editVC dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [[KIAUpdater sharedUpdater] addItemFromKitchInWihtId:-1
                                                        name:[_foodType text]
                                                  categoryId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:_categoryName]
                                                   shortName:nil
                                                       count:1
                                                       value:nil
                                                      yummly:[_foodType text]];
    
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
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
