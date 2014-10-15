//
//  KIATabBarViewController.h
//  KitchInApp
//
//  Created by Lenin on 2/12/13.
//  Copyright (c) 2013 DeMoN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIATabBarViewController : UITabBarController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImage *originalImage;
}

- (void)reloadButtonImageWithIndex:(NSInteger)index;
- (void)pressButton:(id)sender;

@end
