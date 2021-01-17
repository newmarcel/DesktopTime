//
//  DTIAppDelegate.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTIAppDelegate.h"
#import "DTITimeWindowController.h"
#import "DTIDefines.h"

@interface DTIAppDelegate ()
@property (nonatomic) NSHashTable<DTITimeWindowController *> *timeWindowControllers;
@end

@implementation DTIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    Auto controllers = [NSHashTable weakObjectsHashTable];
    Auto controller = [DTITimeWindowController new];
    [controllers addObject:controller];
    [controller showWindow:self];
    
    self.timeWindowControllers = controllers;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    [sender terminate:self];
    return NO;
}

@end
