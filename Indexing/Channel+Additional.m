//
//  Channel+Additional.m
//  Indexing
//
//  Created by mtgto on 6/9/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "Channel+Additional.h"

@implementation Channel (Additional)

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
