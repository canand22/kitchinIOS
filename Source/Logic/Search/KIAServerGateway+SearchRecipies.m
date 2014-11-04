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

#import "KIASearchDefines.h"

@implementation KIAServerGateway (SearchRecipies)

- (void)sendSearchRecipiesForItem:(NSDictionary *)item page:(NSUInteger)page delegate:(id<serverGatewayDelegate>)delegate
{
    [self postQueryWithSearchResipiesItem:item page:page delegate:delegate];
}

- (void)setupSearchRecipiesMapping
{
    // create mapping
    RKObjectMapping *recipiesMapping = [KIASearchRecipiesMapping mapping];
    
    // create responce descriptor. Attention to pattern espesseally '/'
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:recipiesMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:nil
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [descriptor setBaseURL:[NSURL URLWithString:BASE_URL]];
    [[self objectManager] addResponseDescriptor:descriptor];
}

- (void)postQueryWithSearchResipiesItem:(NSDictionary *)item page:(NSUInteger)page delegate:(id<serverGatewayDelegate>)delegate
{
    [self setupSearchRecipiesMapping];
    
    // выполнение запроса
    [[self objectManager] getObject:nil
                               path:[[NSString stringWithFormat:@"/KitchInAppService.svc/Recipies?cookwith=%@&cookwithout=%@&allergies=%@&diets=%@&cuisine=%@&dishtype=%@&holiday=%@&meal=%@&time=%@&page=%lu&perpage=10", [item objectForKey:COOK_WITH], [item objectForKey:COOK_WITHOUT], [item objectForKey:ALLERGIES], [item objectForKey:DIETS], [item objectForKey:CUISINE], [item objectForKey:DISH_TYPE], [item objectForKey:HOLIDAY], [item objectForKey:MEAL], [item objectForKey:TIME], (unsigned long)page] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
                            {
                                NSLog(@"Success!!!");
         
                                NSArray *result = [mappingResult array];
         
                                [delegate showDic:[result objectAtIndex:0]];
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
