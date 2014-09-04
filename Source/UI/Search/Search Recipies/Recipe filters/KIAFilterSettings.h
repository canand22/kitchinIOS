//
//  KIAFilterSettings.h
//  KitchInApp
//
//  Created by DeMoN on 8/22/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIAFilterSettings : NSObject

@property(nonatomic, strong) NSMutableArray *cuisine;
@property(nonatomic, strong) NSString *meal;
@property(nonatomic, strong) NSString *dishType;
@property(nonatomic, strong) NSString *time;
@property(nonatomic, strong) NSMutableArray *holiday;
@property(nonatomic, strong) NSMutableArray *allergy;
@property(nonatomic, strong) NSMutableArray *diet;

+ (KIAFilterSettings *)sharedFilterManager;

- (void)saveSettings;

@end
