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
    window.backgroundColor = NSColor.clearColor;
}

- (void)updateOffsets
{
    Auto window = self.window;
    Auto screen = self.targetScreen ?: window.screen;
    
    Auto metrics = screen.dti_workspaceMetrics;
    Auto insets = metrics.usableEdgeInsets;
    window.contentView.additionalSafeAreaInsets = insets;
    
    [window setFrame:screen.frame display:NO];
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
