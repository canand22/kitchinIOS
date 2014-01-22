//
//  KIALoaderView.m
//  KitchInApp
//
//  Created by DeMoN on 1/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIALoaderView.h"

@interface KIALoaderView ()

@end

@implementation KIALoaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        _imageNumber = 1;
        
        _image = [[UIImageView alloc] initWithFrame:[self frame]];
        [self addSubview:_image];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.04f target:self selector:@selector(tick) userInfo:nil repeats:YES];
    }
    
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)tick
{
    [_image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%lu.png", (unsigned long)_imageNumber]]];
    
    if (_imageNumber == 32)
    {
        _imageNumber = 1;
    }
    else
    {
        _imageNumber++;
    }
}

- (void)dealloc
{
    if ([_timer isValid])
    {
        [_timer invalidate];
    }
    
    _timer = nil;
}

@end
