// ************************************************ //
//                                                  //
//  KIAEditRecognizeItemsViewController.h           //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

@interface KIAEditRecognizeItemsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView *table;

@end
