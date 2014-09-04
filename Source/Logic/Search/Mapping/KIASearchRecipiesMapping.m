//
//  KIASearchRecipiesMapping.m
//  KitchInApp
//
//  Created by DeMoN on 8/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIASearchRecipiesMapping.h"

#import "RKObjectMapping.h"

#import "KIARecipiesMapping.h"

@implementation KIASearchRecipiesMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *searchRecipiesMapping = [RKObjectMapping mappingForClass:[KIARecipiesMapping class]];
    
    [searchRecipiesMapping addAttributeMappingsFromDictionary:@{@"Id" : @"_resipiesID", @"Ingredients" : @"Ingredients", @"Kalories" : @"_kalories", @"PhotoUrl" : @"_photoUrl", @"Title" : @"_title", @"TotalTime" : @"_totalTime", @"Rating" : @"_rating"}];
    
    return searchRecipiesMapping;
}

@end
