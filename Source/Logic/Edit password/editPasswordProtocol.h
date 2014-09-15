//
//  editPasswordProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 9/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol editPasswordProtocol<baseServerGatewayProtocol>

- (void)newPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword delegate:(id<serverGatewayDelegate>)delegate;

@end
