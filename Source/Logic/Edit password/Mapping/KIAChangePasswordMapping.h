//
//  KIAChangePasswordMapping.h
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAChangePasswordMapping : NSObject

@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *oldPassword;
@property(nonatomic, strong) NSString *sessionId;

+ (RKObjectMapping *)mapping;

@end
