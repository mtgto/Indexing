//
//  Channel.h
//  Indexing
//
//  Created by mtgto on 5/27/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * identity;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * contactUrl;
@property (nonatomic, strong) NSString * genre;
@property (nonatomic, strong) NSString * detailMessage;
@property (nonatomic, assign) int viewCount;
@property (nonatomic, assign) int relayCount;
@property (nonatomic, assign) int bitrate;
@property (nonatomic, strong) NSString * contentType;
@property (nonatomic, strong) NSDate * startDate;
@property (nonatomic, strong) NSString * statusMessage;
@property (nonatomic, strong) NSString * comment;

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
           comment:(NSString *)comment;
@end
