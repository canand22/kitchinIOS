//
//  KIASelectCategoryViewController.h
//  KitchInApp
//
//  Created by DeMoN on 2/19/13.
//  Copyright (c) 2013 DeMoN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum creationItemMode
{
    addNewItem,
    addKitchInItem,
}KIACreationItemMode;

@interface KIASelectCategoryViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *_categoriesArray;
    
    NSInteger selectItemIndex;
    
    KIACreationItemMode _mode;
}

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property(nonatomic, assign) KIACreationItemMode mode;

- (IBAction)back:(id)sender;

@end
