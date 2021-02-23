//
//  DTIWorkspaceMetrics.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.02.21.
//

#import "DTIWorkspaceMetrics.h"
#import "DTIDefines.h"
#import "DTIPreferences.h"

@interface DTIWorkspaceMetrics ()
@property (nonatomic, readwrite) DTIWorkspaceDockMetrics *dockMetrics;
@property (nonatomic, readwrite) DTIWorkspaceMenuBarMetrics *menuBarMetrics;
@property (nonatomic, readwrite) CGRect usableFrame;
@property (nonatomic, readwrite) NSEdgeInsets usableEdgeInsets;
@property (nonatomic, readwrite) DTIPreferences *preferences;
@end

@interface DTIWorkspaceDockMetrics ()
@property (nonatomic, readwrite) CGFloat thickness;
@property (nonatomic, readwrite) DTIWorkspaceDockPosition position;
- (instancetype)initWithThickness:(CGFloat)thickness
                         position:(DTIWorkspaceDockPosition)position NS_DESIGNATED_INITIALIZER;
@end

@interface DTIWorkspaceMenuBarMetrics ()
@property (nonatomic, readwrite) CGFloat thickness;
@property (nonatomic, readwrite, getter=isHidden) BOOL hidden;
- (instancetype)initWithThickness:(CGFloat)thickness
                           hidden:(BOOL)hidden NS_DESIGNATED_INITIALIZER;
@end

@implementation DTIWorkspaceMetrics

- (instancetype)initWithScreenFrame:(CGRect)screenFrame visibleFrame:(CGRect)visibleFrame preferences:(DTIPreferences *)preferences
{
    NSParameterAssert(preferences);
    
    self = [super init];
    if(self)
    {
        self.preferences = preferences;
        [self calculateMetricsWithFrame:screenFrame visibleFrame:visibleFrame];
    }
    return self;
}

- (void)calculateMetricsWithFrame:(CGRect)frame visibleFrame:(CGRect)visibleFrame
{
    // Remember: The AppKit origin is bottom left!!
    
    // Find the bottom Dock:
    DTIWorkspaceDockPosition dockPosition = DTIWorkspaceDockPositionNone;
    CGFloat dockThickness = 0.0f;
    
    CGFloat diffBottom = visibleFrame.origin.y - frame.origin.y;
    if(diffBottom > 0.0f)
    {
        dockPosition = DTIWorkspaceDockPositionBottom;
        dockThickness = diffBottom;
    }
    
    // Find the left Dock:
    
    CGFloat diffLeft = visibleFrame.origin.x - frame.origin.x;
    if(diffLeft > 0.0f)
    {
        dockPosition = DTIWorkspaceDockPositionLeft;
        dockThickness = diffLeft;
    }
    
    // Find the right Dock:
    
    CGFloat diffRight = frame.size.width - visibleFrame.size.width;
    if(diffLeft == 0.0f && diffRight > 0.0f)
    {
        dockPosition = DTIWorkspaceDockPositionRight;
        dockThickness = diffRight;
    }
    
    Auto dock = [[DTIWorkspaceDockMetrics alloc] initWithThickness:dockThickness
                                                          position:dockPosition];
    
    // Find the Menu Bar:
    BOOL hasMenuBar = NO;
    CGFloat menuBarThickness = 0.0f;
    
    CGFloat diffTop = frame.size.height - visibleFrame.size.height - diffBottom;
    if(diffTop > 0.0f)
    {
        hasMenuBar = YES;
        menuBarThickness = diffTop;
    }
    
    Auto menuBar = [[DTIWorkspaceMenuBarMetrics alloc] initWithThickness:menuBarThickness
                                                                  hidden:!hasMenuBar];
    
    // Usable screen frame
    AutoVar usableFrame = frame;
    AutoVar usableEdgeInsets = NSEdgeInsetsZero;
    
    Auto preferences = self.preferences;
    BOOL avoidsDock = [preferences avoidsDockOverlapping];
    BOOL avoidsMenuBar = [preferences avoidsMenuBarOverlapping];
    
    if(avoidsDock == YES)
    {
        switch(dockPosition)
        {
            case DTIWorkspaceDockPositionBottom:
                usableFrame.origin.y += dockThickness;
                usableFrame.size.height -= dockThickness;
                usableEdgeInsets.bottom = dockThickness;
                break;
            case DTIWorkspaceDockPositionLeft:
                usableFrame.origin.x += dockThickness;
                usableFrame.size.width -= dockThickness;
                usableEdgeInsets.left = dockThickness;
                break;
            case DTIWorkspaceDockPositionRight:
                usableFrame.size.width -= dockThickness;
                usableEdgeInsets.right = dockThickness;
                break;
            case DTIWorkspaceDockPositionNone:
                break;
        }
    }
    
    if(avoidsMenuBar == YES)
    {
        usableFrame.size.height -= menuBarThickness;
        usableEdgeInsets.top = menuBarThickness;
    }
    
    self.dockMetrics = dock;
    self.menuBarMetrics = menuBar;
    self.usableFrame = usableFrame;
    self.usableEdgeInsets = usableEdgeInsets;
}

@end

@implementation DTIWorkspaceDockMetrics

- (instancetype)initWithThickness:(CGFloat)thickness position:(DTIWorkspaceDockPosition)position
{
    self = [super init];
    if(self)
    {
        self.thickness = thickness;
        self.position = position;
    }
    return self;
}

@end

@implementation DTIWorkspaceMenuBarMetrics

- (instancetype)initWithThickness:(CGFloat)thickness hidden:(BOOL)hidden
{
    self = [super init];
    if(self)
    {
        self.thickness = thickness;
        self.hidden = hidden;
    }
    return self;
}

@end
