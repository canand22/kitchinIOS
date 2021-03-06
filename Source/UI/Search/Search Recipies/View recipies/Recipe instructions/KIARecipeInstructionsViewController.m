//
//  KIARecipeInstructionsViewController.m
//  KitchInApp
//
//  Created by DeMoN on 8/26/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIARecipeInstructionsViewController.h"

#import "KIATabBarViewController.h"

#import "KIARemoveIngredientsViewController.h"

#import "KIAUpdater.h"

@interface KIARecipeInstructionsViewController ()

@end

@implementation KIARecipeInstructionsViewController

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
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_web loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)compleateAction:(id)sender
{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:_receptIngredient];
    
    for (int i = 0; i < [_receptIngredient count]; i++)
    {
        if (![[KIAUpdater sharedUpdater] whetherThereIsAnIngredient:[[_receptIngredient objectAtIndex:i] objectForKey:@"name"]])
        {
            [temp removeObject:[_receptIngredient objectAtIndex:i]];
        }
    }
    
    if ([temp count])
    {
        [self performSegueWithIdentifier:@"removeIdentifier" sender:self];
    }
    else
    {
        KIATabBarViewController *tabBarVC = (KIATabBarViewController *)[self tabBarController];
        
        [tabBarVC setSelectedIndex:1];
        [[[tabBarVC viewControllers] objectAtIndex:1] popToRootViewControllerAnimated:NO];
        
        [tabBarVC reloadButtonImageWithIndex:2];
    }
}

#pragma mark ***** web view *****

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
    
    /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load error!!!"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show]; */
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"removeIdentifier"])
    {
        KIARemoveIngredientsViewController *viewController = (KIARemoveIngredientsViewController *)[segue destinationViewController];
        [viewController setReceptIngredient:_receptIngredient];
    }
}

@end
