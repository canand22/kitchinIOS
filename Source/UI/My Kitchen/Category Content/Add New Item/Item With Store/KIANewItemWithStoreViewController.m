//
//  KIANewItemWithStoreViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/27/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIANewItemWithStoreViewController.h"

#import "KIAServerGateway.h"

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
    [_addItemGateway addItemWithCategoryId:2
                            expirationDate:nil
                            ingredientName:nil
                                      name:[_foodType text]
                                 sessionId:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]
                                 shortName:[_itemText text]
                                   storeId:1
                                   upcCode:nil
                                  delegate:self];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)message:(NSString *)msg success:(BOOL)success
{
    if (success)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
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
