//
//  KIALogoutMapping.h
//  KitchInApp
//
//  Created by DeMoN on 1/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIALogoutMapping : NSObject

@property(nonatomic, assign) BOOL IsSuccessfully;
@property(nonatomic, strong) NSString *Message;

+ (RKObjectMapping *)mapping;

@end
