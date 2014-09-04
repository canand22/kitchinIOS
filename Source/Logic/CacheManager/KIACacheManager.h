//
//  KIACacheManager.h
//  UpForCoffee
//
//  Created by DeMoN on 5/29/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UICacheManagerSaveNotification @"CacheManagerSave"

@interface KIACacheManager : NSObject

+ (KIACacheManager *)sharedCacheManager;

- (BOOL)saveCacheImage:(UIImage *)image forIdentifier:(NSString *)identifier;
- (UIImage *)fetchCacheImageForIdentifier:(NSString *)identifier;

- (BOOL)checkImageForCacheWithIdentifier:(NSString *)identifier;

@end
