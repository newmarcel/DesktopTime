//
//  DTILayoutController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 05.02.21.
//

#import "DTILayoutController.h"
#import "DTIDefines.h"
#import "DTILayoutWindowController.h"
#import "DTILayoutElementDataSource.h"

static const NSTimeInterval DTITimerTickInterval = 1.0f;

@interface DTILayoutController () <DTILayoutWindowElementDataSource>
@property (nonatomic) NSMutableArray<DTILayoutWindowController *> *windowControllers;
@property (nonatomic, readwrite, nullable) DTILayout *currentLayout;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSMapTable<NSNumber *, DTILayoutElementDataSource *> *elementDataSources;
@end

@implementation DTILayoutController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.elementDataSources = [NSMapTable<NSNumber *, DTILayoutElementDataSource *> new];
        self.windowControllers = [NSMutableArray<DTILayoutWindowController *> new];
    }
    return self;
}

- (void)dealloc
{
    [self stopTimer];
    
    for(NSWindowController *windowController in self.windowControllers)
    {
        [windowController close];
    }
    self.windowControllers = nil;
}

- (void)reloadLayout
{
    Auto layout = DTIPreferences.sharedPreferences.layout;
    self.currentLayout = layout;
    
    [self clearWindows];
    [self createWindowsForLayout:layout];
}

#pragma mark - Window Management

- (void)clearWindows
{
    for(NSWindowController *windowController in self.windowControllers)
    {
        [windowController close];
    }
    [self.windowControllers removeAllObjects];
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
            if(screens.count == 1)
            {
                // If only one screen is connected, just use this
                // instead of not displaying anything.
                [self createWindowsForLayout:layout onScreen:screens.firstObject];
                break;
            }
            
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
    
    Auto windowController = [DTILayoutWindowController new];
    windowController.layout = self.currentLayout;
    windowController.targetScreen = screen;
    windowController.elementDataSource = self;
    
    [self.windowControllers addObject:windowController];
    [windowController showWindow:self];
    [windowController reloadWindow];
}

#pragma mark - Timer

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:DTITimerTickInterval
                                                  target:self
                                                selector:@selector(tick:)
                                                userInfo:nil
                                                 repeats:YES];
    // The initial tick
    [self tick:self.timer];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)tick:(NSTimer *)timer
{
    for(DTILayoutWindowController *windowController in self.windowControllers)
    {
        [windowController reloadWindow];
    }
}

#pragma mark - DTILayoutWindowElementDataSource

- (DTILayoutElementDataSource *)dataSourceForLayoutElement:(DTILayoutElement)element
{
    Auto key = @(element);
    AutoVar dataSource = [self.elementDataSources objectForKey:key];
    if(dataSource == nil)
    {
        dataSource = [DTILayoutElementDataSource dataSourceForElement:element];
        if(dataSource == nil) { return nil; }
        [self.elementDataSources setObject:dataSource forKey:key];
    }
    return dataSource;
}

- (void)applyStyleOfLayoutElement:(DTILayoutElement)element toLabel:(NSTextField *)label
{
    Auto preferences = DTIPreferences.sharedPreferences;
    switch(element)
    {
        case DTILayoutElementDateTime:
        case DTILayoutElementDate:
        case DTILayoutElementTime:
            label.font = preferences.dateTimeFont;
            label.textColor = preferences.dateTimeTextColor;
            label.layer.shadowColor = preferences.dateTimeShadowColor.CGColor;
            break;
        case DTILayoutElementBatteryLevel:
            label.font = preferences.batteryLevelFont;
            label.textColor = preferences.batteryLevelTextColor;
            label.layer.shadowColor = preferences.batteryLevelShadowColor.CGColor;
            break;
        default:
            break;
    }
}

@end
