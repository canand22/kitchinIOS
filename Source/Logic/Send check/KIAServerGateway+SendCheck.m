// ************************************************ //
//                                                  //
//  KIAServerGateway+SendCheck.m                    //
//  KitchInApp                                      //
//                                                  //
//  Created by DeMoN on 1/11/14.                    //
//  Copyright (c) 2014 NIX. All rights reserved.    //
//                                                  //
// ************************************************ //

#import "KIAServerGateway+SendCheck.h"

#import "RestKit.h"

#import "KIAServerGateway.h"
#import "KIAImageMapping.h"
#import "KIASendCheckMapping.h"

#import "NSData+Base64.h"

@implementation KIAServerGateway (SendCheck)

@dynamic delegate;

- (void)sendCheckWithImage:(UIImage *)image storeID:(NSUInteger)storeID delegate:(id<serverGatewayDelegate>)theDelegate
{
    [self postQueryWithImage:image storeID:storeID delegate:theDelegate];
}

- (void)setupSendCheckMappingWithStoreId:(NSUInteger)storeID
{
    // create mapping
    RKObjectMapping *sendCheckMapping = [KIASendCheckMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:sendCheckMapping
                                                                                    method:RKRequestMethodPOST
                                                                               pathPattern:@"/KitchInAppService.svc/ListProducts"
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (RKRequestDescriptor *)setupRequestWithImage:(UIImage *)image storeID:(NSUInteger)storeID
{
    RKObjectMapping *imageMapping = [KIAImageMapping mapping];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[imageMapping inverseMapping]
                                                                                   objectClass:[KIAImageMapping class]
                                                                                   rootKeyPath:nil
                                                                                        method:RKRequestMethodPOST];
    
    [[self objectManager] addRequestDescriptor:requestDescriptor];
    
    return requestDescriptor;
}

- (void)postQueryWithImage:(UIImage *)image storeID:(NSUInteger)storeID delegate:(id<serverGatewayDelegate>)theDelegate
{
    RKRequestDescriptor *request = [self setupRequestWithImage:image storeID:storeID];
    
    [self setupSendCheckMappingWithStoreId:storeID];
    
    NSData *data = UIImageJPEGRepresentation(image, .6f);
    NSString *checkImage = [data base64EncodedString];
    
    KIAImageMapping *imageMapping = [KIAImageMapping new];
    [imageMapping setImageAsBase64String:checkImage];
    [imageMapping setStoreId:storeID];
    
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    // выполнение запроса
    [[self objectManager] postObject:imageMapping
                                path:@"/KitchInAppService.svc/ListProducts"
                          parameters:nil
                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                                {
                                    NSArray *result = [mappingResult array];
         
                                    CFTimeInterval elapsedTime = CFAbsoluteTimeGetCurrent() - startTime;
                                    
                                    if ([result count] > 0)
                                    {
                                        NSLog(@"aaaaaa Success!!! %fs", elapsedTime);
                                        
                                        [theDelegate showData:result];
                                    }
                                    else
                                    {
                                        NSLog(@"Success!!! %fs", elapsedTime);
                                        
                                        [theDelegate nullData];
                                    }
                                    
                                    [[self objectManager] removeRequestDescriptor:request];
                                }
                             failure:^(RKObjectRequestOperation *operation, NSError *error)
                                {
                                    KIASendCheckMapping *errorResponse = nil;
         
                                    if ([error code] == kCFURLErrorBadServerResponse)
                                    {
                                        // There was a custom error
                                        errorResponse = [[operation mappingResult] firstObject];
             
                                        NSLog(@"Failure: %d", kCFURLErrorBadServerResponse);
                                    }
         
                                    NSLog(@"Failure: %@", [error localizedDescription]);
                                    
                                    [[self objectManager] removeRequestDescriptor:request];
                                }];
}

@end
