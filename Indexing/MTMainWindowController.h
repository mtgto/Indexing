//
//  MTMainWindowController.h
//  Indexing
//
//  Created by mtgto on 5/27/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MTMainWindowController : NSWindowController<NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (nonatomic, strong) NSArray *topLevelItems;
@property (nonatomic, strong) NSDictionary *childrenDictionary;
@property (weak) IBOutlet NSOutlineView *bookmarkOutlineView;

- (IBAction)reload:(id)sender;

@end
