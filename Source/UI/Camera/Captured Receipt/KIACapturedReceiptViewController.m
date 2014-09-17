// ************************************************ //
//                                                  //
//  KIACapturedReceiptViewController.m              //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIACapturedReceiptViewController.h"

#import "KIAServerGateway.h"

#import "KIAEditRecognizeItemsViewController.h"
#import "KIALoaderView.h"

@interface KIACapturedReceiptViewController ()

@end

@implementation KIACapturedReceiptViewController

@synthesize sendCheckGateway = _sendCheckGateway;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _sendCheckGateway = [KIAServerGateway gateway];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_image setImage:_photo];
    [_titleLabel setText:_titleText];
}

- (void)showData:(NSArray *)itemArray
{
    [[[self view] viewWithTag:1000] removeFromSuperview];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KIAEditRecognizeItemsViewController *editRecognizeItemsViewController = (KIAEditRecognizeItemsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"editRecognizeItemsViewController"];
    [editRecognizeItemsViewController setItemArray:[itemArray mutableCopy]];
    [self presentViewController:editRecognizeItemsViewController animated:YES completion:nil];
}

- (void)nullData
{
    [[[self view] viewWithTag:1000] removeFromSuperview];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Image is not check or does not contain products."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)errorRequestTimedOut
{
    [[[self view] viewWithTag:1000] removeFromSuperview];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry, we didn't recognize the items on your receipt."
                                                    message:@"Please check receipt."
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Try again", @"OK", nil];
    
    [alert setTag:1000];
    
    [alert show];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)send:(id)sender
{
    KIALoaderView *_loader = [[KIALoaderView alloc] initWithFrame:[[self view] bounds]];
    [_loader setTag:1000];
    [[self view] addSubview:_loader];
        
    [_sendCheckGateway sendCheckWithImage:_photo storeID:1 delegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1000)
    {
        if (buttonIndex == 0)
        {
            [self send:nil];
        }
        
        if (buttonIndex == 1)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
