//
//  MTBookmarkWindowController.m
//  Indexing
//
//  Created by mtgto on 6/9/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "MTBookmarkWindowController.h"
#import "Bookmark.h"

@interface MTBookmarkWindowController ()

@end

@implementation MTBookmarkWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"MTBookmarkWindowController"];
    if (self) {
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)showWindow:(id)sender {
    if (self.bookmark) {
        self.name = self.bookmark.name;
        self.predicate = self.bookmark.predicate;
    } else {
        self.name = @"";
        self.predicate = [NSPredicate predicateWithFormat:@"(name contains '')"];
    }
    [super showWindow:sender];
}

- (IBAction)addBookmark:(id)sender {
    Bookmark *bookmark = self.bookmark;
    if (!bookmark) {
        bookmark = [Bookmark MR_createEntity];
    }
    bookmark.name = self.name;
    bookmark.predicate = self.predicate;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self close];
}

- (IBAction)cancel:(id)sender {
    self.bookmark = nil;
    [self close];
}
@end
