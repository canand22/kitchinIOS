//
//  KIACredentials.h
//  KitchInApp
//
//  Created by DeMoN on 1/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIACredentials : NSObject
{
    NSString *_email;
    NSString *_password;
}

@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *password;

+ (RKObjectMapping *)mapping;

@end
