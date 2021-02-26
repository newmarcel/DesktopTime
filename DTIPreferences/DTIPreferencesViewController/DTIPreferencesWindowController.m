//
//  DTIPreferencesWindowController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 29.01.21.
//

#import "DTIPreferencesWindowController.h"
#import "DTIDefines.h"

@interface DTIPreferencesWindowController ()
@end

@implementation DTIPreferencesWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Window auto save identifier
    self.windowFrameAutosaveName = @"DTIPreferencesWindow";
    
    // Split auto save identifier
    Auto splitViewController = (NSSplitViewController *)self.contentViewController;
    splitViewController.splitView.autosaveName = @"DTIPreferencesSplit";
}

- (IBAction)completelyTerminate:(id)sender
{
    Auto center = DTINotificationCenter.defaultCenter;
    [center postNotification:DTIAppShouldTerminateNotification];
    [NSApplication.sharedApplication terminate:sender];
}

- (IBAction)showAboutPanel:(nullable id)sender
{
    Auto appName = NSLocalizedString(@"DesktopTime", @"DesktopTime");
    [NSApplication.sharedApplication orderFrontStandardAboutPanelWithOptions:@{
        NSAboutPanelOptionApplicationName: appName
    }];
}

@end
