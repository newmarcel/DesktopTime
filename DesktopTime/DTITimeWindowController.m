//
//  DTITimeWindowController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTITimeWindowController.h"
#import "DTIDefines.h"

static const NSTimeInterval DTITimerTickInterval = 1.0f;

@interface DTITimeWindowController () <NSWindowDelegate>
@property (nonatomic) NSTimer *timer;
@property (nonatomic) DTIBatteryStatus *batteryStatus;
@property (weak, nonatomic, nullable) IBOutlet NSTextField *leadingLabel;
@property (weak, nonatomic, nullable) IBOutlet NSTextField *trailingLabel;
@end

@implementation DTITimeWindowController

- (instancetype)init
{
    self = [super initWithWindowNibName:NSStringFromClass([self class])];
    if(self)
    {
        self.batteryStatus = [DTIBatteryStatus new];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self configureWindow];
    [self updateWindowPosition];
    [self configureTimer];
}

- (void)dealloc
{
    [self.timer invalidate];
}

- (void)configureWindow
{
    Auto window = self.window;
    window.level = CGWindowLevelForKey(kCGFloatingWindowLevelKey);
    window.ignoresMouseEvents = YES;
    window.backgroundColor = NSColor.clearColor;
}

- (void)updateWindowPosition
{
    Auto window = self.window;
    AutoVar frame = window.frame;
    Auto screen = window.screen;
    if(screen != nil)
    {
        frame.origin = CGPointZero;
        frame.size.width = screen.frame.size.width;
        
        [window setFrame:frame display:YES];
    }
}

#pragma mark - Timer

- (void)configureTimer
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
//    let time = Date()
//
//    if let capacity = batteryStatus.currentCapacity {
//        self.batteryLabel.stringValue = "\(capacity) %"
//    } else {
//        self.batteryLabel.stringValue = ""
//    }
//
//    self.timeLabel.stringValue = dateFormatter.string(from: time)
//
//    if let window = self.view.window {
//        updatePosition(of: window)
//    }
    
    // --
    
//    private var dateFormatter: DateFormatter = {
//        let df = DateFormatter()
//        df.dateStyle = .long // ignore
//        df.timeStyle = .short // ignore
//        df.dateFormat = DateFormatter.dateFormat(
//                                                 fromTemplate: "eddMMHHmm", options: 0, locale: .current
//                                                 )
//        df.formattingContext = .standalone
//        return df
//    }()
}

#pragma mark - NSWindowDelegate

- (void)windowDidChangeScreen:(NSNotification *)notification
{
    DTILog(@"Window did change screen %@", notification.object);
    [self updateWindowPosition];
}

@end
