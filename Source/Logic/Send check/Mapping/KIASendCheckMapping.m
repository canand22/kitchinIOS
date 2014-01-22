// ************************************************ //
//                                                  //
//  KIASendCheckMapping.m                           //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/11/14.                    //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIASendCheckMapping.h"

#import "RKObjectMapping.h"

@implementation KIASendCheckMapping

+ (RKObjectMapping *)mapping
{
    // create mapping
    RKObjectMapping *sendCheckMapping = [RKObjectMapping mappingForClass:[KIASendCheckMapping class]];
    
    // setup current weather mapping
    [sendCheckMapping addAttributeMappingsFromArray:@[@"Id", @"Category", @"IsSuccessMatching", @"ItemName"]];
    
    return sendCheckMapping;
}

@end
