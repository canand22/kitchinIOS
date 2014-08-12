//
//  KIASearchRecipiesMapping.m
//  KitchInApp
//
//  Created by DeMoN on 8/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASearchRecipiesMapping.h"

#import "RKObjectMapping.h"

@implementation KIASearchRecipiesMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *searchRecipiesMapping = [RKObjectMapping mappingForClass:[KIASearchRecipiesMapping class]];
    
    [searchRecipiesMapping addAttributeMappingsFromDictionary:@{@"Id" : @"ResipiesID", @"Title" : @"Title", @"PhotoUrl" : @"PhotoUrl", @"TotalTime" : @"TotalTime", @"Kalories" : @"Kalories", @"Ingredients" : @"Ingredients"}];
    
    return searchRecipiesMapping;
}

@end
