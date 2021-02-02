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

@interface DTIBatteryPreferencesViewController () <NSFontChanging>
@property (nonatomic) NSFont *textFont;
@property (nonatomic) NSColor *textColor;
@property (nonatomic) NSColor *shadowColor;
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
    
    Auto font = self.textFont;
    [fontManager setSelectedFont:font isMultiple:NO];
}

- (void)viewWillDisappear
{
    Auto fontManager = NSFontManager.sharedFontManager;
    fontManager.target = nil;
}

#pragma mark - Actions

- (void)resetDefaultValues:(id)sender
{
    self.textFont = nil;
    self.textColor = nil;
    self.shadowColor = nil;
}

#pragma mark - Fonts & Colors

- (NSFont *)textFont
{
    return DTIPreferences.sharedPreferences.batteryLevelFont;
}

- (void)setTextFont:(NSFont *)textFont
{
    [self willChangeValueForKey:@"textFont"];
    DTIPreferences.sharedPreferences.batteryLevelFont = textFont;
    [self didChangeValueForKey:@"textFont"];
}

- (NSColor *)textColor
{
    return DTIPreferences.sharedPreferences.batteryLevelTextColor;
}

- (void)setTextColor:(NSColor *)textColor
{
    DTIPreferences.sharedPreferences.batteryLevelTextColor = textColor;
}

- (NSColor *)shadowColor
{
    return DTIPreferences.sharedPreferences.batteryLevelShadowColor;
}

- (void)setShadowColor:(NSColor *)shadowColor
{
    DTIPreferences.sharedPreferences.batteryLevelShadowColor = shadowColor;
}

#pragma mark - NSFontChanging

- (void)changeFont:(NSFontManager *)fontManager
{
    self.textFont = [fontManager convertFont:self.textFont];
}

- (NSFontPanelModeMask)validModesForFontPanel:(NSFontPanel *)fontPanel
{
    return NSFontPanelModeMaskCollection
        | NSFontPanelModeMaskFace
        | NSFontPanelModeMaskSize;
}

@end
