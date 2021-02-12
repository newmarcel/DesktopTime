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

@interface DTILayoutPreferencesViewController () <DTILayoutDelegate>
@property (nonatomic, readwrite) DTILayout *layout;
@property (nonatomic, readwrite) NSArray<NSString *> *availableLayoutElements;
@property (nonatomic) BOOL avoidsDockOverlapping;
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

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    self.layout = DTIPreferences.sharedPreferences.layout;
    self.layout.delegate = self;
    self.availableLayoutElements = DTILayoutElementGetAllElements();
}

#pragma mark - Avoids Dock Overlapping

- (BOOL)avoidsDockOverlapping
{
    return DTIPreferences.sharedPreferences.avoidsDockOverlapping;
}

- (void)setAvoidsDockOverlapping:(BOOL)avoidsDockOverlapping
{
    [self willChangeValueForKey:@"avoidsDockOverlapping"];
    DTIPreferences.sharedPreferences.avoidsDockOverlapping = avoidsDockOverlapping;
    [self willChangeValueForKey:@"avoidsDockOverlapping"];
}

#pragma mark - DTILayoutDelegate

- (void)layoutDidChange:(DTILayout *)layout keyPath:(NSString *)keyPath
{
    DTIPreferences.sharedPreferences.layout = layout;
}

@end
