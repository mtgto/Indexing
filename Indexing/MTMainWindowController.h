//
//  MTMainWindowController.h
//  Indexing
//
//  Created by mtgto on 5/27/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MTOutlineView.h"
#import "MTBookmarkWindowController.h"

@interface MTMainWindowController : NSWindowController<NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (nonatomic, strong) NSArray *topLevelItems;
@property (nonatomic, strong) NSMutableArray *yellowPages;
@property (nonatomic, strong) NSMutableArray *bookmarks;
@property (nonatomic, strong) NSMutableDictionary *channelDictionary;
@property (weak) IBOutlet MTOutlineView *bookmarkOutlineView;
@property (strong) IBOutlet NSArrayController *channelArrayController;
@property (weak) IBOutlet NSTableView *channelTableView;
@property (strong) IBOutlet NSMenu *bookmarkMenu;
@property (strong) IBOutlet MTBookmarkWindowController *bookmarkWindowController;

- (IBAction)reload:(id)sender;
- (IBAction)editBookmark:(id)sender;
- (IBAction)deleteBookmark:(id)sender;

@end
