// ************************************************ //
//                                                  //
//  KIAAddReceiptViewController.m                   //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 2/18/13.                    //
//  Copyright (c) 2013 DeMoN. All rights reserved.  //
//                                                  //
// ************************************************ //

#import "KIAAddReceiptViewController.h"

#import "KIATabBarViewController.h"

#import "KIACameraViewController.h"

@interface KIAAddReceiptViewController ()

@end

@implementation KIAAddReceiptViewController

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
    if ([_table respondsToSelector:@selector(setBackgroundView:)])
    {
        [_table setBackgroundView:nil];
    }
}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([indexPath row] == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    }
    
    if ([indexPath row] > 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"2"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIATabBarViewController *tabBarVC = (KIATabBarViewController *)[self tabBarController];
    
    [tabBarVC setSelectedIndex:0];
    [[[tabBarVC viewControllers] objectAtIndex:0] popToRootViewControllerAnimated:NO];
    
    [tabBarVC reloadButtonImageWithIndex:3];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIACameraViewController *cameraViewController = (KIACameraViewController *)[storyboard instantiateViewControllerWithIdentifier:@"cameraViewViewController"];
        [tabBarVC presentViewController:cameraViewController animated:YES completion:nil];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
