//
//  KIAAddItemMapping.m
//  KitchInApp
//
//  Created by DeMoN on 1/29/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAAddItemMapping.h"

#import "RKObjectMapping.h"

@implementation KIAAddItemMapping

@synthesize categoryId = _categoryId;
@synthesize expirationDate = _expirationDate;
@synthesize ingredientName = _ingredientName;
@synthesize name = _name;
@synthesize sessionId = _sessionId;
@synthesize shortName = _shortName;
@synthesize storeId = _storeId;
@synthesize upcCode = _upcCode;

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *addMapping = [RKObjectMapping mappingForClass:[KIAAddItemMapping class]];
    
    // setup current weather mapping
    [addMapping addAttributeMappingsFromDictionary:@{@"SessionId" : @"_sessionId", @"StoreId" : @"_storeId"}];
    
    return addMapping;
}

@end
