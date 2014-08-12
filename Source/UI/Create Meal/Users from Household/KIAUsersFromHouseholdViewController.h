//
//  KIAUsersFromHouseholdViewController.h
//  KitchInApp
//
//  Created by DeMoN on 8/5/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KIAUsersFromHouseholdAddCellProtocol.h"
#import "KIAUsersFromHouseholdProtocol.h"

@interface KIAUsersFromHouseholdViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, KIAUsersFromHouseholdAddCellProtocol>
{
    NSMutableArray *_users;
    
    NSMutableArray *_usersCheck;
}

@property(nonatomic, strong) NSArray *currentUsers;
@property(nonatomic, strong) IBOutlet UITableView *table;

@property(nonatomic, weak) id<KIAUsersFromHouseholdProtocol> delegate;

@end
