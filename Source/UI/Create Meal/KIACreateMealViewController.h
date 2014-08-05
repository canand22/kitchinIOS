//
//  KIACreateMealViewController.h
//  KithInApp
//
//  Created by DeMoN on 8/5/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIACreateMealViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *_mealArray;
    NSArray *_dishTypeArray;
}

@property(nonatomic, strong) IBOutlet UIImageView *pickerFonMeal;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerMeal;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicatorMeal;
@property(nonatomic, strong) IBOutlet UIImageView *pickerFonDishType;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerDishType;
@property(nonatomic, strong) IBOutlet UIImageView *pickerIndicatorDishType;

@end
