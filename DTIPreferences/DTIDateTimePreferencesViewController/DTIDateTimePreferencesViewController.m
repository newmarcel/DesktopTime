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

@interface DTIDateTimePreferencesViewController () <NSFontChanging>
@property (nonatomic) NSFont *textFont;
@property (nonatomic) NSColor *textColor;
@property (nonatomic) NSColor *shadowColor;
@end

@implementation DTIDateTimePreferencesViewController

+ (DTIPreferenceItem *)preferenceItem
{
    Auto item = [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                                   name:DTI_L10N_DATE_TIME];
    item.image = [NSImage imageWithSystemSymbolName:@"calendar.badge.clock"
                           accessibilityDescription:nil];
    item.viewControllerClass = [self class];
    return item;
}

- (NSString *)preferredTitle
{
    return DTI_L10N_DATE_TIME;
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    NSColorPanel.sharedColorPanel.showsAlpha = YES;
    
    Auto fontManager = NSFontManager.sharedFontManager;
    fontManager.target = self;
    
    Auto font = self.textFont;
    [fontManager setSelectedFont:font isMultiple:NO];
}

- (void)viewWillDisappear
{
    [super viewWillDisappear];
    
    Auto fontManager = NSFontManager.sharedFontManager;
    if(fontManager.target == self)
    {
        fontManager.target = nil;
    }
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
    return DTIPreferences.sharedPreferences.dateTimeFont;
}

- (void)setTextFont:(NSFont *)textFont
{
    [self willChangeValueForKey:@"textFont"];
    DTIPreferences.sharedPreferences.dateTimeFont = textFont;
    [self didChangeValueForKey:@"textFont"];
}

- (NSColor *)textColor
{
    return DTIPreferences.sharedPreferences.dateTimeTextColor;
}

- (void)setTextColor:(NSColor *)textColor
{
    DTIPreferences.sharedPreferences.dateTimeTextColor = textColor;
}

- (NSColor *)shadowColor
{
    return DTIPreferences.sharedPreferences.dateTimeShadowColor;
}

- (void)setShadowColor:(NSColor *)shadowColor
{
    DTIPreferences.sharedPreferences.dateTimeShadowColor = shadowColor;
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
