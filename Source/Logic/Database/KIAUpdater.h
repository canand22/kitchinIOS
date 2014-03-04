//
//  KIAUpdater.h
//  KitchInApp
//
//  Created by DeMoN on 1/24/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KIAItem;

@interface KIAUpdater : NSObject
{
    NSManagedObjectContext *_managedObjectContext;
}

- (void)update;
- (void)addItemFromKitchInWihtId:(NSInteger)theId name:(NSString *)name categoryId:(NSInteger)catId shortName:(NSString *)shortName count:(NSInteger)count value:(NSString *)value;
- (NSArray *)itemsForCategoryName:(NSString *)catName;
- (void)removeItem:(KIAItem *)item;

+ (KIAUpdater *)sharedUpdater;

@end
