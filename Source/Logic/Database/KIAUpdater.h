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
@class KIAFavorite;

@interface KIAUpdater : NSObject
{
    NSManagedObjectContext *_managedObjectContext;
}

// metods for category data work
- (void)update;
- (NSInteger)idCategoryFromCategoryName:(NSString *)name;

// metods for item data work
- (void)addItemFromKitchInWihtId:(NSInteger)theId name:(NSString *)name categoryId:(NSInteger)catId shortName:(NSString *)shortName count:(NSInteger)count value:(NSString *)value yummly:(NSString *)yummly;
- (NSArray *)itemsForCategoryName:(NSString *)catName;
- (NSArray *)findItemForText:(NSString *)text;
- (void)removeItem:(KIAItem *)item;
- (NSInteger)howMuchIsMissingIngredient:(NSArray *)ingredientArray;
- (BOOL)whetherThereIsAnIngredient:(NSString *)yummlyName;
- (void)updateItemInfo:(KIAItem *)item;
- (NSArray *)getAllItems;

// metods for user data work
- (void)addUserWithId:(NSInteger)idUser name:(NSString *)userName;
- (void)updateUsersInfo:(KIAUser *)user;
- (NSArray *)getAllUsers;
- (void)removeUser:(KIAUser *)user;

// metods for favorite data work
- (void)addFavoriteWithId:(NSString *)theId name:(NSString *)recipeName url:(NSString *)recipeUrl rating:(NSInteger)rating served:(NSInteger)served time:(NSInteger)time icon:(NSString *)picture ingredients:(NSArray *)ingredients;
- (NSArray *)getAllFav;
- (void)removeFavorite:(KIAFavorite *)fav;

+ (KIAUpdater *)sharedUpdater;

@end
