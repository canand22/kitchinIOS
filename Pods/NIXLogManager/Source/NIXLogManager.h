//
//  NIXLogManager.h
//  NIXLogManager
//
//  Created by Egor Zubkov on 5/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIXLogManager : NSObject

+ (NIXLogManager *)sharedInstance;

- (void)addLogStringWithMessage:(NSString *)theFirstObject, ...;

- (void)addLogStringWithFunction:(const char *)theFunctionName
                            line:(NSInteger)theLine
                         message:(NSString *)firstObject, ...;

- (void)redirectLogToFile:(NSString *)theFileName;

- (NSString *)logFromFile:(NSString *)theFileName;

@end