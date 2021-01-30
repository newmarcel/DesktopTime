//
//  DTIDateTimePreferencesViewController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTIDateTimePreferencesViewController.h"
#import "DTIDefines.h"
#import "DTIPreferenceItem.h"

#define DTI_L10N_DATE_TIME NSLocalizedString(@"Date & Time", @"Date & Time")

@interface DTIDateTimePreferencesViewController ()
@end

@implementation DTIDateTimePreferencesViewController

+ (DTIPreferenceItem *)preferenceItem
{
    Auto item = [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                                   name:DTI_L10N_DATE_TIME];
    item.image = [NSImage imageWithSystemSymbolName:@"calendar.badge.clock"
                           accessibilityDescription:nil];
    item.representedObject = self.identifier;
    return item;
}

- (NSString *)preferredTitle
{
    return DTI_L10N_DATE_TIME;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
