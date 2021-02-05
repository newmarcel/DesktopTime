//
//  DTILayoutController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 05.02.21.
//

#import "DTILayoutController.h"
#import "DTIDefines.h"
#import "DTILayoutElementWindowController.h"

static const NSTimeInterval DTITimerTickInterval = 1.0f;

@interface DTILayoutController ()
@property (nonatomic) NSMutableArray<DTILayoutElementWindowController *> *windowControllers;
@property (nonatomic, readwrite, nullable) DTILayout *currentLayout;
@property (nonatomic) NSTimer *timer;
@end

@implementation DTILayoutController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.windowControllers = [NSMutableArray<DTILayoutElementWindowController *> new];
    }
    return self;
}

- (void)dealloc
{
    [self.timer invalidate];
    
    for(NSWindowController *windowController in self.windowControllers)
    {
        [windowController close];
    }
    self.windowControllers = nil;
}

- (void)reloadLayout
{
    if(self.timer == nil)
    {
        [self startTimer];
    }
    
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
    
    switch(layout.topLeftElement)
    {
        case DTILayoutElementNone:
            // Do not create a window at all
            break;
        case DTILayoutElementDateTime:
        {
            Auto controller = [[DTIDateTimeLayoutElementWindowController alloc]
                               initWithPosition:DTILayoutPositionTopLeft];
            controller.targetScreen = screen;
            [self.windowControllers addObject:controller];
            [controller showWindow:self];
            break;
        }
        case DTILayoutElementDate:
        {
            Auto controller = [[DTIDateTimeLayoutElementWindowController alloc]
                               initWithPosition:DTILayoutPositionTopLeft];
            controller.displayMode = DTIDateTimeDisplayModeDate;
            controller.targetScreen = screen;
            [self.windowControllers addObject:controller];
            [controller showWindow:self];
            break;
        }
        case DTILayoutElementTime:
        {
            Auto controller = [[DTIDateTimeLayoutElementWindowController alloc]
                               initWithPosition:DTILayoutPositionTopLeft];
            controller.displayMode = DTIDateTimeDisplayModeTime;
            controller.targetScreen = screen;
            [self.windowControllers addObject:controller];
            [controller showWindow:self];
            break;
        }
        case DTILayoutElementBatteryLevel:
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"Battery Level not implemented"
                                         userInfo:nil];
            break;

    }
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

- (void)tick:(NSTimer *)timer
{
    for(DTILayoutElementWindowController *windowController in self.windowControllers)
    {
        [windowController reloadWindow];
    }
}

@end
