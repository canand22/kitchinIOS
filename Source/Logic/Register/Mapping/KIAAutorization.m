//
//  KIAAutorization.m
//  KitchInApp
//
//  Created by DeMoN on 1/14/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAAutorization.h"

#import "RKObjectMapping.h"

@implementation KIAAutorization

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize email = _email;
@synthesize password = _password;

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *autorizMapping = [RKObjectMapping mappingForClass:[KIAAutorization class]];
    
    // setup current weather mapping
    [autorizMapping addAttributeMappingsFromDictionary:@{@"FirstName" : @"_firstName", @"LastName" : @"_lastName", @"Email" : @"_email", @"Password" : @"_password"}];
    
    return autorizMapping;
}

@end
