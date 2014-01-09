// ************************************************ //
//                                                  //
//  KIAEditRecognizeItemsViewController.m           //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIAEditRecognizeItemsViewController.h"

@interface KIAEditRecognizeItemsViewController ()

@end

@implementation KIAEditRecognizeItemsViewController

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
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ***** table view *****

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0)
    {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg white first.png"]]];
    }
    else if ([indexPath row] == 19)
    {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg white last.png"]]];
    }
    else
    {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg white.png"]]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([indexPath row] == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
    }
    else if ([indexPath row] == 19)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"lastCell"];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    
    return cell;
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
