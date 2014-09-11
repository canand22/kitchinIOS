//
//  KIARemoveIngredientsViewController.h
//  KitchInApp
//
//  Created by DeMoN on 9/4/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KIARemoveProtocol.h"

@interface KIARemoveIngredientsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, KIARemoveProtocol>
{
    NSMutableArray *_removeArray;
    NSMutableArray *_ingredientsInMyKitchIn;
}

@property(nonatomic, strong) IBOutlet UITableView *table;

@property(nonatomic, strong) NSMutableArray *receptIngredient;

@property(nonatomic, strong) IBOutlet UIButton *skip;

@end
