//
//  KIALoaderView.h
//  KitchInApp
//
//  Created by DeMoN on 1/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIALoaderView : UIView
{
    NSTimer *_timer;
    NSUInteger _imageNumber;
}

@property(nonatomic, strong) UIImageView *image;

@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *subtitle;

@end
