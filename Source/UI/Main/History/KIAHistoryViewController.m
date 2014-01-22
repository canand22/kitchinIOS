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
        photo = [[NSMutableArray alloc] init];
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
    [photo removeAllObjects];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"photo"];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    
    for (int i = 0; i < [directoryContent count]; i++)
    {
        [photo addObject:[directoryContent objectAtIndex:i]];
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
    return [photo count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollCell";
    
    MyKitchInCell *cell = (MyKitchInCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [[cell image] setImage:[self imageWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", path, [photo objectAtIndex:[indexPath row]]]] scaledToSize:CGSizeMake(90, 119)]];
    
    [[cell title] setText:[self formattedStringFromString:[photo objectAtIndex:[indexPath row]]]];
    
    [[cell deleteButton] setTag:[indexPath row]];
    [[cell deleteButton] addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KIACapturedReceiptViewController *capturedReceiptViewController = (KIACapturedReceiptViewController *)[storyboard instantiateViewControllerWithIdentifier:@"capturedReceipt"];
    [capturedReceiptViewController setPhoto:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", path, [photo objectAtIndex:[indexPath row]]]]];
    [self presentViewController:capturedReceiptViewController animated:YES completion:nil];
}

- (void)deleteImage:(UIButton *)sender
{
    NSLog(@"%d", [sender tag]);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"photo"] stringByAppendingPathComponent:[photo objectAtIndex:[sender tag]]];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
