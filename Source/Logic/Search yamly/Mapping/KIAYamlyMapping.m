//
//  KIAYamlyMapping.m
//  KitchInApp
//
//  Created by DeMoN on 9/2/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAYamlyMapping.h"

#import "RKObjectMapping.h"

@implementation KIAYamlyMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *yummlyMapping = [RKObjectMapping mappingForClass:[KIAYamlyMapping class]];
    
    [yummlyMapping addAttributeMappingsFromDictionary:@{@"Id" : @"itemId", @"Category" : @"categoryName", @"FullName" : @"name", @"ShortName" : @"shotName", @"YummlyName" : @"yummlyName"}];
    
    return yummlyMapping;
}

@end
