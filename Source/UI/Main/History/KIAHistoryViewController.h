//
//  KIAHistoryViewController.h
//  KitchInApp
//
//  Created by DeMoN on 1/10/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIAHistoryViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *photo;
    NSString *path;
}

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end
