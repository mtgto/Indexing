//
//  MTOutlineView.m
//  Indexing
//
//  Created by mtgto on 6/9/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "MTOutlineView.h"

@implementation MTOutlineView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSMenu*)menuForEvent:(NSEvent*)evt {
    NSPoint pt = [self convertPoint:[evt locationInWindow] fromView:nil];
    NSInteger row = [self rowAtPoint:pt];
    id item = [self itemAtRow:row];
    if ([item isKindOfClass:[Bookmark class]]) {
        self.selected = item;
        return [super menuForEvent:evt];
    }
    return nil;
}

@end
