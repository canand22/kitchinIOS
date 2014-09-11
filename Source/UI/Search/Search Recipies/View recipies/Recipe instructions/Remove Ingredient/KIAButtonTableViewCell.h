//
//  KIAButtonTableViewCell.h
//  KitchInApp
//
//  Created by DeMoN on 9/4/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KIARemoveProtocol.h"

@interface KIAButtonTableViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIButton *removeBtn;

@property(nonatomic, weak) id<KIARemoveProtocol> delegate;

@end
