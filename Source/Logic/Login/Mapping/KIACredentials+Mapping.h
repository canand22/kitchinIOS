// ************************************************ //
//                                                  //
//  KIACredentialsMapping.h                         //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/6/14.                     //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>

#import "KIACredentials.h"

@class RKObjectMapping;

@interface KIACredentials (Mapping)

+ (RKObjectMapping *)mapping;

@end
