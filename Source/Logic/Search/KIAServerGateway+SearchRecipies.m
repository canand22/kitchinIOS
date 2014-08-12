//
//  KIAServerGateway+SearchRecipies.m
//  KitchInApp
//
//  Created by DeMoN on 8/12/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAServerGateway+SearchRecipies.h"

#import "RestKit.h"

#import "KIASearchRecipiesMapping.h"

@implementation KIAServerGateway (SearchRecipies)

- (void)logoutWithDelegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithSearchResipiesWithDelegate:delegate];
}

- (void)setupSearchRecipiesMapping
{
    // create mapping
    RKObjectMapping *logoutMapping = [KIASearchRecipiesMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:logoutMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:@"/KitchInAppService.svc/:id"
                                                                                   keyPath:@""
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (void)postQueryWithSearchResipiesWithDelegate:(id<serverGatewayDelegate>)delegate
{
    [self setupSearchRecipiesMapping];
    
    // выполнение запроса
    [[self objectManager] getObject:nil
                               path:[NSString stringWithFormat:@"/KitchInAppService.svc/Recipies?cookwith=%@&cookwithout=%@&allergies=%@&diets=%@&cuisine=%@&dishtype=%@&holiday=%@&meal=%@&time=%@"]
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                            {
                                NSLog(@"Success!!!");
         
                                NSArray *result = [mappingResult array];
                                /*
                                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"sessionId"];
                                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"firstName"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
         
                                [delegate loginSuccess:[[result objectAtIndex:0] IsSuccessfully]];*/
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error)
                            {
                                KIASearchRecipiesMapping *errorResponse = nil;
         
                                if ([error code] == kCFURLErrorBadServerResponse)
                                {
                                    // There was a custom error
                                    errorResponse = [[operation mappingResult] firstObject];
             
                                    NSLog(@"Failure: %d", kCFURLErrorBadServerResponse);
                                }
         
                                NSLog(@"Failure: %@", [error localizedDescription]);
                            }];
}

@end
