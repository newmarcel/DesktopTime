//
//  DTIPreferences.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.12.20.
//

#import <Foundation/Foundation.h>
#import <AppKit/NSFont.h>
#import <AppKit/NSColor.h>
#import <DesktopTimeKit/DTIDefaultsProvider.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const DTIFirstLaunchFinishedKey;
FOUNDATION_EXPORT NSString * const DTIAvoidsDockOverlappingKey;
FOUNDATION_EXPORT NSString * const DTIAvoidsMenuBarOverlappingKey;
FOUNDATION_EXPORT NSString * const DTILayoutKey;
FOUNDATION_EXPORT NSString * const DTIDateTimeFontKey;
FOUNDATION_EXPORT NSString * const DTIDateTimeTextColorKey;
FOUNDATION_EXPORT NSString * const DTIDateTimeShadowColorKey;
FOUNDATION_EXPORT NSString * const DTIBatteryLevelFontKey;
FOUNDATION_EXPORT NSString * const DTIBatteryLevelTextColorKey;
FOUNDATION_EXPORT NSString * const DTIBatteryLevelShadowColorKey;

@class DTILayout;

@interface DTIPreferences : NSObject
@property (class, nonatomic, readonly) DTIPreferences *sharedPreferences;
@property (nonatomic, readonly) id<DTIDefaultsProvider> defaults;

@property (nonatomic, getter=isFirstLaunchFinished) BOOL firstLaunchFinished;
@property (nonatomic) BOOL avoidsDockOverlapping;
@property (nonatomic) BOOL avoidsMenuBarOverlapping;

@property (nonatomic, null_resettable) DTILayout *layout;

@property (nonatomic, null_resettable) NSFont *dateTimeFont;
@property (nonatomic, null_resettable) NSColor *dateTimeTextColor;
@property (nonatomic, null_resettable) NSColor *dateTimeShadowColor;

@property (nonatomic, null_resettable) NSFont *batteryLevelFont;
@property (nonatomic, null_resettable) NSColor *batteryLevelTextColor;
@property (nonatomic, null_resettable) NSColor *batteryLevelShadowColor;

- (instancetype)init;
- (instancetype)initWithDefaultsProvider:(id<DTIDefaultsProvider>)defaults NS_DESIGNATED_INITIALIZER;

/// Performs the given block only when the app is launched for the first time
/// and marks the first launch as completed.
/// @param block A custom block
- (void)performBlockOnFirstLaunch:(void(NS_NOESCAPE ^)(void))block;

@end

NS_ASSUME_NONNULL_END
