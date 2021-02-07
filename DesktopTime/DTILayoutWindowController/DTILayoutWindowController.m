//
//  DTILayoutWindowController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 07.02.21.
//

#import "DTILayoutWindowController.h"
#import "DTIDefines.h"

static const NSTimeInterval DTITimerTickInterval = 1.0f;

@interface DTILayoutWindowController ()
@property (nonatomic, readwrite, nullable) DTILayout *currentLayout;
@property (nonatomic) NSTimer *timer;
@end

@implementation DTILayoutWindowController

+ (instancetype)new
{
    return [[DTILayoutWindowController alloc] init];
}

- (instancetype)init
{
    self = [super initWithWindowNibName:NSStringFromClass([self class])];
    if(self)
    {
        
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (void)dealloc
{
    [self stopTimer];
}

#pragma mark - Layout Management

- (void)reloadLayout
{
    Auto layout = DTIPreferences.sharedPreferences.layout;
    self.currentLayout = layout;
    
//    [self clearWindows];
//    [self createWindowsForLayout:layout];
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
//    for(DTILayoutElementWindowController *windowController in self.windowControllers)
//    {
//        [windowController reloadWindow];
//    }
}

@end
