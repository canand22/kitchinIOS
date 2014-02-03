//
//  EditRecognizedItemCellDelegate.h
//  KitchInApp
//
//  Created by DeMoN on 1/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EditRecognizedItemCellDelegate<NSObject>

- (void)showActionSheet:(NSInteger)numberOfCellRow;
- (void)showPickerView:(NSInteger)numberOfCellRow;
- (void)deleteItemFromIndex:(NSInteger)index;

@end
