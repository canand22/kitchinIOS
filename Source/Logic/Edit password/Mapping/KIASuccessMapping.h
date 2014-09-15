//
//  KIASuccessMapping.h
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIASuccessMapping : NSObject

@property(nonatomic, assign) BOOL success;

+ (RKObjectMapping *)mapping;

@end
