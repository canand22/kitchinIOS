// ************************************************ //
//                                                  //
//  sendCheckProtocol.h                             //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/11/14.                    //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol sendCheckProtocol<baseServerGatewayProtocol>

- (void)sendCheckWithImage:(UIImage *)image storeID:(NSUInteger)storeID delegate:(id<serverGatewayDelegate>)delegate;

@end
