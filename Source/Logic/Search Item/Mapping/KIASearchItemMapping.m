//
//  KIASearchItemMapping.m
//  KitchInApp
//
//  Created by DeMoN on 1/30/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASearchItemMapping.h"

#import "RKObjectMapping.h"

@implementation KIASearchItemMapping

@synthesize category = _category;
@synthesize itemId = _itemId;
@synthesize isSuccessMatching = _isSuccessMatching;
@synthesize itemName = _itemName;
@synthesize itemShortName = _itemShortName;
@synthesize yummlyName = _yummlyName;

+ (RKObjectMapping *)mapping
{
    RKObjectMapping *searchMapping = [RKObjectMapping mappingForClass:[KIASearchItemMapping class]];
    
    [searchMapping addAttributeMappingsFromDictionary:@{@"Category" : @"_category", @"Id" : @"_itemId", @"IsSuccessMatching" : @"_isSuccessMatching", @"ItemName" : @"_itemName", @"ItemShortName" : @"_itemShortName", @"YummlyName" : @"_yummlyName"}];
    
    return searchMapping;
}

@end
