//
//  Channel.m
//  Indexing
//
//  Created by mtgto on 5/27/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "Channel.h"

@implementation Channel

- (id)initWithName:(NSString *)name
          identity:(NSString *)identity
           address:(NSString *)address
        contactUrl:(NSString *)contactUrl
             genre:(NSString *)genre
     detailMessage:(NSString *)detailMessage
         viewCount:(int)viewCount
        relayCount:(int)relayCount
           bitrate:(int)bitrate
       contentType:(NSString *)contentType
         startDate:(NSDate *)startDate
     statusMessage:(NSString *)statusMessage
           comment:(NSString *)comment {
    if (self = [super init]) {
        self.identity = identity;
        self.address = address;
        self.contactUrl = contactUrl;
        self.genre = genre;
        self.detailMessage = detailMessage;
        self.viewCount = viewCount;
        self.relayCount = relayCount;
        self.bitrate = bitrate;
        self.contentType = contentType;
        self.startDate = startDate;
        self.statusMessage = statusMessage;
        self.comment = comment;
    }
    return self;
}

@end
