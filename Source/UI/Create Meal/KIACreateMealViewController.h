//
//  KIACreateMealViewController.h
//  KithInApp
//
//  Created by DeMoN on 8/5/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KIAUsersFromHouseholdProtocol.h"

#import <DWTagList/DWTagList.h>

@interface KIACreateMealViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, KIAUsersFromHouseholdProtocol, DWTagListDelegate, DWTagViewDelegate, UIScrollViewDelegate, UIAlertViewDelegate>
{
    NSArray *_mealArray;
    NSArray *_dishTypeArray;
    
    NSMutableArray *_usersCooking;
    NSMutableArray *_cookWith;
    NSMutableArray *_cookWithout;
    
    NSMutableArray *_users;
}

@property(nonatomic, strong) IBOutlet UIScrollView *scroll;

@property(nonatomic, strong) IBOutlet UIButton *mealButton;
@property(nonatomic, strong) IBOutlet UIButton *dishTypeButton;
@property(nonatomic, strong) IBOutlet UIButton *cookWithButton;
@property(nonatomic, strong) IBOutlet UIButton *cookWithoutButton;

@property(nonatomic, strong) IBOutlet UIImageView *pickerFonMeal;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerMeal;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicatorMeal;
@property(nonatomic, strong) IBOutlet UIImageView *pickerFonDishType;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerDishType;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicatorDishType;

@property(nonatomic, strong) IBOutlet DWTagList *userTagView;
@property(nonatomic, strong) IBOutlet UIView *userTagFoneView;
@property(nonatomic, strong) IBOutlet DWTagList *ingredientWithTagView;
@property(nonatomic, strong) IBOutlet UIView *ingredientWithTagFoneView;
@property(nonatomic, strong) IBOutlet DWTagList *ingredientWithoutTagView;
@property(nonatomic, strong) IBOutlet UIView *ingredientWithoutTagFoneView;

@property(nonatomic, strong) IBOutlet UIButton *searchResipiesButton;

@property(nonatomic, strong) IBOutlet UIView *firstSectionView;
@property(nonatomic, strong) IBOutlet UIView *secondSectionView;

@end
