//
//  KIAAutorization.h
//  KitchInApp
//
//  Created by DeMoN on 1/14/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAAutorization : NSObject
{
    NSString *_firstName;
    NSString *_lastName;
    NSString *_email;
    NSString *_password;
}

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *password;

+ (RKObjectMapping *)mapping;

@end
