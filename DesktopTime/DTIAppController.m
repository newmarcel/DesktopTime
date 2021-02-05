//
//  DTIAppController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTIAppController.h"
#import "DTIDefines.h"
#import "DTITimeWindowController.h"

@interface DTIAppController ()
@property (nonatomic) NSHashTable<DTITimeWindowController *> *timeWindowControllers;
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
    [self reloadLayout];
}

#pragma mark - Layout Management

- (void)reloadLayout
{
    Auto preferences = DTIPreferences.sharedPreferences;
    [self createWindowsForLayout:preferences.layout];
}

- (void)createWindowsForLayout:(DTILayout *)layout
{
    NSParameterAssert(layout);
    
    Auto screens = NSScreen.screens;
    Auto mainScreen = NSScreen.mainScreen;
    
    switch(layout.displayMode)
    {
        case DTILayoutDisplayModeAllDisplays:
        {
            for(NSScreen *screen in screens)
            {
                [self createWindowsForLayout:layout onScreen:screen];
            }
            break;
        }
        case DTILayoutDisplayModeOnlyMainDisplay:
        {
            [self createWindowsForLayout:layout onScreen:mainScreen];
            break;
        }
        case DTILayoutDisplayModeOnlySecondaryDisplays:
        {
            for(NSScreen *screen in screens)
            {
                if([screen isEqual:mainScreen]) { continue; }
                [self createWindowsForLayout:layout onScreen:screen];
            }
            break;
        }
    }
}

- (void)createWindowsForLayout:(DTILayout *)layout onScreen:(NSScreen *)screen
{
    NSParameterAssert(layout);
    NSParameterAssert(screen);
}

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
    
    [self reloadLayout];
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
