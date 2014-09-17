// ************************************************ //
//                                                  //
//  KIACapturedReceiptViewController.h              //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/24/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import <UIKit/UIKit.h>

#import "sendCheckProtocol.h"
#import "serverGatewayDelegate.h"

@interface KIACapturedReceiptViewController : UIViewController<serverGatewayDelegate, UIAlertViewDelegate>
{
    id<sendCheckProtocol> _sendCheckGateway;
}

@property(nonatomic, strong) id<sendCheckProtocol> sendCheckGateway;

@property(nonatomic, strong) UIImage *photo;
@property(nonatomic, strong) NSString *titleText;

@property(nonatomic, strong) IBOutlet UIImageView *image;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;

- (void)showData:(NSArray *)arrayItem;

@end
