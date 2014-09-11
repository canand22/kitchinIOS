//
//  KIAMissingIngredientsViewController.h
//  KitchInApp
//
//  Created by DeMoN on 9/11/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIAMissingIngredientsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_addArray;
    NSMutableArray *_ingredientsMissingInMyKitchIn;
}

@property(nonatomic, strong) IBOutlet UITableView *table;

@property(nonatomic, strong) NSMutableArray *receptIngredient;

@end
