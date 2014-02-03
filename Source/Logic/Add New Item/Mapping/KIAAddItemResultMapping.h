//
//  KIAAddItemResultMapping.h
//  KitchInApp
//
//  Created by DeMoN on 1/30/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIAAddItemResultMapping : NSObject
{
    BOOL _isSuccessfully;
    NSString *_message;
}

@property(nonatomic, assign) BOOL isSuccessfully;
@property(nonatomic, strong) NSString *message;

+ (RKObjectMapping *)mapping;

@end
