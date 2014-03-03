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

@implementation KIAUpdater

+ (KIAUpdater *)sharedUpdater
{
    static KIAUpdater *sharedUpdater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUpdater = [[KIAUpdater alloc] init];
    });
    
    return sharedUpdater;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static KIAUpdater *sharedUpdater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUpdater = [super allocWithZone:zone];
    });
    
    return sharedUpdater;
}

- (void)update
{
    if (/*![[NSUserDefaults standardUserDefaults] objectForKey:@"firstRun"]*/ YES)
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

- (void)addItemFromKitchInWihtId:(NSInteger)theId name:(NSString *)name categoryId:(NSInteger)catId shortName:(NSString *)shortName count:(NSInteger)count value:(NSString *)value
{
    NSManagedObjectContext *context = [self managedObjectContext];
 
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"KIAItem" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    BOOL unique = YES;
    NSError  *error;
    NSArray *items = [context executeFetchRequest:request error:&error];
    
    if (items.count > 0)
    {
        for (KIAItem *thisItem in items)
        {
            if ([[thisItem idItem] isEqualToNumber:[NSNumber numberWithInteger:theId]])
            {
                unique = NO;
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
    
        NSError *error = nil;
        
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
    else
    {
        // а
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
    
    NSInteger index;
    
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

@end
