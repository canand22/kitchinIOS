//
//  yamlyProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 9/2/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "baseServerGatewayProtocol.h"

@protocol yamlyProtocol<baseServerGatewayProtocol>

- (void)searchWithString:(NSString *)yamlyString delegate:(id<serverGatewayDelegate>)delegate;

@end
