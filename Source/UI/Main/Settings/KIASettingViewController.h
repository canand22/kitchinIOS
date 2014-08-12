// ************************************************ //
//                                                  //
//  KIASettingViewController.h                      //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/23/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

#import "logoutProtocol.h"
#import "serverGatewayDelegate.h"

#import "KIAMealSettingsTableViewCellProtocol.h"

@interface KIASettingViewController : UIViewController<serverGatewayDelegate, UITableViewDelegate, UITableViewDataSource, KIAMealSettingsTableViewCellProtocol>
{
    id<logoutProtocol> _logoutGateway;
    
    NSMutableArray *_users;
    
    NSInteger _index;
}

@property(nonatomic, strong) IBOutlet UIImageView *facebookImage;
@property(nonatomic, strong) IBOutlet UIImageView *twitterImage;
@property(nonatomic, strong) IBOutlet UIImageView *printerestImage;

@property(nonatomic, strong) IBOutlet UITableView *table;

@property(nonatomic, strong) id<logoutProtocol> logoutGateway;

- (IBAction)back:(id)sender;

- (IBAction)myAccount:(id)sender;
- (IBAction)notifications:(id)sender;
- (IBAction)mealSetting:(id)sender;
- (IBAction)help:(id)sender;

- (IBAction)changeUserName:(id)sender;
- (IBAction)changePassword:(id)sender;

- (IBAction)facebookClick:(id)sender;
- (IBAction)twitterClick:(id)sender;
- (IBAction)pinterestClick:(id)sender;

@end
