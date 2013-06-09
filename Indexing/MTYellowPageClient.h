//
//  MTYellowPageClient.h
//  Indexing
//
//  Created by mtgto on 5/30/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YellowPage.h"

@interface MTYellowPageClient : NSObject

- (void)getChannelsByURL:(NSURL *)url yellowPage:(YellowPage *)yellowPage success:(void (^)(NSArray *channels))success failure:(void (^)(NSError *error))error;

@end
