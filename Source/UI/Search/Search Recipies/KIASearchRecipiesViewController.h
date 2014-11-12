//
//  KIASearchRecipiesViewController.h
//  KitchInApp
//
//  Created by DeMoN on 8/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchRecipiesProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIASearchRecipiesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, serverGatewayDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    id<SearchRecipiesProtocol> _searchGateway;
    
    NSMutableArray *_recipiesArray;
    NSMutableArray *_countRecipiesArray;
    
    NSInteger _selectedItem;
    
    NSArray *_sortOptions;
    NSUInteger countRecept;
    NSUInteger currentCountRecept;
    
    BOOL isLoadContent;
    
    BOOL isFilterSettings;
}

@property(nonatomic, strong) NSDictionary *itemForQuery;

@property(nonatomic, strong) IBOutlet UITableView *table;
@property(nonatomic, strong) IBOutlet UICollectionView *collection;

@property(nonatomic, strong) IBOutlet UIButton *showCollection;
@property(nonatomic, strong) IBOutlet UIButton *showTable;

@property(nonatomic, strong) IBOutlet UIView *collectionView;
@property(nonatomic, strong) IBOutlet UIView *tableView;

@property(nonatomic, strong) IBOutlet UIImageView *pickerFonSort;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerSort;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicatorSort;
@property(nonatomic, strong) IBOutlet UIButton *sortButton;

@end
