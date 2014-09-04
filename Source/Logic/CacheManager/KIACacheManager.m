//
//  KIACacheManager.m
//  UpForCoffee
//
//  Created by DeMoN on 5/29/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIACacheManager.h"

@implementation KIACacheManager

static KIACacheManager *manager = nil;

+ (KIACacheManager *)sharedCacheManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        manager = [[KIACacheManager alloc] init];
    });
        
    return manager;
}

- (BOOL)saveCacheImage:(UIImage *)image forIdentifier:(NSString *)identifier
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png", directory, identifier];
    
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];
    
    BOOL success = [data writeToFile:pngFilePath atomically:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UICacheManagerSaveNotification object:nil];
    
    return success;
}

- (UIImage *)fetchCacheImageForIdentifier:(NSString *)identifier
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png", directory, identifier];
    
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:pngFilePath]];
    
    return image;
}

- (BOOL)checkImageForCacheWithIdentifier:(NSString *)identifier
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", identifier]]])
    {
        return YES;
    }
    
    return NO;
}

@end
