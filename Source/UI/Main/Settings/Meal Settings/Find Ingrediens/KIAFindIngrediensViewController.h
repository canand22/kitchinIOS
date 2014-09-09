//
//  KIAFindIngrediensViewController.h
//  KitchInApp
//
//  Created by DeMoN on 9/8/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "yamlyProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIAFindIngrediensViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, serverGatewayDelegate>
{
    BOOL _isSearch;
    
    NSMutableArray *_ingredientSearch;
    
    id<yamlyProtocol> _yummlyGateway;
}

@property(nonatomic, strong) NSMutableArray *ingredients;

@property(nonatomic, strong) IBOutlet UITableView *table;

@end
