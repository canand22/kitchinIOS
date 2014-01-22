//
//  KIAgetItem.h
//  KitchInApp
//
//  Created by DeMoN on 1/20/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIAgetItem : NSManagedObject

@property(nonatomic, assign) NSUInteger *idItem;
@property(nonatomic, strong) NSString *name;

@end
