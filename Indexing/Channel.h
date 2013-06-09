//
//  Channel.h
//  Indexing
//
//  Created by mtgto on 6/9/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YellowPage;

@interface Channel : NSManagedObject

@property (nonatomic, retain) NSString * identity;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * contactUrl;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSString * detailMessage;
@property (nonatomic) int32_t viewCount;
@property (nonatomic) int32_t relayCount;
@property (nonatomic) int32_t bitrate;
@property (nonatomic, retain) NSString * contentType;
@property (nonatomic, retain) id startDate;
@property (nonatomic, retain) NSString * statusMessage;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) YellowPage *yellowPage;

@end
