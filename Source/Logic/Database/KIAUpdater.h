//
//  KIAUpdater.h
//  KitchInApp
//
//  Created by DeMoN on 1/24/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIAUpdater : NSObject
{
    NSManagedObjectContext *_managedObjectContext;
}

- (void)update;
- (void)addItemFromKitchInWihtId:(NSInteger)theId name:(NSString *)name categoryId:(NSInteger)catId shortName:(NSString *)shortName count:(NSInteger)count value:(NSString *)value;

+ (KIAUpdater *)sharedUpdater;

@end
