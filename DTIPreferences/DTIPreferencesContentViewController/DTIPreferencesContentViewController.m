//
//  DTIPreferencesContentViewController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTIPreferencesContentViewController.h"
#import "DTIDefines.h"
#import "DTIPreferenceItem.h"

@interface DTIPreferencesContentViewController ()
@end

@implementation DTIPreferencesContentViewController

+ (NSUserInterfaceItemIdentifier)identifier
{
    return NSStringFromClass(self);
}

+ (DTIPreferenceItem *)preferenceItem
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"+preferenceItem needs to be implemented by the subclass."
                                 userInfo:nil];
}

- (instancetype)init
{
    Auto nibName = NSStringFromClass([self class]);
    self = [super initWithNibName:nibName bundle:nil];
    if(self)
    {
    }
    return self;
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    
    Auto preferredTitle = self.preferredTitle;
    if(preferredTitle != nil)
    {
        Auto window = self.view.window;
        window.subtitle = preferredTitle;
    }
}

@end
