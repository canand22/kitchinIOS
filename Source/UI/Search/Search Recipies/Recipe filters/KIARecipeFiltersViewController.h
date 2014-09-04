//
//  KIARecipeFiltersViewController.h
//  KitchInApp
//
//  Created by DeMoN on 8/20/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIARecipeFiltersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *_filtersList;
    NSMutableArray *_cellStatus;
}

@property(nonatomic, strong) IBOutlet UITableView *table;

@end
