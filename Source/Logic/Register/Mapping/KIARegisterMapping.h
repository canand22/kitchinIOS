// ************************************************ //
//                                                  //
//  KIARegister.h                                   //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/9/14.                     //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIARegisterMapping : NSObject

@property(nonatomic, strong) NSString *SessionId;
@property(nonatomic, assign) BOOL IsUserRegistered;

+ (RKObjectMapping *)mapping;

@end
