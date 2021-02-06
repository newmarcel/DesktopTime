//
//  DTILayoutElementWindowController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 05.02.21.
//

#import "DTILayoutElementWindowController.h"
#import "DTIDefines.h"

@interface DTILayoutElementWindowController () <NSWindowDelegate>
@property (nonatomic, readwrite) DTILayoutPosition position;
@property (weak, nonatomic, nullable) IBOutlet NSTextField *textLabel;
@end

@implementation DTILayoutElementWindowController

- (instancetype)initWithPosition:(DTILayoutPosition)position
{
    Auto nibName = NSStringFromClass([DTILayoutElementWindowController class]);
    self = [super initWithWindowNibName:nibName];
    if(self)
    {
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
@end

@implementation DTIBatteryLevelLayoutElementWindowController
@end
