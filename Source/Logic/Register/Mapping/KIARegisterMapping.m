// ************************************************ //
//                                                  //
//  KIARegister.m                                   //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/9/14.                     //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIARegisterMapping.h"

#import "RKObjectMapping.h"

@implementation KIARegisterMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *registerMapping = [RKObjectMapping mappingForClass:[KIARegisterMapping class]];
    
    // setup current weather mapping
    [registerMapping addAttributeMappingsFromDictionary:@{@"SessionId" : @"SessionId", @"IsUserRegistered" : @"IsUserRegistered"}];
    
    return registerMapping;
}

@end
