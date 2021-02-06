//
//  DTILayoutElementWindowController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 05.02.21.
//

#import "DTILayoutElementWindowController.h"
#import "DTIDefines.h"

@interface DTILayoutElementWindowController () <NSWindowDelegate>
@property (nonatomic, readwrite) DTILayoutElement element;
@property (nonatomic, readwrite) DTILayoutPosition position;
@property (weak, nonatomic, nullable) IBOutlet NSTextField *textLabel;
@end

@interface DTIDateTimeLayoutElementWindowController : DTILayoutElementWindowController
@property (nonatomic) NSDateFormatter *dateFormatter;
@end

@interface DTIBatteryLevelLayoutElementWindowController : DTILayoutElementWindowController
@property (nonatomic) DTIBatteryStatus *batteryStatus;
@end

@implementation DTILayoutElementWindowController

+ (instancetype)windowControllerForElement:(DTILayoutElement)element atPosition:(DTILayoutPosition)position
{
    switch(element)
    {
        case DTILayoutElementNone:
            // Do not create a window at all
            return nil;
        case DTILayoutElementDateTime:
            // fallthrough
        case DTILayoutElementDate:
            // fallthrough
        case DTILayoutElementTime:
        {
            Auto controller = [[DTIDateTimeLayoutElementWindowController alloc]
                               initWithElement:element
                               Position:position];
            return controller;
        }
        case DTILayoutElementBatteryLevel:
        {
            Auto controller = [[DTIBatteryLevelLayoutElementWindowController alloc]
                               initWithElement:element
                               Position:position];
            return controller;
        }
    }
}

- (instancetype)initWithElement:(DTILayoutElement)element Position:(DTILayoutPosition)position
{
    Auto nibName = NSStringFromClass([DTILayoutElementWindowController class]);
    self = [super initWithWindowNibName:nibName];
    if(self)
    {
        self.element = element;
        self.position = position;
    }
    return self;
}

- (void)dealloc
{
    DTILog(@"Bye bye!");
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self configureWindow];
    [self updateWindowPosition];
}

#pragma mark - Window Management

- (void)configureWindow
{
    Auto window = self.window;
    window.level = CGWindowLevelForKey(kCGDesktopWindowLevel);
    window.ignoresMouseEvents = YES;
#if DEBUG
    window.backgroundColor = NSColor.systemBlueColor;
#else
    window.backgroundColor = NSColor.clearColor;
#endif
}

- (void)updateWindowPosition
{
    Auto window = self.window;
    AutoVar frame = window.frame;
    Auto screen = self.targetScreen ?: window.screen;
    
    // Let Auto Layout size the window
    [window layoutIfNeeded];
    
    if(screen != nil)
    {
        CGRect windowFrame = [self windowFrameForPosition:self.position
                                              screenFrame:(CGRect)screen.frame
                                               windowSize:frame.size];
        [window setFrame:windowFrame display:YES];
    }
}

- (CGRect)windowFrameForPosition:(DTILayoutPosition)position screenFrame:(CGRect)screenFrame windowSize:(CGSize)windowSize
{
    // Remember: AppKit's coordinate system starts at the bottom left!!!
    
    CGFloat width = windowSize.width;
    CGFloat height = windowSize.height;
    CGFloat topY = screenFrame.size.height - height;
    CGFloat bottomY = 0.0f;
    CGFloat leftX = 0.0f;
    CGFloat midX = roundf((screenFrame.size.width / 2.0f) - (width / 2.0f));
    CGFloat rightX = screenFrame.size.width - width;
    
    switch(position)
    {
        case DTILayoutPositionUndefined:
            return CGRectZero;
            
        case DTILayoutPositionTopLeft:
            return CGRectMake(leftX, topY, width, height);
        case DTILayoutPositionTopMiddle:
            return CGRectMake(midX, topY, width, height);
        case DTILayoutPositionTopRight:
            return CGRectMake(rightX, topY, width, height);
            
        case DTILayoutPositionBottomLeft:
            return CGRectMake(leftX, bottomY, width, height);
        case DTILayoutPositionBottomMiddle:
            return CGRectMake(midX, bottomY, width, height);
        case DTILayoutPositionBottomRight:
            return CGRectMake(rightX, bottomY, width, height);
    }
}

- (void)reloadWindow
{
}

@end

@implementation DTIDateTimeLayoutElementWindowController

 - (instancetype)initWithElement:(DTILayoutElement)element Position:(DTILayoutPosition)position
{
    self = [super initWithElement:element Position:position];
    if(self)
    {
        self.dateFormatter = [NSDateFormatter dti_dateFormatterForLayoutElement:element];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.textLabel.formatter = self.dateFormatter;
}

- (void)reloadWindow
{
    [super reloadWindow];
    
    Auto label = self.textLabel;
    label.objectValue = [NSDate date];
    
    Auto preferences = DTIPreferences.sharedPreferences;
    label.font = preferences.dateTimeFont;
    label.textColor = preferences.dateTimeTextColor;
    label.layer.shadowColor = preferences.dateTimeShadowColor.CGColor;
    
    [self updateWindowPosition];
}

@end

@implementation DTIBatteryLevelLayoutElementWindowController

 - (instancetype)initWithElement:(DTILayoutElement)element Position:(DTILayoutPosition)position
{
    self = [super initWithElement:element Position:position];
    if(self)
    {
        self.batteryStatus = [DTIBatteryStatus new];
    }
    return self;
}

- (void)reloadWindow
{
    [super reloadWindow];
    
    Auto label = self.textLabel;
    label.stringValue = self.batteryStatus.localizedCurrentCapacity;
    
    Auto preferences = DTIPreferences.sharedPreferences;
    label.font = preferences.batteryLevelFont;
    label.textColor = preferences.batteryLevelTextColor;
    label.layer.shadowColor = preferences.batteryLevelShadowColor.CGColor;
    
    [self updateWindowPosition];
}

@end
