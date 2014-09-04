//
//  KIASelectCategoryViewController.h
//  KitchInApp
//
//  Created by DeMoN on 2/19/13.
//  Copyright (c) 2013 DeMoN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KIASelectedItemsProtocol.h"

typedef enum creationItemMode
{
    addNewItem,
    addKitchInItem,
    selectItems,
}KIACreationItemMode;

@interface KIASelectCategoryViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, KIASelectedItemsProtocol>
{
    NSArray *_categoriesArray;
    
    NSInteger selectItemIndex;
    
    KIACreationItemMode _mode;
    
    NSString *_categoryName;
}

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property(nonatomic, assign) KIACreationItemMode mode;
@property(nonatomic, strong) NSMutableArray *selectedItems;

- (IBAction)back:(id)sender;

@end
