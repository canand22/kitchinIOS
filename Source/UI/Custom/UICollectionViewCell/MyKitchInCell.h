// ************************************************ //
//                                                  //
//  MyKitchInCell.h                                 //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/23/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

@interface MyKitchInCell : UICollectionViewCell

@property(nonatomic, strong) IBOutlet UIImageView *image;
@property(nonatomic, strong) IBOutlet UILabel *title;

@property(nonatomic, strong) IBOutlet UIImageView *circle;
@property(nonatomic, strong) IBOutlet UILabel *circleText;

@property(nonatomic, strong) IBOutlet UIButton *deleteButton;

@end
