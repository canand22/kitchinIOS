//
//  KIAUpdater.h
//  KitchInApp
//
//  Created by DeMoN on 1/24/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KIAItem;
@class KIAUser;

@interface KIAUpdater : NSObject
{
    NSManagedObjectContext *_managedObjectContext;
}

// metods for category data work
- (void)update;
- (NSInteger)idCategoryFromCategoryName:(NSString *)name;

// metods for item data work
- (void)addItemFromKitchInWihtId:(NSInteger)theId name:(NSString *)name categoryId:(NSInteger)catId shortName:(NSString *)shortName count:(NSInteger)count value:(NSString *)value;
- (NSArray *)itemsForCategoryName:(NSString *)catName;
- (void)removeItem:(KIAItem *)item;

// metods for user data work
- (void)addUserWithId:(NSInteger)idUser name:(NSString *)userName;
- (void)updateUsersInfo:(KIAUser *)user;
- (NSArray *)getAllUsers;
- (void)removeUser:(KIAUser *)user;

+ (KIAUpdater *)sharedUpdater;

@end
