//
//  KIASelectItemViewController.h
//  KitchInApp
//
//  Created by DeMoN on 3/6/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIASelectItemViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_categoryItems;
}

@property(nonatomic, strong) NSString *categoryName;

@property(nonatomic, strong) IBOutlet UITableView *table;

@end
