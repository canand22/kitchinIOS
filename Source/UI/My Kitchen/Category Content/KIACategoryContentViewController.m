// ************************************************ //
//                                                  //
//  KIACategoryContentViewController.m              //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIACategoryContentViewController.h"

@interface KIACategoryContentViewController ()

@end

@implementation KIACategoryContentViewController

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
    [_categoryTitle setText:_categoryName];
    [_categoryImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_category.png", _categoryName]]];
}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    return cell;
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
