//
//  KIAForgotMapping.h
//  KitchInApp
//
//  Created by DeMoN on 1/9/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAForgotMapping : NSObject

@property(nonatomic, assign) BOOL IsUserRegistered;

+ (RKObjectMapping *)mapping;

@end
