//
//  MTTimeIntervalFormatter.h
//  Indexing
//
//  Created by mtgto on 6/2/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTTimeIntervalFormatter : NSFormatter

/**
 * parse date string like "1:23"
 *
 * @param string string to be parsed. it consists of hour and minute, split by colon.
 */
+ (NSDate *)parseString:(NSString *)string;

@end
