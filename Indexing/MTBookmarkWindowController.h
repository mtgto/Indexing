//
//  MTBookmarkWindowController.h
//  Indexing
//
//  Created by mtgto on 6/9/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Bookmark.h"

@interface MTBookmarkWindowController : NSWindowController
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSPredicate *predicate;
@property (nonatomic, strong) Bookmark *bookmark;
- (IBAction)addBookmark:(id)sender;
- (IBAction)cancel:(id)sender;

@end
