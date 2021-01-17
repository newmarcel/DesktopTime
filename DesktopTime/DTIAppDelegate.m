//
//  DTIAppDelegate.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTIAppDelegate.h"

@interface DTIAppDelegate ()
@property (weak, nonatomic) IBOutlet NSWindow *window;
@end

@implementation DTIAppDelegate

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
