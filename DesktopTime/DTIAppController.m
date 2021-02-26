//
//  DTIAppController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTIAppController.h"
#import "DTIDefines.h"
#import "DTILayoutController.h"

@interface DTIAppController ()
@property (nonatomic) DTILayoutController *layoutController;
@end

@implementation DTIAppController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self configureNotifications];
    }
    return self;
}

#pragma mark - Notifications

- (void)configureNotifications
{
    Auto center = DTINotificationCenter.defaultCenter;
    [center addObserver:self
               selector:@selector(handleShouldTerminate:)
                   name:DTIAppShouldTerminateNotification];
    [center addObserver:self
               selector:@selector(handleLayoutDidChange:)
                   name:DTILayoutDidChangeNotification];
}

- (void)handleShouldTerminate:(NSNotification *)notification
{
    [NSApplication.sharedApplication terminate:notification];
}

- (void)handleLayoutDidChange:(NSNotification *)notification
{
    [self.layoutController reloadLayout];
}

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    Auto layoutController = [DTILayoutController new];
    [layoutController reloadLayout];
    [layoutController startTimer];
    self.layoutController = layoutController;
    
    [DTIPreferences.sharedPreferences performBlockOnFirstLaunch:^{
        Auto workspace = NSWorkspace.sharedWorkspace;
        Auto alert = NSAlert.dti_welcomeAlert;
        [alert dti_runWelcomeAlertWithOpenPreferencesHandler:^{
            [workspace dti_openPreferencesWithCompletionHandler:nil];
        }];
    }];
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
