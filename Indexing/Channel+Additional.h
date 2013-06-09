//
//  Channel+Additional.h
//  Indexing
//
//  Created by mtgto on 6/9/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "Channel.h"
#import "YellowPage.h"
#import "MTTimeIntervalFormatter.h"

@interface Channel (Additional)

- (Channel *)channelByComponents:(NSArray *)components yellowPage:(YellowPage *)yellowPage;

@end
