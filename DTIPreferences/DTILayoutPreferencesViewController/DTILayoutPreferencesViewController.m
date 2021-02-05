//
//  DTILayoutPreferencesViewController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTILayoutPreferencesViewController.h"
#import "DTIDefines.h"
#import "DTIPreferenceItem.h"

#define DTI_L10N_LAYOUT NSLocalizedString(@"Layout", @"Layout")

@interface DTILayoutPreferencesViewController ()
@property (nonatomic, readwrite) DTILayout *layout;
@property (nonatomic, readwrite) NSArray<NSString *> *availableLayoutElements;
@end

@implementation DTILayoutPreferencesViewController

+ (DTIPreferenceItem *)preferenceItem
{
    Auto item = [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                                   name:DTI_L10N_LAYOUT];
    item.image = [NSImage imageWithSystemSymbolName:@"dock.rectangle"
                           accessibilityDescription:nil];
    item.viewControllerClass = [self class];
    return item;
}

- (NSString *)preferredTitle
{
    return DTI_L10N_LAYOUT;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.layout = DTIPreferences.sharedPreferences.layout;
    self.availableLayoutElements = DTILayoutElementGetAllElements();
}

#pragma mark - Actions

- (IBAction)completelyTerminate:(id)sender
{
    [DTINotificationCenter.defaultCenter postNotification:DTIAppShouldTerminateNotification];
    [NSApplication.sharedApplication terminate:sender];
}

@end
