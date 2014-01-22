//
//  getCategoryItemProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 1/20/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol getCategoryItemProtocol<baseServerGatewayProtocol>

- (void)getItemWithCategoyId:(NSUInteger)catId storeId:(NSUInteger)storeId delegate:(id<serverGatewayDelegate>)delegate;

@end
