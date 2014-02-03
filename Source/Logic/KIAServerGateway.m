// ************************************************ //
//                                                  //
//  KIAServerGateway.m                              //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 12/26/13.                   //
//  Copyright (c) 2013 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIAServerGateway.h"

#import "RestKit.h"

@interface KIAServerGateway (PRIVATE)

@end

@implementation KIAServerGateway

+ (id)gateway
{
    return [[[self class] alloc] init];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        if (!_objectManager)
        {
            [self setupEnvironment];
            [self setUpDataBase];
        }
    }
    
    return self;
}

- (void)setupEnvironment
{
    // setup logging
    RKLogConfigureByName("RestKit", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
    
    // create HTTP client and object manager
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient setDefaultHeader:DEFAULT_HEADER value:RKMIMETypeJSON];
    
    RKObjectManager *manager = [[RKObjectManager alloc] initWithHTTPClient:httpClient];
    [[RKObjectManager sharedManager] setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    [self setObjectManager:manager];
    
    [self setUpDataBase];
}

- (void)setUpDataBase
{
    // setup managedobject store
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"KitchInModel.xcdatamodeld"];
    
    NSError *error = nil;
    
    [[self objectManager] setManagedObjectStore:managedObjectStore];
    [[[self objectManager] managedObjectStore] addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    
    if (error != nil)
    {
        NSLog(@"\nSerious object store error!\n%@\n", [error localizedDescription]);
        return;
    }
    else
    {
        [[[self objectManager] managedObjectStore] createManagedObjectContexts];
    }
}

@end
