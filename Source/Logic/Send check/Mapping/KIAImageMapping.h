//
//  KIAImageMapping.h
//  KitchInApp
//
//  Created by DeMoN on 1/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAImageMapping : NSObject

@property(nonatomic, strong) NSString *ImageAsBase64String;
@property(nonatomic, assign) NSInteger StoreId;

+ (RKObjectMapping *)mapping;

@end
