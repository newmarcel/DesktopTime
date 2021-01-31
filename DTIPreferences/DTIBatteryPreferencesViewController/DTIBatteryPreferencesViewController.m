//
//  DTIBatteryPreferencesViewController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTIBatteryPreferencesViewController.h"
#import "DTIDefines.h"
#import "DTIPreferenceItem.h"
#import "NSFont+DTILocalizedDisplayName.h"

#define DTI_L10N_BATTERY_LEVEL NSLocalizedString(@"Battery Level", @"Battery Level")

@interface DTIBatteryPreferencesViewController () <NSFontChanging>
@end

@implementation DTIBatteryPreferencesViewController

+ (DTIPreferenceItem *)preferenceItem
{
    Auto item = [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                                   name:DTI_L10N_BATTERY_LEVEL];
    item.image = [NSImage imageWithSystemSymbolName:@"battery.100.bolt"
                           accessibilityDescription:nil];
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

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    Auto fontManager = NSFontManager.sharedFontManager;
    fontManager.target = self;
    
    Auto font = [NSFont preferredFontForTextStyle:NSFontTextStyleBody options:@{}];
    [fontManager setSelectedFont:font isMultiple:NO];
    self.fontTextField.stringValue = font.dti_localizedDisplayName;
}

- (void)viewWillDisappear
{
    Auto fontManager = NSFontManager.sharedFontManager;
    fontManager.target = nil;
}

#pragma mark - NSFontChanging

- (void)changeFont:(NSFontManager *)fontManager
{
    NSLog(@"Selected: %@", fontManager.selectedFont.dti_localizedDisplayName);
    self.fontTextField.stringValue = fontManager.selectedFont.dti_localizedDisplayName;
}

- (NSFontPanelModeMask)validModesForFontPanel:(NSFontPanel *)fontPanel
{
    return NSFontPanelModeMaskCollection
        | NSFontPanelModeMaskFace
        | NSFontPanelModeMaskSize;
}

@end
