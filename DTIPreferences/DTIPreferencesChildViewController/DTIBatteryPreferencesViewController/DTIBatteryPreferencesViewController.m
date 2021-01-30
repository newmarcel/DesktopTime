//
//  DTIBatteryPreferencesViewController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTIBatteryPreferencesViewController.h"
#import "DTIDefines.h"
#import "DTIPreferenceItem.h"

#define DTI_L10N_BATTERY_LEVEL NSLocalizedString(@"Battery Level", @"Battery Level")

@interface DTIBatteryPreferencesViewController ()
@end

@implementation DTIBatteryPreferencesViewController

+ (DTIPreferenceItem *)preferenceItem
{
    Auto item = [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                                   name:DTI_L10N_BATTERY_LEVEL];
    item.image = [NSImage imageWithSystemSymbolName:@"battery.100.bolt"
                           accessibilityDescription:nil];
    item.representedObject = self.identifier;
    item.viewControllerClass = [self class];
    return item;
}

- (NSString *)preferredTitle
{
    return DTI_L10N_BATTERY_LEVEL;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
