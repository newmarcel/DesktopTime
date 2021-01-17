//
//  DTIAppDelegate.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTIAppDelegate.h"
#import "DTITimeWindowController.h"

@interface DTIAppDelegate ()
@property (nonatomic) NSHashTable<DTITimeWindowController *> *timeWindowControllers;
@end

@implementation DTIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    self.timeWindowControllers = [NSHashTable weakObjectsHashTable];
    
    id ctl = [DTITimeWindowController new];
    [self.timeWindowControllers addObject:ctl];
    
    [ctl showWindow:self];
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
