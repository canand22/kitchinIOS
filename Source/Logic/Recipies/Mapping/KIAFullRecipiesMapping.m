//
//  KIAFullRecipiesMapping.m
//  KitchInApp
//
//  Created by DeMoN on 8/19/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAFullRecipiesMapping.h"

#import "RKObjectMapping.h"

@implementation KIAFullRecipiesMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *recipeMapping = [RKObjectMapping mappingForClass:[KIAFullRecipiesMapping class]];
    
    [recipeMapping addAttributeMappingsFromDictionary:@{@"Ingredients" : @"_Ingredients", @"Nutritions" : @"_Nutritions", @"Picture" : @"_Picture", @"Rating" : @"_Rating", @"RecipeName" : @"_RecipeName", @"RecipeUrl" : @"_RecipeUrl", @"Served" : @"_Served", @"Time" : @"_Time"}];
    
    return recipeMapping;
}

@end
