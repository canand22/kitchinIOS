// ************************************************ //
//                                                  //
//  KIALoginMapping.m                               //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/27/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIALoginMapping.h"

#import "RKObjectMapping.h"

@implementation KIALoginMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *loginMapping = [RKObjectMapping mappingForClass:[KIALoginMapping class]];
    
    // setup current weather mapping
    [loginMapping addAttributeMappingsFromDictionary:@{@"SessionId" : @"SessionId", @"Success" : @"Success"}];
    
    return loginMapping;
}

@end
