// ************************************************ //
//                                                  //
//  KIAMyKitchenViewController.h                    //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/23/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

@interface KIAMyKitchenViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *_categoriesArray;
    
    NSInteger selectItemIndex;
}

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end
