//
//  KIAItem.h
//  KitchInApp
//
//  Created by DeMoN on 2/3/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KIAItem : NSManagedObject

@property(nonatomic, retain) NSNumber * count;
@property(nonatomic, retain) NSNumber * idCategory;
@property(nonatomic, retain) NSNumber * idItem;
@property(nonatomic, retain) NSString * name;
@property(nonatomic, retain) NSString * reduction;
@property(nonatomic, retain) NSString * value;

@end
