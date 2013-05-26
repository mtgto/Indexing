//
//  MyTest.m
//  Indexing
//
//  Created by User on 5/27/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <GHUnitOSX/GHUnit.h>

@interface MyTest : GHTestCase
@end

@implementation MyTest

- (void)testStrings {
    NSString *string1 = @"a string";
    GHTestLog(@"I can log to the GHUnit test console: %@", string1);

    // Assert string1 is not NULL, with no custom error description
    GHAssertNotNil(string1, nil);

    // Assert equal objects, add custom error description
    NSString *string2 = @"a string";
    GHAssertEqualObjects(string1, string2, @"A custom error message. string1 should be equal to: %@.", string2);
}

@end
