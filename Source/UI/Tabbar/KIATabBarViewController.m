//
//  KIATabBarViewController.m
//  KitchInApp
//
//  Created by Lenin on 2/12/13.
//  Copyright (c) 2013 DeMoN. All rights reserved.
//

#import "KIATabBarViewController.h"

#import "KIALoginViewController.h"
#import "KIACapturedReceiptViewController.h"

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)

@interface KIATabBarViewController ()

@end

@implementation KIATabBarViewController
{
    UIView *blueView_;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create tabbar
    blueView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 78)];
    [[self view] addSubview:blueView_];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar.png"]];
    [blueView_ addSubview:image];
    
    [self initToolbar];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (capturedReceiptViewController)
    {
        capturedReceiptViewController = nil;
        
        [self presentCamera];
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGRect rect = [blueView_ frame];
    
    rect.origin.y = [[self view] frame].size.height - 78;
    [blueView_ setFrame:rect];
    
    [[self view] bringSubviewToFront:blueView_];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect rect = [blueView_ frame];
    
    rect.origin.y = [[self view] frame].size.height - 78;
    [blueView_ setFrame:rect];
    
    [[self view] bringSubviewToFront:blueView_];
}

- (void)initToolbar
{
    UIImage *image = [UIImage imageNamed:@"left_right_button active.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:1];
    [button setFrame:CGRectMake(0, 6, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    UIImageView *home_icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_active.png"]];
    [home_icon setFrame:CGRectMake((image.size.width - [home_icon frame].size.width) / 2, (image.size.height - [home_icon frame].size.height) / 2, [home_icon frame].size.width, [home_icon frame].size.height)];
    [home_icon setTag:11];
    [button addSubview:home_icon];
    [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [blueView_ addSubview:button];
    
    float x = image.size.width;
    image = [UIImage imageNamed:@"middle_lef_right_button_active.png"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:2];
    [button setFrame:CGRectMake(x, 6, image.size.width, image.size.height)];
    UIImageView *my_kitchin_icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"My Kitchin.png"]];
    [my_kitchin_icon setFrame:CGRectMake((image.size.width - [my_kitchin_icon frame].size.width) / 2 - 13, (image.size.height - [my_kitchin_icon frame].size.height) / 2, [my_kitchin_icon frame].size.width, [my_kitchin_icon frame].size.height)];
    [my_kitchin_icon setTag:12];
    [button addSubview:my_kitchin_icon];
    [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [blueView_ addSubview:button];
    
    image = [UIImage imageNamed:@"left_right_button active.png"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:5];
    [button setFrame:CGRectMake([blueView_ frame].size.width - image.size.width, 6, image.size.width, image.size.height)];
    UIImageView *search_icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search.png"]];
    [search_icon setFrame:CGRectMake((image.size.width - [search_icon frame].size.width) / 2, (image.size.height - [search_icon frame].size.height) / 2, [search_icon frame].size.width, [search_icon frame].size.height)];
    [search_icon setTag:15];
    [button addSubview:search_icon];
    [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [blueView_ addSubview:button];
    
    x = image.size.width;
    image = [UIImage imageNamed:@"middle_lef_right_button_active.png"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:4];
    [button setFrame:CGRectMake([blueView_ frame].size.width - image.size.width - x, 6, image.size.width, image.size.height)];
    UIImageView *create_meal_icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"create meal.png"]];
    [create_meal_icon setFrame:CGRectMake((image.size.width - [create_meal_icon frame].size.width) / 2 + 13, (image.size.height - [create_meal_icon frame].size.height) / 2, [create_meal_icon frame].size.width, [create_meal_icon frame].size.height)];
    [create_meal_icon setTag:14];
    [button addSubview:create_meal_icon];
    [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [blueView_ addSubview:button];
    
    image = [UIImage imageNamed:@"capture_button.png"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:3];
    [button setFrame:CGRectMake([blueView_ frame].size.width / 2 - image.size.width / 2, [blueView_ frame].size.height - image.size.height - 2, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    UIImageView *capture_icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"capture.png"]];
    [capture_icon setFrame:CGRectMake((image.size.width - [capture_icon frame].size.width) / 2, (image.size.height - [capture_icon frame].size.height) / 2, [capture_icon frame].size.width, [capture_icon frame].size.height)];
    [capture_icon setTag:13];
    [button addSubview:capture_icon];
    [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [blueView_ addSubview:button];
}

- (void)reloadButtonImageWithIndex:(NSInteger)index
{
    if (index == 1)
    {
        UIImage *image = [UIImage imageNamed:@"left_right_button active.png"];
        [(UIButton *)[blueView_ viewWithTag:1] setImage:image forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:1] setImage:image forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:1] viewWithTag:11] setImage:[UIImage imageNamed:@"home_active.png"]];
    }
    else
    {
        [(UIButton *)[blueView_ viewWithTag:1] setImage:nil forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:1] setImage:nil forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:1] viewWithTag:11] setImage:[UIImage imageNamed:@"home.png"]];
    }
    
    if (index == 2)
    {
        UIImage *image = [UIImage imageNamed:@"middle_lef_right_button_active.png"];
        [(UIButton *)[blueView_ viewWithTag:2] setImage:image forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:2] setImage:image forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:2] viewWithTag:12] setImage:[UIImage imageNamed:@"My Kitchin_active.png"]];
    }
    else
    {
        [(UIButton *)[blueView_ viewWithTag:2] setImage:nil forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:2] setImage:nil forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:2] viewWithTag:12] setImage:[UIImage imageNamed:@"My Kitchin.png"]];
    }
    
    if (index == 3)
    {
        UIImage *image = [UIImage imageNamed:@"capture_button.png"];
        [(UIButton *)[blueView_ viewWithTag:3] setImage:image forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:3] setImage:image forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:3] viewWithTag:13] setImage:[UIImage imageNamed:@"capture.png"]];
    }
    
    if (index == 4)
    {
        UIImage *image = [UIImage imageNamed:@"middle_lef_right_button_active.png"];
        [(UIButton *)[blueView_ viewWithTag:4] setImage:image forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:4] setImage:image forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:4] viewWithTag:14] setImage:[UIImage imageNamed:@"create meal_active.png"]];
    }
    else
    {
        [(UIButton *)[blueView_ viewWithTag:4] setImage:nil forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:4] setImage:nil forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:4] viewWithTag:14] setImage:[UIImage imageNamed:@"create meal.png"]];
    }
    
    if (index == 5)
    {
        UIImage *image = [UIImage imageNamed:@"left_right_button active.png"];
        [(UIButton *)[blueView_ viewWithTag:5] setImage:image forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:5] setImage:image forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:5] viewWithTag:15] setImage:[UIImage imageNamed:@"search_active.png"]];
    }
    else
    {
        [(UIButton *)[blueView_ viewWithTag:5] setImage:nil forState:UIControlStateNormal];
        [(UIButton *)[blueView_ viewWithTag:5] setImage:nil forState:UIControlStateHighlighted];
        
        [(UIImageView *)[(UIButton *)[blueView_ viewWithTag:5] viewWithTag:15] setImage:[UIImage imageNamed:@"search.png"]];
    }
}

- (void)pressButton:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] || [sender tag] == 3 || [sender tag] == 1)
    {
        [self reloadButtonImageWithIndex:[sender tag]];
    
        if ([sender tag] < 3)
        {
            [self setSelectedIndex:[sender tag] - 1];
            [[[self viewControllers] objectAtIndex:[sender tag] - 1] popToRootViewControllerAnimated:NO];
        }
    
        if ([sender tag] > 3)
        {
            [self setSelectedIndex:[sender tag] - 2];
            [[[self viewControllers] objectAtIndex:[sender tag] - 2] popToRootViewControllerAnimated:NO];
        }
    
        if ([sender tag] == 3)
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
                {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^
                    {
                        [self presentCamera];
                    }];
                }
                else
                {
                    [self presentCamera];
                }
            }
        }
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        KIALoginViewController *loginViewController = (KIALoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clearAll" object:nil];
}

- (void)presentCamera
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    
    UIImageView *leftLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_camera.png"]];
    [leftLine setFrame:CGRectMake(15, 80, 5, IS_IPHONE_5 ? 400 : 280)];
    [[pickerController view] addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_camera.png"]];
    [rightLine setFrame:CGRectMake(300, 80, 5, IS_IPHONE_5 ? 400 : 280)];
    [[pickerController view] addSubview:rightLine];
    
    [self presentViewController:pickerController animated:YES completion:nil];
}

# pragma mark ***** image picker controller *****

- (void)saveImageInDocumentFolderWithImage:(UIImage *)imageToSave
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"photo"];
    
    NSData *binaryImageData = UIImageJPEGRepresentation(imageToSave, 1.0f);
    
    NSError *error;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])	// Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error])
        {
            NSLog(@"Create directory error: %@", error);
        }
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", [formatter stringFromDate:[NSDate date]]]];
    
    [[NSFileManager defaultManager] createFileAtPath:path
                                            contents:binaryImageData
                                          attributes:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    originalImage = nil;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (originalImage == nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (originalImage == nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    
    [self saveImageInDocumentFolderWithImage:originalImage];
    
    [picker dismissViewControllerAnimated:NO completion:^
    {
        [self performSegueWithIdentifier:@"recognizeVC" sender:self];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self setSelectedIndex:0];
    [[[self viewControllers] objectAtIndex:0] popToRootViewControllerAnimated:NO];
    
    [self reloadButtonImageWithIndex:1];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"recognizeVC"])
    {
        capturedReceiptViewController = (KIACapturedReceiptViewController *)[segue destinationViewController];
        [capturedReceiptViewController setPhoto:originalImage];
        [capturedReceiptViewController setTitleText:@"Captured Receipt"];
    }
}

@end
