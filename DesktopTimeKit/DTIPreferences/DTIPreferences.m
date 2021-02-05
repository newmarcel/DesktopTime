//
//  DTIPreferences.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.12.20.
//

#import "DTIPreferences.h"
#import "DTIDefines.h"
#import "DTIAppGroup.h"
#import "DTILayout.h"
#import "DTINotificationCenter.h"

NSString * const DTIFirstLaunchFinishedKey = @"info.marcel-dierkes.DesktopTime.FirstLaunchFinshed";
NSString * const DTILayoutKey = @"info.marcel-dierkes.DesktopTime.Layout";
NSString * const DTIDateTimeFontKey = @"info.marcel-dierkes.DesktopTime.DateTimeFont";
NSString * const DTIBatteryLevelFontKey = @"info.marcel-dierkes.DesktopTime.BatteryLevel.Font";
NSString * const DTIBatteryLevelTextColorKey = @"info.marcel-dierkes.DesktopTime.BatteryLevel.TextColor";
NSString * const DTIBatteryLevelShadowColorKey = @"info.marcel-dierkes.DesktopTime.BatteryLevel.ShadowColor";

NS_INLINE NSFont *_Nullable DTIFontForKey(id<DTIDefaultsProvider> defaults, NSString *key)
{
    NSCParameterAssert(defaults);
    
    Auto data = [defaults dataForKey:key];
    if(data == nil) { return nil; }
    
    NSError *error;
    Auto font = (NSFont *)[NSKeyedUnarchiver unarchivedObjectOfClass:[NSFont class]
                                                            fromData:data error:&error];
    if(error != nil)
    {
        DTILog(@"Failed to unarchive font. %@", error.userInfo);
        return nil;
    }
    
    return font;
}

NS_INLINE void DTISetFontForKey(id<DTIDefaultsProvider> defaults, NSFont *_Nullable font, NSString *key)
{
    NSCParameterAssert(defaults);
    
    if(font == nil)
    {
        [defaults removeObjectForKey:key];
        return;
    }
    
    NSError *error;
    Auto data = [NSKeyedArchiver archivedDataWithRootObject:font
                                      requiringSecureCoding:YES
                                                      error:&error];
    if(error != nil)
    {
        DTILog(@"Failed to archive font. %@", error.userInfo);
        return;
    }
    
    [defaults setObject:data forKey:key];
}

NS_INLINE NSColor *_Nullable DTIColorForKey(id<DTIDefaultsProvider> defaults, NSString *key)
{
    NSCParameterAssert(defaults);
    
    Auto data = [defaults dataForKey:key];
    if(data == nil) { return nil; }
    
    NSError *error;
    Auto color = (NSColor *)[NSKeyedUnarchiver unarchivedObjectOfClass:[NSColor class]
                                                              fromData:data error:&error];
    if(error != nil)
    {
        DTILog(@"Failed to unarchive color. %@", error.userInfo);
        return nil;
    }
    
    return color;
}

NS_INLINE void DTISetColorForKey(id<DTIDefaultsProvider> defaults, NSColor *_Nullable color, NSString *key)
{
    NSCParameterAssert(defaults);
    
    if(color == nil)
    {
        [defaults removeObjectForKey:key];
        return;
    }
    
    NSError *error;
    Auto data = [NSKeyedArchiver archivedDataWithRootObject:color
                                      requiringSecureCoding:YES
                                                      error:&error];
    if(error != nil)
    {
        DTILog(@"Failed to archive color. %@", error.userInfo);
        return;
    }
    
    [defaults setObject:data forKey:key];
}

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

#pragma mark - First Launch

- (BOOL)isFirstLaunchFinished
{
    return [self.defaults boolForKey:DTIFirstLaunchFinishedKey];
}

- (void)setFirstLaunchFinished:(BOOL)firstLaunchFinished
{
    if(firstLaunchFinished == YES)
    {
        [self.defaults setBool:firstLaunchFinished forKey:DTIFirstLaunchFinishedKey];
    }
    else
    {
        [self.defaults removeObjectForKey:DTIFirstLaunchFinishedKey];
    }
}

- (void)performBlockOnFirstLaunch:(void(^)(void))block
{
    if([self isFirstLaunchFinished] == NO)
    {
        self.firstLaunchFinished = YES;
        block();
    }
}

#pragma mark - Layout

- (DTILayout *)layout
{
    Auto loadLayout = ^DTILayout *{
        Auto data = [self.defaults dataForKey:DTILayoutKey];
        if(data == nil) { return nil; }
        
        NSError *error;
        Auto layout = (DTILayout *)[NSKeyedUnarchiver unarchivedObjectOfClass:[DTILayout class]
                                                                     fromData:data error:&error];
        if(error != nil)
        {
            DTILog(@"Failed to unarchive layout. %@", error.userInfo);
            return nil;
        }
        return layout;
    };
    
    return loadLayout() ?: [DTILayout new];
}

- (void)setLayout:(DTILayout *)layout
{
    if(layout == nil)
    {
        [self.defaults removeObjectForKey:DTILayoutKey];
        return;
    }
    
    NSError *error;
    Auto data = [NSKeyedArchiver archivedDataWithRootObject:layout requiringSecureCoding:YES error:&error];
    if(error != nil)
    {
        DTILog(@"Failed to archive layout. %@", error.userInfo);
        return;
    }
    
    [self.defaults setObject:data forKey:DTILayoutKey];
    
    [DTINotificationCenter.defaultCenter postNotification:DTILayoutDidChangeNotification];
}

#pragma mark - Date & Time Appearance

- (NSFont *)dateTimeFont
{
    return DTIFontForKey(self.defaults, DTIDateTimeFontKey);
}

- (void)setDateTimeFont:(NSFont *)font
{
    DTISetFontForKey(self.defaults, font, DTIDateTimeFontKey);
}

#pragma mark - Battery Level Appearance

- (NSFont *)batteryLevelFont
{
    return DTIFontForKey(self.defaults, DTIBatteryLevelFontKey)
        ?: [NSFont systemFontOfSize:16.0f weight:NSFontWeightSemibold];;
}

- (void)setBatteryLevelFont:(NSFont *)font
{
    DTISetFontForKey(self.defaults, font, DTIBatteryLevelFontKey);
}

- (NSColor *)batteryLevelTextColor
{
    return DTIColorForKey(self.defaults, DTIBatteryLevelTextColorKey)
        ?: [NSColor colorWithWhite:0.94 alpha:1.0f];
}

- (void)setBatteryLevelTextColor:(NSColor *)textColor
{
    DTISetColorForKey(self.defaults, textColor, DTIBatteryLevelTextColorKey);
}

- (NSColor *)batteryLevelShadowColor
{
    return DTIColorForKey(self.defaults, DTIBatteryLevelShadowColorKey)
        ?: [NSColor.blackColor colorWithAlphaComponent:0.7f];
}

- (void)setBatteryLevelShadowColor:(NSColor *)shadowColor
{
    DTISetColorForKey(self.defaults, shadowColor, DTIBatteryLevelShadowColorKey);
}

@end
