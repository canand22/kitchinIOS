//
//  recipiesProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 8/19/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "baseServerGatewayProtocol.h"

@protocol recipiesProtocol<baseServerGatewayProtocol>

- (void)sendRecipiesWithId:(NSString *)recipiesId delegate:(id<serverGatewayDelegate>)delegate;

@end
