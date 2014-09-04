//
//  KIARecipeInstructionsViewController.h
//  KitchInApp
//
//  Created by DeMoN on 8/26/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIARecipeInstructionsViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) IBOutlet UIWebView *web;

@property(nonatomic, strong) NSMutableArray *receptIngredient;

@end
