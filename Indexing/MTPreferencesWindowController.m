//
//  MTPreferencesWindowController.m
//  Indexing
//
//  Created by mtgto on 5/26/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "MTPreferencesWindowController.h"

@interface MTPreferencesWindowController ()

@end

@implementation MTPreferencesWindowController

- (id)init
{
    return [super initWithWindowNibName:@"MTPreferencesWindowController"];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    [self.yellowPageArrayController setManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
}

- (IBAction)addYellowPage:(id)sender {
    YellowPage *yp = [YellowPage MR_createEntity];
    yp.name = self.nameTextField.stringValue;
    yp.url = self.urlTextField.stringValue;
}
@end
