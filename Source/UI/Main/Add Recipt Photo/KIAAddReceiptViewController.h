// ************************************************ //
//                                                  //
//  KIAAddReceiptViewController.h                   //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 2/18/13.                    //
//  Copyright (c) 2013 DeMoN. All rights reserved.  //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

@interface KIAAddReceiptViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) IBOutlet UITableView *table;

- (IBAction)back:(id)sender;

@end
