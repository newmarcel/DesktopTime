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
        {
            Auto controller = [[DTIDateTimeLayoutElementWindowController alloc]
                               initWithElement:element
                               Position:position];
            return controller;
        }
        case DTILayoutElementDate:
        {
            Auto controller = [[DTIDateTimeLayoutElementWindowController alloc]
                               initWithElement:element
                               Position:position];
            return controller;
        }
        case DTILayoutElementTime:
        {
            Auto controller = [[DTIDateTimeLayoutElementWindowController alloc]
                               initWithElement:element
                               Position:position];
            return controller;
        }
        case DTILayoutElementBatteryLevel:
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"Battery Level not implemented"
                                         userInfo:nil];
            return nil;
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
    
#warning TODO: Take position into account
    
    if(screen != nil)
    {
        frame.origin = screen.frame.origin;
//        frame.size.width = screen.frame.size.width; // FIXME
        
        [window setFrame:frame display:YES];
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

- (void)reloadWindow
{
    [super reloadWindow];
    
    Auto label = self.textLabel;
    Auto preferences = DTIPreferences.sharedPreferences;
    
    label.font = preferences.batteryLevelFont;
    label.textColor = preferences.batteryLevelTextColor;
    label.layer.shadowColor = preferences.batteryLevelShadowColor.CGColor;
    
    [self updateWindowPosition];
}

@end
