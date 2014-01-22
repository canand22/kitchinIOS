// ************************************************ //
//                                                  //
//  KIAServerGateway+SendCheck.h                    //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/11/14.                    //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIAServerGateway.h"

#import "sendCheckProtocol.h"

@interface KIAServerGateway (SendCheck)<sendCheckProtocol>

@property(nonatomic, assign) id delegate;

@end
