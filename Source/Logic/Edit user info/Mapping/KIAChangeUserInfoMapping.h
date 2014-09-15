//
//  KIAChangeUserInfoMapping.h
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAChangeUserInfoMapping : NSObject

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *sessionId;

+ (RKObjectMapping *)mapping;

@end
