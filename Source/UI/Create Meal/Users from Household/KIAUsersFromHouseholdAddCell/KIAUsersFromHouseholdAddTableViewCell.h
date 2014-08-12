//
//  KIAUsersFromHouseholdAddTableViewCell.h
//  KitchInApp
//
//  Created by DeMoN on 8/11/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KIAUsersFromHouseholdAddCellProtocol.h"

@interface KIAUsersFromHouseholdAddTableViewCell : UITableViewCell

@property(nonatomic, weak) id<KIAUsersFromHouseholdAddCellProtocol> delegate;

@end
