// ************************************************ //
//                                                  //
//  AppDelegate.m                                   //
//  NIXProject                                      //
//                                                  //
//  Created by Egor Zubkov on 1/22/13.              //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "AppDelegate.h"
#import "NIXCrashReporter.h"

@implementation AppDelegate

@synthesize window = window_;

- (BOOL)application:(UIApplication *)theApplication didFinishLaunchingWithOptions:(NSDictionary *)theLaunchOptions
{
    [NIXCrashReporter sendReportViaMail];
    
    /*
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"photo"];
   
    NSError *error;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])	// Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error])
        {
            NSLog(@"Create directory error: %@", error);
        }
    }
    
    if ([[NSFileManager defaultManager] copyItemAtPath:[documentsDirectory stringByAppendingPathComponent:@"2014-01-10 06:25:39 пп.jpg"]
                                                toPath:[path stringByAppendingPathComponent:@"2014-01-10 06:25:39 пп.jpg"]
                                                 error:nil])
    {
        NSLog(@"Copy successful");
    }
    
    if ([[NSFileManager defaultManager] copyItemAtPath:[documentsDirectory stringByAppendingPathComponent:@"2014-01-10 06:25:45 пп.jpg"]
                                                toPath:[path stringByAppendingPathComponent:@"2014-01-10 06:25:45 пп.jpg"]
                                                 error:nil])
    {
        NSLog(@"Copy successful");
    }
    */
    
    return YES;
}

@end
