//
//  SearchRecipiesProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 8/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol SearchRecipiesProtocol<baseServerGatewayProtocol>

- (void)sendSearchRecipiesForItem:(NSDictionary *)item delegate:(id<serverGatewayDelegate>)delegate;

@end
