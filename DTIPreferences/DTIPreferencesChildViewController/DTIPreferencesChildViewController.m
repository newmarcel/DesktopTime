//
//  DTIPreferencesChildViewController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTIPreferencesChildViewController.h"
#import "DTIDefines.h"
#import "DTIPreferenceItem.h"

@interface DTIPreferencesChildViewController ()
@end

@implementation DTIPreferencesChildViewController

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
