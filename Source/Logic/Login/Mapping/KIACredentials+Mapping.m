// ************************************************ //
//                                                  //
//  KIACredentialsMapping.m                         //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/6/14.                     //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIACredentials+Mapping.h"

#import "RKObjectMapping.h"

@implementation KIACredentials (Mapping)

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *credentialsMapping = [RKObjectMapping mappingForClass:[KIACredentials class]];
    
    // setup current weather mapping
    [credentialsMapping addAttributeMappingsFromDictionary:@{@"Email" : @"email", @"Password" : @"password"}];
    
    return credentialsMapping;
}

@end
