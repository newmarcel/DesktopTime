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
@property (nonatomic) NSDateFormatter *dateFormatter;
@property (nonatomic) NSNumberFormatter *percentFormatter;
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
    [self configureFormatters];
    [self configureTimer];
}

- (void)dealloc
{
    [self.timer invalidate];
}

- (void)configureWindow
{
    Auto window = self.window;
    window.level = CGWindowLevelForKey(kCGDesktopWindowLevel);
    window.ignoresMouseEvents = YES;
    window.backgroundColor = NSColor.clearColor;
}

- (void)updateWindowPosition
{
    Auto window = self.window;
    AutoVar frame = window.frame;
    Auto screen = self.targetScreen ?: window.screen;
    
    if(screen != nil)
    {
        frame.origin = screen.frame.origin;
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
    // Leading
    CGFloat capacity = self.batteryStatus.currentCapacity;
    if(capacity == KYABatteryStatusUnavailable)
    {
        self.leadingLabel.stringValue = @"";
    }
    else
    {
        self.leadingLabel.stringValue = [self.percentFormatter stringFromNumber:@(capacity / 100.0f)];
    }
    
    // Trailing
    Auto now = [NSDate date];
    self.trailingLabel.stringValue = [self.dateFormatter stringFromDate:now];

    [self updateWindowPosition];
}

#pragma mark - Formatters

- (void)configureFormatters
{
    [self configureDateFormatter];
    [self configureNumberFormatter];
}

- (void)configureDateFormatter
{
    Auto locale = NSLocale.currentLocale;
    Auto df = [NSDateFormatter new];
    df.dateStyle = NSDateFormatterLongStyle;
    df.timeStyle = NSDateFormatterShortStyle;
    df.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"eddMMHHmm"
                                                    options:0
                                                     locale:locale];
    df.formattingContext = NSFormattingContextStandalone;
    self.dateFormatter = df;
}

- (void)configureNumberFormatter
{
    Auto locale = NSLocale.currentLocale;
    Auto nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterPercentStyle;
    nf.locale = locale;
    nf.allowsFloats = NO;
    nf.formattingContext = NSFormattingContextStandalone;
    nf.lenient = YES;
    
    nf.minimum = @0.0f;
    nf.maximum = @100.0f;
    
    self.percentFormatter = nf;
}

#pragma mark - NSWindowDelegate

- (void)windowDidChangeScreen:(NSNotification *)notification
{
    DTILog(@"Window did change screen %@", notification.object);
    [self updateWindowPosition];
}

@end
