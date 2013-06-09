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
#import "MTTimeIntervalFormatter.h"

@interface MTYellowPageClient()

- (Channel *)channelByComponents:(NSArray *)components yellowPage:(YellowPage *)yellowPage;

@end

@implementation MTYellowPageClient

- (void)getChannelsByURL:(NSURL *)url yellowPage:(YellowPage *)yellowPage success:(void (^)(NSArray *channels))success failure:(void (^)(NSError *error))error {
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
                                                  Channel *channel = [self channelByComponents:components yellowPage:yellowPage];
                                                  [channels addObject:channel];
                                              }
                                              success(channels);
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              DDLogWarn(@"error = %@", error);
                                          }];
}

- (Channel *)channelByComponents:(NSArray *)components yellowPage:(YellowPage *)yellowPage {
    NSDate *startDate = [MTTimeIntervalFormatter parseString:components[15]];
    Channel *channel = [Channel MR_createEntity];
    channel.yellowPage = yellowPage;
    channel.name = components[0];
    channel.identity = components[1];
    channel.address  = components[2];
    channel.contactUrl = components[3];
    channel.genre = components[4];
    channel.detailMessage = components[5];
    channel.viewCount = [components[6] intValue];
    channel.relayCount = [components[7] intValue];
    channel.bitrate = [components[8] intValue];
    channel.contentType = components[9];
    channel.startDate = startDate;
    channel.statusMessage = components[16];
    channel.comment = components[17];
    return channel;
}

@end
