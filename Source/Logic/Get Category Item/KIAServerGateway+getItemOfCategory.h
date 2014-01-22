//
//  KIAServerGateway+getItemOfCategory.h
//  KitchInApp
//
//  Created by DeMoN on 1/20/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway.h"

#import "getCategoryItemProtocol.h"

@interface KIAServerGateway (getItemOfCategory)<getCategoryItemProtocol>

@property(nonatomic, assign) id delegate;

@end
