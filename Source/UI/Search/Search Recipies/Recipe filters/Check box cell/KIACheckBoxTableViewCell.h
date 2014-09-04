//
//  KIACheckBoxTableViewCell.h
//  KitchInApp
//
//  Created by DeMoN on 8/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIACheckBoxTableViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIButton *leftButton;
@property(nonatomic, strong) IBOutlet UIButton *rightButton;

@property(nonatomic, strong) NSString *key;

@end
