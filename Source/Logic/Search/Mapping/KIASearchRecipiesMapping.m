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

@synthesize TotalCount = _totalCount;
@synthesize Recipes = _recipes;

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *searchRecipiesMapping = [RKObjectMapping mappingForClass:[KIASearchRecipiesMapping class]];
    
    [searchRecipiesMapping addAttributeMappingsFromDictionary:@{@"Recipes" : @"_recipes", @"TotalCount" : @"_totalCount"}];
    
    // [searchRecipiesMapping addAttributeMappingsFromDictionary:@{@"Id" : @"_resipiesID", @"Ingredients" : @"Ingredients", @"Kalories" : @"_kalories", @"PhotoUrl" : @"_photoUrl", @"Title" : @"_title", @"TotalTime" : @"_totalTime", @"Rating" : @"_rating"}];
    
    return searchRecipiesMapping;
}

@end
