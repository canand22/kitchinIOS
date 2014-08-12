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

@interface KIACreateMealViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, KIAUsersFromHouseholdProtocol, DWTagListDelegate, DWTagViewDelegate, UIScrollViewDelegate>
{
    NSArray *_mealArray;
    NSArray *_dishTypeArray;
    
    NSMutableArray *_usersCooking;
}

@property(nonatomic, strong) IBOutlet UIImageView *pickerFonMeal;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerMeal;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicatorMeal;
@property(nonatomic, strong) IBOutlet UIImageView *pickerFonDishType;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerDishType;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicatorDishType;

@property(nonatomic, strong) IBOutlet UIView *contentView;

@property(nonatomic, strong) IBOutlet DWTagList *userTagView;
@property(nonatomic, strong) IBOutlet UIView *userTagFoneView;
@property(nonatomic, strong) IBOutlet DWTagList *ingredientTagView;

@end
