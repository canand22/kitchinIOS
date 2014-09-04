//
//  KIASearchRecipiesTableViewCell.h
//  KitchInApp
//
//  Created by DeMoN on 8/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIASearchRecipiesTableViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIImageView *image;
@property(nonatomic, strong) IBOutlet UILabel *title;
@property(nonatomic, strong) IBOutlet UILabel *countIngridient;
@property(nonatomic, strong) IBOutlet UILabel *kalories;
@property(nonatomic, strong) IBOutlet UIImageView *stars;
@property(nonatomic, strong) IBOutlet UILabel *time;

@end
