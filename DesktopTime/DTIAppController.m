//
//  DTIAppController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTIAppController.h"
#import "DTITimeWindowController.h"
#import "DTIDefines.h"

@interface DTIAppController ()
@property (nonatomic) NSHashTable<DTITimeWindowController *> *timeWindowControllers;
@end

@implementation DTIAppController

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    Auto controllers = [NSHashTable weakObjectsHashTable];
    
    for(NSScreen *screen in NSScreen.screens)
    {
        Auto controller = [DTITimeWindowController new];
        controller.targetScreen = screen;
        [controllers addObject:controller];
        [controller showWindow:self];
    }
    
    self.timeWindowControllers = controllers;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    [NSWorkspace.sharedWorkspace dti_openPreferencesWithCompletionHandler:nil];
    return NO;
}

@end
