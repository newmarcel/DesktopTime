//
//  DTIPreferences.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.12.20.
//

#import <Foundation/Foundation.h>
#import <AppKit/NSFont.h>
#import <DesktopTimeKit/DTIDefaultsProvider.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const DTIFirstLaunchFinishedKey;
FOUNDATION_EXPORT NSString * const DTIDateTimeFontKey;
FOUNDATION_EXPORT NSString * const DTIBatteryLevelFontKey;

@interface DTIPreferences : NSObject
@property (class, nonatomic, readonly) DTIPreferences *sharedPreferences;
@property (nonatomic, readonly) id<DTIDefaultsProvider> defaults;

@property (nonatomic, getter=isFirstLaunchFinished) BOOL firstLaunchFinished;

@property (nonatomic, nullable) NSFont *dateTimeFont;
@property (nonatomic, nullable) NSFont *batteryLevelFont;

- (instancetype)init;
- (instancetype)initWithDefaultsProvider:(id<DTIDefaultsProvider>)defaults NS_DESIGNATED_INITIALIZER;

/// Performs the given block only when the app is launched for the first time
/// and marks the first launch as completed.
/// @param block A custom block
- (void)performBlockOnFirstLaunch:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
