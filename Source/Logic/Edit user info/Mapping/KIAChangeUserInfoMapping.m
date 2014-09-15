//
//  KIAChangeUserInfoMapping.m
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAChangeUserInfoMapping.h"

#import "RKObjectMapping.h"

@implementation KIAChangeUserInfoMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *changeUserNameMapping = [RKObjectMapping mappingForClass:[KIAChangeUserInfoMapping class]];
    
    // setup current weather mapping
    [changeUserNameMapping addAttributeMappingsFromDictionary:@{@"FirstName" : @"firstName", @"LastName" : @"lastName", @"NewEmail" : @"email", @"Guid" : @"sessionId"}];
    
    return changeUserNameMapping;
}

@end
