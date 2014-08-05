//
//  NIXLogManager.m
//  NIXLogManager
//
//  Created by Egor Zubkov on 5/13/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#if !__has_feature(objc_arc)
#error NIXLogManager must be built with ARC.
// You can turn on ARC for only NIXLogManager files by adding -fobjc-arc to the build phase for each of its files.
#endif

#import "NIXLogManager.h"

@interface NIXLogManager ()

@property(nonatomic, assign) BOOL logIsRedirectedToFile;
@property(nonatomic, strong) NSFileHandle *logFileHandle;
@property(nonatomic, strong) NSDateFormatter *logDateFormatter;

- (void)printString:(NSString *)str;

@end

@implementation NIXLogManager

@synthesize logIsRedirectedToFile;
@synthesize logFileHandle;
@synthesize logDateFormatter;

- (id)init
{
    if ((self = [super init]) != nil)
    {
        CFShow(@"NIXLogManager - init");

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        [self setLogDateFormatter:dateFormatter];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)addLogStringWithMessage:(NSString *)theFirstObject, ...
{
    va_list args;
    va_start(args, theFirstObject);
    NSString *tmpString = [[NSString alloc] initWithFormat:theFirstObject arguments:args];
    va_end(args);
    
    [self printString:tmpString];
}

- (void)addLogStringWithFunction:(const char *)theFunctionName
							line:(NSInteger)theLine
						 message:(NSString *)theFirstObject, ...
{
    NSMutableString *resultString;
	
    va_list args;
    va_start(args, theFirstObject);
    NSString *tmpString = [[NSString alloc] initWithFormat:theFirstObject arguments:args];
    va_end(args);
	
    if (theLine != -1)
    {
        resultString = [[NSMutableString alloc] initWithFormat:@"%s [Line %ld]", theFunctionName, (long)theLine];
    }
    else
    {
        resultString = [[NSMutableString alloc] initWithFormat:@"%s", theFunctionName];
    }
	
    if ([tmpString length])
    {
        [resultString appendFormat:@" - %s", [tmpString UTF8String]];
    }
    
    [self printString:resultString];
}

- (void)redirectLogToFile:(NSString *)thePathToFile
{
    [self setLogIsRedirectedToFile:YES];
    
    // save previous log file
    NSString *prevLogFilePath = [[thePathToFile stringByDeletingPathExtension] stringByAppendingPathExtension:@"prev.log"];
    [[NSFileManager defaultManager] removeItemAtPath:prevLogFilePath error:nil];
    [[NSFileManager defaultManager] copyItemAtPath:thePathToFile toPath:prevLogFilePath error:nil];
    
    // clean up existent file
    [@"" writeToFile:thePathToFile atomically:YES encoding:NSUnicodeStringEncoding error:nil];
    
    [self setLogFileHandle:[NSFileHandle fileHandleForWritingAtPath:thePathToFile]];
}

- (NSString *)logFromFile:(NSString *)theFileName
{
    return [NSString stringWithContentsOfFile:theFileName encoding:NSUnicodeStringEncoding error:nil];
}

#pragma mark - Private Methods

- (void)printString:(NSString *)str
{
    if ([self logIsRedirectedToFile])
    {
        NSString *stringToWrite = [NSString stringWithFormat:@"[%@]: %@\n", [logDateFormatter stringFromDate:[NSDate date]], str];
        NSData *dataToWrite = [stringToWrite dataUsingEncoding:NSUnicodeStringEncoding];
        
        [logFileHandle seekToEndOfFile];
        [logFileHandle writeData:dataToWrite];
    }
    else
    {
        CFShow((__bridge CFTypeRef)(str));
    }
}

#pragma mark - Singleton object methods

+ (NIXLogManager *)sharedInstance
{
    static dispatch_once_t pred;
    static NIXLogManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^
    {
        sharedInstance = [[NIXLogManager alloc] init];
    });
    
    return sharedInstance;
}

@end