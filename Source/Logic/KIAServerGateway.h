// ************************************************ //
//                                                  //
//  KIAServerGateway.h                              //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/26/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>

#import "baseServerGatewayProtocol.h"
#import "serverGatewayDelegate.h"

#define BASE_URL       @"http://54.68.198.17:3128"
#define DEFAULT_HEADER @"Accept"

@class RKObjectManager;

@interface KIAServerGateway : NSObject<baseServerGatewayProtocol>

@property(nonatomic, strong) RKObjectManager *objectManager;

@end
