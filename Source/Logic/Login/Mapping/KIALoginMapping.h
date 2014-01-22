// ************************************************ //
//                                                  //
//  KIALoginMapping.h                               //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/27/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIALoginMapping : NSObject

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *SessionId;
@property(nonatomic, assign) BOOL Success;

+ (RKObjectMapping *)mapping;

@end
