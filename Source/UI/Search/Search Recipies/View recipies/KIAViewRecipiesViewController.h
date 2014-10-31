//
//  KIAViewRecipiesViewController.h
//  KitchInApp
//
//  Created by DeMoN on 8/20/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "recipiesProtocol.h"
#import "serverGatewayDelegate.h"

@class KIAFullRecipiesMapping;

@interface KIAViewRecipiesViewController : UIViewController<serverGatewayDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    id<recipiesProtocol> _recipeGateway;
    
    NSArray *_ingredients;
    
    CGFloat _tableHeight;
    
    NSString *_url;
    
    KIAFullRecipiesMapping *_recipe;
    
    BOOL isMatching;
}

@property(nonatomic, strong) NSString *recipiesIdentification;
@property(nonatomic, strong) NSArray *ingredientsArray;

@property(nonatomic, strong) IBOutlet UIScrollView *scroll;

@property(nonatomic, strong) IBOutlet UILabel *recipeName;
@property(nonatomic, strong) IBOutlet UIImageView *recipeImage;
@property(nonatomic, strong) IBOutlet UIImageView *stars;
@property(nonatomic, strong) IBOutlet UILabel *numberServed;
@property(nonatomic, strong) IBOutlet UILabel *totalTime;

@property(nonatomic, strong) IBOutlet UITableView *table;

@property(nonatomic, strong) IBOutlet UIView *buttonPanel;

@property(nonatomic, strong) IBOutlet UIButton *addFavorite;
@property(nonatomic, strong) IBOutlet UIButton *cookItBtn;

@end
