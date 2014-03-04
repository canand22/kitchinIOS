//
//  CategoryItemCell.h
//  KitchInApp
//
//  Created by DeMoN on 3/3/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryItemCellProtocol.h"

@interface CategoryItemCell : UITableViewCell

@property(nonatomic, weak) id<CategoryItemCellProtocol> delegate;

@property(nonatomic, strong) IBOutlet UILabel *itemName;
@property(nonatomic, strong) IBOutlet UIButton *removeButton;

@end
