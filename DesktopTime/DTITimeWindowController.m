//
//  DTITimeWindowController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import "DTITimeWindowController.h"

@interface DTITimeWindowController ()
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
}

- (void)configureWindow
{
    NSWindow *window = self.window;
    window.level = CGWindowLevelForKey(kCGFloatingWindowLevelKey);
    window.ignoresMouseEvents = YES;
    window.backgroundColor = NSColor.clearColor;
}

@end
