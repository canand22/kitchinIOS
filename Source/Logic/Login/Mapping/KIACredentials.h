//
//  KIACredentials.h
//  KitchInApp
//
//  Created by DeMoN on 1/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIACredentials : NSObject
{
    NSString *_email;
    NSString *_password;
}

@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *password;

@end
