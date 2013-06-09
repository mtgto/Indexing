//
//  MTAppDelegate.m
//  Indexing
//
//  Created by mtgto on 5/26/13.
//  Copyright (c) 2013 mtgto. All rights reserved.
//

#import "MTAppDelegate.h"
#import "MTMainWindowController.h"

@interface MTAppDelegate ()
@property (strong) MTMainWindowController *mainWindowController;
@end

@implementation MTAppDelegate

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    self.mainWindowController = [[MTMainWindowController alloc] initWithWindowNibName:@"MTMainWindowController"];
    [self.mainWindowController showWindow:self];
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "net.mtgto.Indexing" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"net.mtgto.Indexing"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Indexing" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) 
- (NSManagedObjectContext *)managedObjectContext
{
    return [NSManagedObjectContext MR_defaultContext];
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];

    return NSTerminateNow;
}

@end
