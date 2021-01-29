//
//  DTIPreferences.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.12.20.
//

#import "DTIPreferences.h"
#import "DTIAppGroup.h"

//NSString * const DPLNonRetinaDisplayModesEnabledDefaultsKey = @"info.marcel-dierkes.Displace.NonRetinaDisplayModesEnabled";
//NSString * const DPLIncreaseResolutionShortcutDefaultsKey = @"info.marcel-dierkes.Displace.IncreaseResolutionShortcut";
//NSString * const DPLDecreaseResolutionShortcutDefaultsKey =  @"info.marcel-dierkes.Displace.DecreaseResolutionShortcut";

@interface DTIPreferences ()
@property (nonatomic, readwrite) id<DTIDefaultsProvider> defaults;
@end

@implementation DTIPreferences

+ (instancetype)sharedPreferences
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    return [self initWithDefaultsProvider:DTIAppGroupGetUserDefaults()];
}

- (instancetype)initWithDefaultsProvider:(id<DTIDefaultsProvider>)defaults
{
    NSParameterAssert(defaults);
    
    self = [super init];
    if(self)
    {
        self.defaults = defaults;
    }
    return self;
}

#pragma mark - Properties

//- (BOOL)isLaunchAtLoginEnabled
//{
//    return [self.defaults boolForKey:Key::LaunchAtLoginEnabled];
//}
//
//- (void)setLaunchAtLoginEnabled:(BOOL)enabled
//{
//    [self.defaults setBool:enabled forKey:Key::LaunchAtLoginEnabled];
//}

@end
