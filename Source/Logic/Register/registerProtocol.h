// ************************************************ //
//                                                  //
//  registerProtocol.h                              //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/9/14.                     //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol registerProtocol<baseServerGatewayProtocol>

- (void)registerUser:(NSString *)username withPassword:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName delegate:(id<serverGatewayDelegate>)delegate;

@end
