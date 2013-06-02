//
//  MTYellowPageClient.m
//  Indexing
//
//  Created by mtgto on 5/30/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "MTYellowPageClient.h"
#import <AFNetworking/AFHTTPClient.h>
#import "Channel.h"

@implementation MTYellowPageClient

- (void)getChannelsByURL:(NSURL *)url success:(void (^)(NSArray *channels))success failure:(void (^)(NSError *error))error {
    [[AFHTTPClient clientWithBaseURL:url] getPath:url.path
                                       parameters:nil
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                              NSArray* lines = [str componentsSeparatedByCharactersInSet:
                                                                [NSCharacterSet newlineCharacterSet]];
                                              NSMutableArray* channels = [NSMutableArray arrayWithCapacity:lines.count];
                                              for (NSString *line in lines) {
                                                  NSArray *components = [line componentsSeparatedByString:@"<>"];
                                                  if (components.count < 18) break;
                                                  Channel *channel = [[Channel alloc] initWithName:components[0]
                                                                                          identity:components[1]
                                                                                           address:components[2]
                                                                                        contactUrl:components[3]
                                                                                             genre:components[4]
                                                                                     detailMessage:components[5]
                                                                                         viewCount:[components[6] intValue]
                                                                                        relayCount:[components[7] intValue]
                                                                                           bitrate:[components[8] intValue]
                                                                                       contentType:components[9]
                                                                                         startDate:[NSDate date]//components[15]
                                                                                     statusMessage:components[16]
                                                                                           comment:components[17]];
                                                  [channels addObject:channel];
                                              }
                                              success(channels);
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              DDLogWarn(@"error = %@", error);
                                          }];
}

@end
