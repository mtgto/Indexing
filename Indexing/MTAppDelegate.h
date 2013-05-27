//
//  MTAppDelegate.h
//  Indexing
//
//  Created by mtgto on 5/26/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MTPreferencesWindowController.h"

@interface MTAppDelegate : NSObject <NSApplicationDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
