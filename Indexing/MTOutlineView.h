//
//  MTOutlineView.h
//  Indexing
//
//  Created by mtgto on 6/9/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Bookmark.h"

@interface MTOutlineView : NSOutlineView

@property (nonatomic, assign) Bookmark *selected;

@end
