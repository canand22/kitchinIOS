//
//  KIALogoutMapping.m
//  KitchInApp
//
//  Created by DeMoN on 1/21/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIALogoutMapping.h"

#import "RKObjectMapping.h"

@implementation KIALogoutMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *forgotMapping = [RKObjectMapping mappingForClass:[KIALogoutMapping class]];
    
    return forgotMapping;
}

@end
