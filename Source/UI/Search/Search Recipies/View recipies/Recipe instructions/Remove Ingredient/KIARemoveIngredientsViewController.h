//
//  KIARemoveIngredientsViewController.h
//  KitchInApp
//
//  Created by DeMoN on 9/4/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIARemoveIngredientsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_removeArray;
}

@property(nonatomic, strong) IBOutlet UITableView *table;

@property(nonatomic, strong) NSMutableArray *receptIngredient;

@end
