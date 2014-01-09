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

@interface KIASettingViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIImageView *facebookImage;
@property(nonatomic, strong) IBOutlet UIImageView *twitterImage;
@property(nonatomic, strong) IBOutlet UIImageView *printerestImage;

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
