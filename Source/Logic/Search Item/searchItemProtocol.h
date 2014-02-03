//
//  searchItemProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 1/30/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol searchItemProtocol <baseServerGatewayProtocol>

- (void)searchItemWithText:(NSString *)text categoyId:(NSUInteger)catId storeId:(NSUInteger)storeId delegate:(id<serverGatewayDelegate>)delegate;

@end
