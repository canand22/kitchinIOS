// ************************************************ //
//                                                  //
//  serverGatewayDelegate.h                         //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/27/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>

@protocol serverGatewayDelegate<NSObject>

@optional
- (void)showData:(NSArray *)itemArray;
- (void)showDic:(NSDictionary *)itemDic;
- (void)nullData;
- (void)errorRequestTimedOut;
- (void)loginSuccess:(BOOL)success;
- (void)forgotSuccess:(BOOL)success;
- (void)message:(NSString *)msg success:(BOOL)success;

@end
