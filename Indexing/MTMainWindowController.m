//
//  MTMainWindowController.m
//  Indexing
//
//  Created by mtgto on 5/27/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "MTMainWindowController.h"
#import "MTYellowPageClient.h"
#import "YellowPage.h"
#import "Bookmark.h"

@interface MTMainWindowController ()

@end

@implementation MTMainWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    self.topLevelItems = @[@"YP", @"Bookmarks"];
    self.yellowPages = [[YellowPage MR_findAll] mutableCopy];
    self.bookmarks = [[Bookmark MR_findAll] mutableCopy];
    self.channelDictionary = [NSMutableDictionary dictionary];
    [self.bookmarkOutlineView sizeLastColumnToFit];
    [self.bookmarkOutlineView reloadData];
    [self.bookmarkOutlineView setFloatsGroupRows:NO];
    [self.bookmarkOutlineView setRowSizeStyle:NSTableViewRowSizeStyleDefault];
    // Expand all the root items; disable the expansion animation that normally happens
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0];
    [self.bookmarkOutlineView expandItem:nil expandChildren:YES];
    [NSAnimationContext endGrouping];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(managedObjectChanged:)
                                                 name:NSManagedObjectContextObjectsDidChangeNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextObjectsDidChangeNotification
                                                  object:nil];
}

- (IBAction)reload:(id)sender {
    for (YellowPage *yp in self.yellowPages) {
        NSURL *url = [NSURL URLWithString:@"index.txt" relativeToURL:[NSURL URLWithString:yp.url]];
        [[[MTYellowPageClient alloc] init] getChannelsByURL:url success:^(NSArray *channels) {
            DDLogInfo(@"yp[%@] channels = %@", yp.name, channels);
            self.channelDictionary[yp.name] = channels;
            //[self.channelArrayController setContent:channels];
        } failure:^(NSError *error) {
            DDLogWarn(@"error = %@", error);
        }];
    }
}

- (IBAction)editBookmark:(id)sender {
    self.bookmarkWindowController.bookmark = self.bookmarkOutlineView.selected;
    [self.bookmarkWindowController showWindow:self];
}

- (IBAction)deleteBookmark:(id)sender {
    [self.bookmarkOutlineView.selected MR_deleteEntity];
}

- (NSArray *)_childrenForItem:(id)item {
    NSArray *children = nil;
    if (item == nil) {
        children = self.topLevelItems;
    } else if ([item isEqual:@"YP"]){
        children = self.yellowPages;
    } else if ([item isEqual:@"Bookmarks"]){
        children = self.bookmarks;
    } else {
        DDLogError(@"Unsupported item: %@", item);
    }
    return children;
}

#pragma mark - NSOutlineViewDataSource
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    return [[self _childrenForItem:item] objectAtIndex:index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    if ([outlineView parentForItem:item] == nil) {
        return YES;
    } else {
        return NO;
    }
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    return [[self _childrenForItem:item] count];
}
/*
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
    return (item == nil) ? @"/" : @"fuga/";
}

- (void)outlineView:(NSOutlineView *)outlineView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
    
}
*/

#pragma mark - NSOutlineViewDelegate
- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return [self.topLevelItems containsObject:item];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldShowOutlineCellForItem:(id)item {
    // ROOT: Show/Hide text
    // CHILD: Right Triangle
    return NO;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    if ([self.topLevelItems containsObject:item])
        return NO;
    else
        return YES;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    // For the groups, we just return a regular text view.
    if ([self.topLevelItems containsObject:item]) {
        NSTableCellView *result = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
        // Uppercase the string value, but don't set anything else. NSOutlineView automatically applies attributes as necessary
        NSString *value = [item uppercaseString];
        result.textField.stringValue = value;
        return result;
    } else {
        // The cell is setup in IB. The textField and imageView outlets are properly setup.
        // Special attributes are automatically applied by NSTableView/NSOutlineView for the source list
        NSTableCellView *result = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
        if ([item isKindOfClass:[YellowPage class]]) {
            YellowPage *yp = (YellowPage *)item;
            result.textField.stringValue = yp.name;
        } else if ([item isKindOfClass:[Bookmark class]]) {
            Bookmark *bookmark = (Bookmark *)item;
            result.textField.stringValue = bookmark.name;
            result.menu = self.bookmarkMenu;
            result.textField.menu = self.bookmarkMenu;
        }
        // Setup the icon based on our section
        id parent = [outlineView parentForItem:item];
        NSInteger index = [_topLevelItems indexOfObject:parent];
        NSInteger iconOffset = index % 4;
        switch (iconOffset) {
            case 0: {
                result.imageView.image = [NSImage imageNamed:NSImageNameBookmarksTemplate];
                break;
            }
            case 1: {
                result.imageView.image = [NSImage imageNamed:NSImageNameSmartBadgeTemplate];
                break;
            }
        }
        return result;
    }
}

#pragma mark - Notification
- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    DDLogInfo(@"outlineViewSelectionDidChange:%@", [self.bookmarkOutlineView itemAtRow:self.bookmarkOutlineView.selectedRow]);
    YellowPage *yp = [self.bookmarkOutlineView itemAtRow:self.bookmarkOutlineView.selectedRow];
    NSArray *channels = self.channelDictionary[yp.name];
    if (channels) {
        [self.channelArrayController setContent:channels];
    }
}

- (void)managedObjectChanged:(NSNotification *)notification {
    DDLogInfo(@"managedObjectChanged: %@", [notification userInfo]);
    self.yellowPages = [[YellowPage MR_findAll] mutableCopy];
    self.bookmarks = [[Bookmark MR_findAll] mutableCopy];
    [self.bookmarkOutlineView reloadData];
}

@end
