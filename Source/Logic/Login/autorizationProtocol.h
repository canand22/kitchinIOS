// ************************************************ //
//                                                  //
//  autorizationProtocol.h                          //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 10/18/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>
#import "baseServerGatewayProtocol.h"

@protocol autorizationProtocol<baseServerGatewayProtocol>

- (void)loginUser:(NSString *)username withPassword:(NSString *)password delegate:(id<serverGatewayDelegate>)delegate;

@end
