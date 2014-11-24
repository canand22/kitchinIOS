//
//  KIAFilterSettings.m
//  KitchInApp
//
//  Created by DeMoN on 8/22/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAFilterSettings.h"

@implementation KIAFilterSettings

static KIAFilterSettings *manager = nil;

+ (KIAFilterSettings *)sharedFilterManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        manager = [[KIAFilterSettings alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _cuisine = [[NSMutableArray alloc] init];
        _meal = [[NSString alloc] init];
        _dishType = [[NSString alloc] init];
        _time = [[NSString alloc] init];
        _holiday = [[NSMutableArray alloc] init];
        _allergy = [[NSMutableArray alloc] init];
        _diet = [[NSMutableArray alloc] init];
        
        [self loadSettings];
        
        if ([_meal isEqualToString:@""])
        {
            _meal = @"Any";
        }
        
        if ([_dishType isEqualToString:@""])
        {
            _dishType = @"Any";
        }
        
        if ([_time isEqualToString:@""])
        {
            _time = @"Any";
        }
    }
    
    return self;
}

- (void)loadSettings
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Cuisine"])
    {
        _cuisine = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Cuisine"] mutableCopy];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Meal"])
    {
        _meal = [[NSUserDefaults standardUserDefaults] objectForKey:@"Meal"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"DishType"])
    {
        _dishType = [[NSUserDefaults standardUserDefaults] objectForKey:@"DishType"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Time"])
    {
        _time = [[NSUserDefaults standardUserDefaults] objectForKey:@"Time"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Holiday"])
    {
        _holiday = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Holiday"] mutableCopy];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Allergy"])
    {
        _allergy = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Allergy"] mutableCopy];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Diet"])
    {
        _diet = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Diet"] mutableCopy];
    }
}

- (void)saveSettings
{
    [[NSUserDefaults standardUserDefaults] setObject:_cuisine forKey:@"Cuisine"];
    [[NSUserDefaults standardUserDefaults] setObject:_meal forKey:@"Meal"];
    [[NSUserDefaults standardUserDefaults] setObject:_dishType forKey:@"DishType"];
    [[NSUserDefaults standardUserDefaults] setObject:_time forKey:@"Time"];
    [[NSUserDefaults standardUserDefaults] setObject:_holiday forKey:@"Holiday"];
    [[NSUserDefaults standardUserDefaults] setObject:_allergy forKey:@"Allergy"];
    [[NSUserDefaults standardUserDefaults] setObject:_diet forKey:@"Diet"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
