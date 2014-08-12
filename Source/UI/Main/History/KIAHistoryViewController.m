//
//  KIAHistoryViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/10/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAHistoryViewController.h"

#import "KIACapturedReceiptViewController.h"
#import "MyKitchInCell.h"

@interface KIAHistoryViewController ()

@end

@implementation KIAHistoryViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _photo = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self loadImage];
}

- (void)loadImage
{
    [_photo removeAllObjects];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"photo"];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    
    for (int i = (int)[directoryContent count] - 1; i >= 0; i--)
    {
        [_photo addObject:[directoryContent objectAtIndex:i]];
    }
}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (NSString *)formattedStringFromString:(NSString *)stringDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    NSString *strDate = [stringDate stringByDeletingPathExtension];
    NSDate *date = [formatter dateFromString:strDate];
    
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    return [formatter stringFromDate:date];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_photo count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollCell";
    
    MyKitchInCell *cell = (MyKitchInCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell)
    {
        [[cell title] setText:[self formattedStringFromString:[_photo objectAtIndex:[indexPath row]]]];
    
        [[cell deleteButton] setTag:[indexPath row]];
        [[cell deleteButton] addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
        dispatch_async(queue, ^
        {
            UIImage *image = [self imageWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", path, [_photo objectAtIndex:[indexPath row]]]] scaledToSize:CGSizeMake(90, 119)];
        
            dispatch_sync(dispatch_get_main_queue(), ^
            {
                [[cell image] setImage:image];
                [cell setNeedsLayout];
            });
        });
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KIACapturedReceiptViewController *capturedReceiptViewController = (KIACapturedReceiptViewController *)[storyboard instantiateViewControllerWithIdentifier:@"capturedReceipt"];
    [capturedReceiptViewController setPhoto:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", path, [_photo objectAtIndex:[indexPath row]]]]];
    [capturedReceiptViewController setTitleText:[self formattedStringFromString:[_photo objectAtIndex:[indexPath row]]]];
    [self presentViewController:capturedReceiptViewController animated:YES completion:nil];
}

- (void)deleteImage:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remove"
                                                    message:@"Are you sure?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    
    [alert setTag:[sender tag]];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"photo"] stringByAppendingPathComponent:[_photo objectAtIndex:[alertView tag]]];
    
        NSError *error;
    
        if ([[NSFileManager defaultManager] isDeletableFileAtPath:path])
        {
            BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        
            if (!success)
            {
                NSLog(@"Error removing file at path: %@", error.localizedDescription);
            }
            else
            {
                [self loadImage];
                [_collectionView reloadData];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
