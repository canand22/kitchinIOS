//
//  KIASuccessMapping.m
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASuccessMapping.h"

#import "RKObjectMapping.h"

@implementation KIASuccessMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *successMapping = [RKObjectMapping mappingForClass:[KIASuccessMapping class]];
    
    // setup current weather mapping
    [successMapping addAttributeMappingsFromDictionary:@{@"Success" : @"success"}];
    
    return successMapping;
}

@end
