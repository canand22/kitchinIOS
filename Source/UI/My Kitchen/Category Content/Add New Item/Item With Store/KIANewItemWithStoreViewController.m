//
//  KIANewItemWithStoreViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/27/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIANewItemWithStoreViewController.h"

#import "KIAEditRecognizeItemsViewController.h"

#import "KIASendCheckMapping.h"

#import "KIAServerGateway.h"
#import "KIAUpdater.h"

@interface KIANewItemWithStoreViewController ()

@end

@implementation KIANewItemWithStoreViewController

@synthesize addItemGateway = _addItemGateway;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _addItemGateway = [KIAServerGateway gateway];
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
    [_addItemGateway addItemWithCategoryId:[[KIAUpdater sharedUpdater] idCategoryFromCategoryName:_categoryName]
                            expirationDate:0
                            ingredientName:nil
                                      name:[_foodType text]
                                 sessionId:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]
                                 shortName:[_itemText text]
                                   storeId:1
                                   upcCode:nil
                                  delegate:self];
    
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
                [(KIASendCheckMapping *)[[editVC itemArray] objectAtIndex:i] setItemShortName:[_itemText text]];
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
                                                   shortName:[_itemText text]
                                                       count:1
                                                       value:nil
                                                      yummly:[_foodType text]];
    }
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)message:(NSString *)msg success:(BOOL)success
{
    if (success)
    {
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
