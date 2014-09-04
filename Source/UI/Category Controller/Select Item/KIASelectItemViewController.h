//
//  KIASelectItemViewController.h
//  KitchInApp
//
//  Created by DeMoN on 3/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

// #import "KIASelectedItemsProtocol.h"

@interface KIASelectItemViewController : UIViewController<UITableViewDataSource, UITableViewDelegate /*, KIASelectedItemsProtocol*/>
{
    NSArray *_categoryItems;
}

@property(nonatomic, strong) NSString *categoryName;

@property(nonatomic, strong) IBOutlet UITableView *table;

@end
