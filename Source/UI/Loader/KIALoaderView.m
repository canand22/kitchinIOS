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
        
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7f]];
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake([self frame].size.width / 2 - 14, [self frame].size.height / 2 - 25, 28, 50)];
        [self addSubview:_image];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, ([self frame].size.height / 2 - 25) / 2, 320, 20)];
        [_title setTextColor:[UIColor whiteColor]];
        [_title setTextAlignment:NSTextAlignmentCenter];
        [_title setFont:[UIFont systemFontOfSize:17.0f]];
        [_title setShadowColor:[UIColor darkGrayColor]];
        [_title setShadowOffset:CGSizeMake(1.0f, 1.0f)];
        [self addSubview:_title];
        
        _subtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, ([self frame].size.height / 2 - 25) / 2 + 20, 320, 20)];
        [_subtitle setTextColor:[UIColor whiteColor]];
        [_subtitle setTextAlignment:NSTextAlignmentCenter];
        [_subtitle setFont:[UIFont systemFontOfSize:14.0f]];
        [_subtitle setShadowColor:[UIColor darkGrayColor]];
        [_subtitle setShadowOffset:CGSizeMake(1.0f, 1.0f)];
        [self addSubview:_subtitle];
        
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
