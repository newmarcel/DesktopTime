//
//  DTILayoutWindowController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 07.02.21.
//

#import "DTILayoutWindowController.h"
#import "DTIDefines.h"
#import "DTILayoutElementDataSource.h"

@interface DTILayoutWindowController ()
@property (nonatomic) NSTimer *timer;

@property (weak, nonatomic, nullable) IBOutlet NSTextField *topLeftLabel;
@property (weak, nonatomic, nullable) IBOutlet NSTextField *topMiddleLabel;
@property (weak, nonatomic, nullable) IBOutlet NSTextField *topRightLabel;

//@property (weak, nonatomic, nullable) IBOutlet NSTextField *centerMiddleLabel;

@property (weak, nonatomic, nullable) IBOutlet NSTextField *bottomLeftLabel;
@property (weak, nonatomic, nullable) IBOutlet NSTextField *bottomMiddleLabel;
@property (weak, nonatomic, nullable) IBOutlet NSTextField *bottomRightLabel;
@end

@implementation DTILayoutWindowController

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
    [self reloadWindow];
}

#pragma mark - Window Management

- (void)configureWindow
{
    Auto window = self.window;
    window.level = CGWindowLevelForKey(kCGDesktopWindowLevel);
    window.ignoresMouseEvents = YES;
#if DEBUG
    window.backgroundColor = [NSColor colorWithRed:0.2f green:0.3f blue:0.3f alpha:0.4f];
#else
    window.backgroundColor = NSColor.clearColor;
#endif
    
    // Full screen size
    Auto screen = self.targetScreen ?: window.screen;
    [window setFrame:screen.frame display:YES];
}

- (void)updateOffsets
{
    Auto preferences = DTIPreferences.sharedPreferences;
    BOOL avoidsDockOverlapping = preferences.avoidsDockOverlapping;
    BOOL avoidsMenuBarOverlapping = preferences.avoidsMenuBarOverlapping;
    
    Auto window = self.window;
    Auto screen = self.targetScreen ?: window.screen;
    
    CGRect fullFrame = screen.frame;
    CGRect visiFrame = screen.visibleFrame;
    
    CGFloat menubarHeight = NSStatusBar.systemStatusBar.thickness + 3.0f; // + 3pts on Big Sur
    if(avoidsMenuBarOverlapping == NO) { menubarHeight = 0.0f; }

    CGFloat hDockWidth = fullFrame.size.width - visiFrame.size.width;
    CGFloat dockHeight = fullFrame.size.height - visiFrame.size.height;
    if(avoidsMenuBarOverlapping) { dockHeight -= menubarHeight; }
    if(dockHeight > 3.0f) { dockHeight -= 3.0f; }
    
    CGFloat top = avoidsMenuBarOverlapping ? menubarHeight : 0.0f;
    CGFloat left = 0.0f;
    if(hDockWidth > 0.0f && visiFrame.origin.x > fullFrame.origin.x) { left = visiFrame.origin.x; }
    CGFloat bottom = 0.0f;
    if(dockHeight > 0.0f && avoidsDockOverlapping == YES) { bottom = dockHeight; }
    CGFloat right = 0.0f;
    if(hDockWidth > 0.0f && visiFrame.origin.x == fullFrame.origin.x) { right = hDockWidth; }
    
    NSEdgeInsets insets = NSEdgeInsetsMake(top, left, bottom, right);
    window.contentView.additionalSafeAreaInsets = insets;
}

- (void)reloadWindow
{
    Auto layout = self.layout;
    
    Auto elementDataSource = self.elementDataSource;
    if(elementDataSource == nil) { return; }
    
    Auto configureElement = ^(DTILayoutElement element, NSTextField *label) {
        Auto dataSource = [elementDataSource dataSourceForLayoutElement:element];
        if(dataSource != nil)
        {
            label.stringValue = dataSource.stringValue;
            label.hidden = NO;
            [elementDataSource applyStyleOfLayoutElement:element toLabel:label];
        }
        else
        {
            label.stringValue = @"";
            label.hidden = YES;
        }
    };
    
    configureElement(layout.topLeftElement, self.topLeftLabel);
    configureElement(layout.topMiddleElement, self.topMiddleLabel);
    configureElement(layout.topRightElement, self.topRightLabel);
    
    configureElement(layout.bottomLeftElement, self.bottomLeftLabel);
    configureElement(layout.bottomMiddleElement, self.bottomMiddleLabel);
    configureElement(layout.bottomRightElement, self.bottomRightLabel);
    
    [self updateOffsets];
}

@end
