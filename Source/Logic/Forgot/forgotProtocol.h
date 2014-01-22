//
//  forgotProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 1/9/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol forgotProtocol<baseServerGatewayProtocol>

- (void)forgotPasswordWithEmail:(NSString *)email delegate:(id<serverGatewayDelegate>)delegate;

@end
