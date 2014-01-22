//
//  KIAImageMapping.m
//  KitchInApp
//
//  Created by DeMoN on 1/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAImageMapping.h"

#import "RKObjectMapping.h"

@implementation KIAImageMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[KIAImageMapping class]];
    
    // setup current weather mapping
    [imageMapping addAttributeMappingsFromDictionary:@{@"ImageAsBase64String" : @"ImageAsBase64String", @"StoreId" : @"StoreId"}];
    
    return imageMapping;
}

@end
