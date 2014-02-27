// ************************************************ //
//                                                  //
//  KIACameraViewController.m                       //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/20/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIACameraViewController.h"

#import "KIACapturedReceiptViewController.h"
#import "KIATabBarViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface KIACameraViewController ()

@end

@implementation KIACameraViewController

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
	// Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    [self setDelegate:self];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    [leftLine setFrame:CGRectMake(15, 80, 5, IS_IPHONE_5 ? 400 : 280)];
    [[self view] addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    [rightLine setFrame:CGRectMake(300, 80, 5, IS_IPHONE_5 ? 400 : 280)];
    [[self view] addSubview:rightLine];
}

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
    UIImage *originalImage = nil;
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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KIACapturedReceiptViewController *capturedReceiptViewController = (KIACapturedReceiptViewController *)[storyboard instantiateViewControllerWithIdentifier:@"capturedReceipt"];
    [capturedReceiptViewController setPhoto:originalImage];
    [self presentViewController:capturedReceiptViewController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    KIATabBarViewController *tabBarVC = (KIATabBarViewController *)[self presentingViewController];
    
    [tabBarVC setSelectedIndex:0];
    [[[tabBarVC viewControllers] objectAtIndex:0] popToRootViewControllerAnimated:NO];
    
    [tabBarVC reloadButtonImageWithIndex:1];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return nil;
}

@end
