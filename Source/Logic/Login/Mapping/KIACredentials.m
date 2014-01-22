//
//  KIACredentials.m
//  KitchInApp
//
//  Created by DeMoN on 1/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIACredentials.h"

#import "RKObjectMapping.h"

@implementation KIACredentials

@synthesize email = _email;
@synthesize password = _password;

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *credentialsMapping = [RKObjectMapping mappingForClass:[KIACredentials class]];
    
    // setup current weather mapping
    [credentialsMapping addAttributeMappingsFromDictionary:@{@"Email" : @"_email", @"Password" : @"_password"}];
    
    return credentialsMapping;
}

@end
