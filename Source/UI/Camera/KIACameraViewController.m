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
    
    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    [self setDelegate:self];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    [leftLine setFrame:CGRectMake(15, 50, 7, 400)];
    [[self view] addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    [rightLine setFrame:CGRectMake(305, 50, 7, 400)];
    [[self view] addSubview:rightLine];
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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KIACapturedReceiptViewController *capturedReceiptViewController = (KIACapturedReceiptViewController *)[storyboard instantiateViewControllerWithIdentifier:@"capturedReceipt"];
    [capturedReceiptViewController setPhoto:originalImage];
    [self presentViewController:capturedReceiptViewController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
