//
//  DTITimeWindowController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTITimeWindowController.h"
#import "DTIDefines.h"

@interface DTITimeWindowController () <NSWindowDelegate>
@end

@implementation DTITimeWindowController

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
    
    [self configureWindow];
    [self updateWindowPosition];
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

#pragma mark - NSWindowDelegate

- (void)windowDidChangeScreen:(NSNotification *)notification
{
    DTILog(@"Window did change screen %@", notification.object);
    [self updateWindowPosition];
}

@end
