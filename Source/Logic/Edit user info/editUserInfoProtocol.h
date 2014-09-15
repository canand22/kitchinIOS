//
//  editUserInfoProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 9/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol editUserInfoProtocol<baseServerGatewayProtocol>

- (void)changeFirstName:(NSString *)firstName changeLastName:(NSString *)lastName delegate:(id<serverGatewayDelegate>)delegate;

@end
