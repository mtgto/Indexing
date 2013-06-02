//
//  MTYellowPageClient.h
//  Indexing
//
//  Created by mtgto on 5/30/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTYellowPageClient : NSObject

- (void)getChannelsByURL:(NSURL *)url success:(void (^)(NSArray *channels))success failure:(void (^)(NSError *error))error;

@end
