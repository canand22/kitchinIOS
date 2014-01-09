//
//  KIAForgotMapping.m
//  KitchInApp
//
//  Created by DeMoN on 1/9/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAForgotMapping.h"

#import "RKObjectMapping.h"

@implementation KIAForgotMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *forgotMapping = [RKObjectMapping mappingForClass:[KIAForgotMapping class]];
    
    // setup current weather mapping
    [forgotMapping addAttributeMappingsFromDictionary:@{@"IsUserRegistered" : @"IsUserRegistered"}];
    
    return forgotMapping;
}

@end
