//
//  MTTimeIntervalFormatter.m
//  Indexing
//
//  Created by mtgto on 6/2/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "MTTimeIntervalFormatter.h"

@implementation MTTimeIntervalFormatter

+ (NSDate *)parseString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    int hour, minute;
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@":"]];
    if ([scanner scanInt:&hour] && [scanner scanInt:&minute]) {
        return [NSDate dateWithTimeIntervalSinceNow:-(hour * 3600 + minute * 60)];
    } else {
        return nil;
    }
}

- (NSString *)stringForObjectValue:(id)anObject {
    if ([anObject isKindOfClass:[NSDate class]]) {
        long interval = (long)-[(NSDate *)anObject timeIntervalSinceNow];
        return [NSString stringWithFormat:@"%ld:%02ld", interval / 3600, interval / 60 % 60];
    } else {
        return nil;
    }
}

- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString  **)error {
    NSDate *date = [MTTimeIntervalFormatter parseString:string];
    if (date) {
        *obj = date;
        return YES;
    } else {
        return NO;
    }
}

@end
