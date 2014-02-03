//
//  addNewItemProtocol.h
//  KitchInApp
//
//  Created by DeMoN on 1/29/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol addNewItemProtocol<baseServerGatewayProtocol>

- (void)addItemWithCategoryId:(NSInteger)catId expirationDate:(NSInteger)expDate ingredientName:(NSString *)ingrName name:(NSString *)name sessionId:(NSString *)sessionId shortName:(NSString *)shortName storeId:(NSInteger)storeId upcCode:(NSString *)upcCode delegate:(id<serverGatewayDelegate>)delegate;

@end
