//
//  MTPreferencesWindowController.h
//  Indexing
//
//  Created by mtgto on 5/26/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MTPreferencesWindowController : NSWindowController
@property (strong) IBOutlet NSArrayController *yellowPageArrayController;
@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *urlTextField;
- (IBAction)addYellowPage:(id)sender;

@end
