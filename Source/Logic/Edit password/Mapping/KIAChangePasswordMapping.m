//
//  KIAChangePasswordMapping.m
//  KitchInApp
//
//  Created by DeMoN on 9/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAChangePasswordMapping.h"

#import "RKObjectMapping.h"

@implementation KIAChangePasswordMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *changePasswordMapping = [RKObjectMapping mappingForClass:[KIAChangePasswordMapping class]];
    
    // setup current weather mapping
    [changePasswordMapping addAttributeMappingsFromDictionary:@{@"NewPassword" : @"password", @"OldPassword" : @"oldPassword", @"Guid" : @"sessionId"}];
    
    return changePasswordMapping;
}

@end
