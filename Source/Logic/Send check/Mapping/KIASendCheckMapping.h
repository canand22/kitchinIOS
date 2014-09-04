// ************************************************ //
//                                                  //
//  KIASendCheckMapping.h                           //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/11/14.                    //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface KIASendCheckMapping : NSObject

@property(nonatomic, assign) NSInteger Id;
@property(nonatomic, strong) NSString *Category;
@property(nonatomic, assign) BOOL IsSuccessMatching;
@property(nonatomic, strong) NSString *ItemName;
@property(nonatomic, strong) NSString *ItemShortName;
@property(nonatomic, strong) NSString *YummlyName;

+ (RKObjectMapping *)mapping;

@end
