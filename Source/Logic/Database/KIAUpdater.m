//
//  KIAUpdater.m
//  KitchInApp
//
//  Created by DeMoN on 1/24/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAUpdater.h"

#import "KIAItem.h"
#import "KIACategory.h"
#import "KIAUser.h"
#import "KIAFavorite.h"

@implementation KIAUpdater

+ (KIAUpdater *)sharedUpdater
{
    static KIAUpdater *sharedUpdater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        sharedUpdater = [[KIAUpdater alloc] init];
    });
    
    return sharedUpdater;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static KIAUpdater *sharedUpdater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        sharedUpdater = [super allocWithZone:zone];
    });
    
    return sharedUpdater;
}

#pragma mark ***** category data *****

- (void)update
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstRun"])
    {
        NSArray *_categoriesArray = @[@"Dairy", @"Produce", @"Poultry", @"Meats & Deli", @"Seafood", @"Breads & Bakery", @"Pasta", @"Cereal & Grains", @"Drinks", @"Dry Prepared Foods", @"Canned Foods, Soups, Broths", @"Frozen", @"Snacks", @"Sweets", @"Baking", @"Condiments, Sauces, Oils", @"Spices & Herbs", @"Other"];
        NSArray *_categoriesKeyArray = @[@6, @10, @12, @14, @13, @2, @11, @4, @7, @8, @3, @9, @15, @17, @1, @5, @16, @18];
    
        NSManagedObjectContext *context = [self managedObjectContext];
        
        for (int i = 0; i < [_categoriesArray count]; i++)
        {
            KIACategory *newCategory = [NSEntityDescription insertNewObjectForEntityForName:@"KIACategory" inManagedObjectContext:context];
            [newCategory setName:[_categoriesArray objectAtIndex:i]];
            [newCategory setIdCategory:(NSNumber *)[_categoriesKeyArray objectAtIndex:i]];
        }
        
        NSError *error = nil;
        
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSInteger)idCategoryFromCategoryName:(NSString *)name
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIACategory" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@", name];
    [request setPredicate:predicate];
    NSError  *error;
    NSArray *itemArr = [context executeFetchRequest:request error:&error];
    
    NSInteger index = 0;
    
    if (itemArr.count > 0)
    {
        for (KIACategory *thisCat in itemArr)
        {
            if ([[thisCat name] isEqualToString:name])
            {
                index = [thisCat idCategory].integerValue;
            }
        }
    }
    
    return index;
}

#pragma mark ***** item data *****

- (void)addItemFromKitchInWihtId:(NSInteger)theId name:(NSString *)name categoryId:(NSInteger)catId shortName:(NSString *)shortName count:(NSInteger)count value:(NSString *)value yummly:(NSString *)yummly
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAItem" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    BOOL unique = YES;
    KIAItem *temp = nil;
    NSError  *error;
    NSArray *items = [context executeFetchRequest:request error:&error];
    
    if (items.count > 0)
    {
        for (KIAItem *thisItem in items)
        {
            if ([[thisItem idItem] isEqualToNumber:[NSNumber numberWithInteger:theId]] && ![[thisItem idItem] isEqualToNumber:[NSNumber numberWithInteger:-1]])
            {
                unique = NO;
                
                temp = thisItem;
            }
        }
    }
    
    if (unique)
    {
        KIAItem *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"KIAItem" inManagedObjectContext:context];
        [newItem setIdItem:[NSNumber numberWithInteger:theId]];
        [newItem setName:name];
        [newItem setIdCategory:[NSNumber numberWithInteger:catId]];
        [newItem setReduction:shortName];
        [newItem setCount:[NSNumber numberWithInteger:count]];
        [newItem setValue:value];
        [newItem setYummlyName:yummly];
        
        NSError *error = nil;
        
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
    else
    {
        if (temp != nil)
        {
            NSInteger countItem = [[temp count] integerValue];
            [temp setCount:[NSNumber numberWithInteger:(countItem + count)]];
            [temp setValue:value];
            
            NSError *error = nil;
            
            // Save the object to persistent store
            if (![context save:&error])
            {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
        }
    }
}

- (NSArray *)itemsForCategoryName:(NSString *)catName
{
    NSInteger catId = [self idCategoryFromCategoryName:catName];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAItem" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idCategory==%@", [NSNumber numberWithInteger:catId]];
    [request setPredicate:predicate];
    NSError  *error;
    NSArray *itemArr = [context executeFetchRequest:request error:&error];
    
    return itemArr;
}

- (NSArray *)findItemForText:(NSString *)text
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAItem" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"yummlyName contains[c] %@", text];
    [request setPredicate:predicate];
    NSError  *error;
    NSArray *itemArr = [context executeFetchRequest:request error:&error];
    
    return itemArr;
}

- (void)removeItem:(KIAItem *)item
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [context deleteObject:item];
}

- (NSInteger)howMuchIsMissingIngredient:(NSArray *)ingredientArray
{
    NSInteger count = 0;
    
    for (int i = 0; i < [ingredientArray count]; i++)
    {
        if (![self whetherThereIsAnIngredient:[ingredientArray objectAtIndex:i]])
        {
            count++;
        }
    }
    
    return count;
}

- (BOOL)whetherThereIsAnIngredient:(NSString *)yummlyName
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAItem" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"yummlyName contains[c] %@", yummlyName];
    [request setPredicate:predicate];
    NSError  *error;
    NSArray *itemArr = [context executeFetchRequest:request error:&error];
    
    if ([itemArr count])
    {
        return YES;
    }
    
    return NO;
}

- (void)updateItemInfo:(KIAItem *)item
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error = nil;
    
    // Save the object to persistent store
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (NSArray *)getAllItems
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAItem" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError  *error;
    NSArray *items = [context executeFetchRequest:request error:&error];
    
    return items;
}

- (void)removeItemWithNames:(NSArray *)items
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (int i = 0; i < [items count]; i++)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAItem" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"yummlyName contains[c] %@", [items objectAtIndex:i]];
        [request setPredicate:predicate];
        NSError  *error;
        NSArray *itemArr = [context executeFetchRequest:request error:&error];
        
        if ([itemArr count] > 0)
        {
            [context deleteObject:[itemArr objectAtIndex:0]];
        }
    }
}

#pragma mark ***** user data *****

- (KIAUser *)addUserWithId:(NSInteger)idUser name:(NSString *)userName state:(NSNumber *)state
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    KIAUser *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"KIAUser" inManagedObjectContext:context];
    [newUser setIdUser:[NSNumber numberWithInteger:idUser]];
    [newUser setName:userName];
    [newUser setIsActiveState:state];
    [newUser setDislikeIngredients:[NSMutableArray arrayWithObjects:nil]];
    [newUser setDietaryRestrictions:[NSMutableArray arrayWithObjects:nil]];
        
    NSError *error = nil;
    
    // Save the object to persistent store
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    return newUser;
}

- (void)updateUsersInfo:(KIAUser *)user
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error = nil;
    
    // Save the object to persistent store
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (NSArray *)getAllUsers
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAUser" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError  *error;
    NSArray *users = [context executeFetchRequest:request error:&error];
    
    return users;
}

- (void)removeUser:(KIAUser *)user
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [context deleteObject:user];
}

#pragma mark ***** favorite data *****

- (void)addFavoriteWithId:(NSString *)theId name:(NSString *)recipeName url:(NSString *)recipeUrl rating:(NSInteger)rating served:(NSInteger)served time:(NSInteger)time icon:(NSString *)picture ingredients:(NSArray *)ingredients
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAFavorite" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    BOOL unique = YES;
    NSError  *error;
    NSArray *items = [context executeFetchRequest:request error:&error];
    
    if (items.count > 0)
    {
        for (KIAFavorite *thisItem in items)
        {
            if ([[thisItem recipeId] isEqualToString:theId])
            {
                unique = NO;
            }
        }
    }
    
    if (unique)
    {
        KIAFavorite *newFav = [NSEntityDescription insertNewObjectForEntityForName:@"KIAFavorite" inManagedObjectContext:context];
        [newFav setRecipeId:theId];
        [newFav setRecipeName:recipeName];
        [newFav setRecipeUrl:recipeUrl];
        [newFav setRating:[NSNumber numberWithInteger:rating]];
        [newFav setServed:[NSNumber numberWithInteger:served]];
        [newFav setTime:[NSNumber numberWithInteger:time]];
        [newFav setPicture:picture];
        [newFav setIngredients:ingredients];
        
        NSError *error = nil;
        
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

- (NSArray *)getAllFav
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAFavorite" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError  *error;
    NSArray *fav = [context executeFetchRequest:request error:&error];
    
    return fav;
}

- (BOOL)checkReceptInFavoriteWithID:(NSString *)receptId
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAFavorite" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"recipeId contains[c] %@", receptId];
    [request setPredicate:predicate];
    NSError  *error;
    NSArray *itemArr = [context executeFetchRequest:request error:&error];
    
    if ([itemArr count])
    {
        return YES;
    }
    
    return NO;
}

- (void)removeFavorite:(KIAFavorite *)fav
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [context deleteObject:fav];
}

#pragma mark ***** core data *****

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSError *error;
    
    NSURL *storeUrl = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:@"KitchInModel.xcdatamodeld"]];
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error])
    {
        // Handle error
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    return persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

#pragma mark *****

@end
