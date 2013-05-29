//
//  MTMainWindowController.m
//  Indexing
//
//  Created by mtgto on 5/27/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "MTMainWindowController.h"

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
    self.childrenDictionary = @{@"YP": @[@"All", @"YP1", @"YP2"],
                                @"Bookmarks": @[@"ContentView1", @"ContentView2", @"ContentView3"]};
    [self.bookmarkOutlineView sizeLastColumnToFit];
    [self.bookmarkOutlineView reloadData];
    [self.bookmarkOutlineView setFloatsGroupRows:NO];
    [self.bookmarkOutlineView setRowSizeStyle:NSTableViewRowSizeStyleDefault];
    // Expand all the root items; disable the expansion animation that normally happens
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0];
    [self.bookmarkOutlineView expandItem:nil expandChildren:YES];
    [NSAnimationContext endGrouping];
}

- (IBAction)reload:(id)sender {
    NSDictionary *value = @{@"name": @"ch1", @"genre": @"genre1"};
//    [self.channelArrayController addObject:value];
    [self.channelArrayController setContent:@[value]];
    [self.channelTableView reloadData];
}

- (NSArray *)_childrenForItem:(id)item {
    NSArray *children;
    if (item == nil) {
        children = self.topLevelItems;
    } else {
        children = [self.childrenDictionary objectForKey:item];
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
        result.textField.stringValue = item;
        // Setup the icon based on our section
        id parent = [outlineView parentForItem:item];
        NSInteger index = [_topLevelItems indexOfObject:parent];
        NSInteger iconOffset = index % 4;
        switch (iconOffset) {
            case 0: {
                result.imageView.image = [NSImage imageNamed:NSImageNameIconViewTemplate];
                break;
            }
            case 1: {
                result.imageView.image = [NSImage imageNamed:NSImageNameHomeTemplate];
                break;
            }
            case 2: {
                result.imageView.image = [NSImage imageNamed:NSImageNameQuickLookTemplate];
                break;
            }
            case 3: {
                result.imageView.image = [NSImage imageNamed:NSImageNameSlideshowTemplate];
                break;
            }
        }
        return result;
    }
}

@end
