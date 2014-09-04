//
//  KIAFavoriteViewController.h
//  KitchInApp
//
//  Created by DeMoN on 8/8/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIAFavoriteViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_favoriteRecipe;
    
    NSInteger _selectedItem;
}

@property(nonatomic, strong) IBOutlet UITableView *table;

@end
