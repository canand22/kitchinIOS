//
//  KIASelectItemsViewController.h
//  KitchInApp
//
//  Created by DeMoN on 8/18/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KIAUsersFromHouseholdAddCellProtocol.h"
#import "KIASelectedItemsProtocol.h"

@interface KIASelectItemsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, KIAUsersFromHouseholdAddCellProtocol>
{
    NSArray *_categoryItems;
    
    NSMutableArray *_categoryItemsCheck;
}

@property(nonatomic, strong) NSString *categoryName;

@property(nonatomic, strong) IBOutlet UITableView *table;

@property(nonatomic, weak) id<KIASelectedItemsProtocol> delegate;

@end
