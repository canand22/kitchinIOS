//
//  logoutProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 1/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol logoutProtocol<baseServerGatewayProtocol>

- (void)logoutWithDelegate:(id<serverGatewayDelegate>)delegate;

@end
