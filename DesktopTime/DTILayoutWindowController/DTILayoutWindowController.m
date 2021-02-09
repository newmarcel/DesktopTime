//
//  DTILayoutWindowController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 07.02.21.
//

#import "DTILayoutWindowController.h"
#import "DTIDefines.h"

static const NSTimeInterval DTITimerTickInterval = 1.0f;

@interface DTILayoutWindowController ()
@property (nonatomic, readwrite, nullable) DTILayout *currentLayout;
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
    
    [self reloadLayout];
}

#pragma mark - Layout Management

- (NSArray<NSTextField *> *)allLabels
{
    Auto labels = [NSMutableArray new];
    Auto addLabel = ^(NSTextField *_Nullable label) {
        if(label != nil) { [labels addObject:label]; }
    };
    
    addLabel(self.topLeftLabel);
    addLabel(self.topMiddleLabel);
    addLabel(self.topRightLabel);
    addLabel(self.bottomLeftLabel);
    addLabel(self.bottomMiddleLabel);
    addLabel(self.bottomRightLabel);
    
    return [labels copy];
}

- (void)reloadLayout
{
    Auto layout = DTIPreferences.sharedPreferences.layout;
    self.currentLayout = layout;
    
    [self clearLabels];
    
    // TODO: Wire up labels
}

- (void)clearLabels
{
    for(NSTextField *label in [self allLabels])
    {
        label.stringValue = @"";
        label.hidden = YES;
    }
}

@end
