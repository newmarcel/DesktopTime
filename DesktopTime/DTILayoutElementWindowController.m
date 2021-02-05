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
}

- (void)reloadWindow
{
    
}

@end

@implementation DTIDateTimeLayoutElementWindowController
@end

@implementation DTIBatteryLevelLayoutElementWindowController
@end
