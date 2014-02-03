//
//  KIAAddItemResultMapping.m
//  KitchInApp
//
//  Created by DeMoN on 1/30/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAAddItemResultMapping.h"

#import "RKObjectMapping.h"

@implementation KIAAddItemResultMapping

@synthesize isSuccessfully = _isSuccessfully;
@synthesize message = _message;

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *addResultMapping = [RKObjectMapping mappingForClass:[KIAAddItemResultMapping class]];
    
    // setup current weather mapping
    [addResultMapping addAttributeMappingsFromDictionary:@{@"IsSuccessfully" : @"_isSuccessfully", @"Message" : @"_message"}];
    
    return addResultMapping;
}

@end
