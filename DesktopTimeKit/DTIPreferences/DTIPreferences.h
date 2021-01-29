//
//  DTIPreferences.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.12.20.
//

#import <Foundation/Foundation.h>
#import <DesktopTimeKit/DTIDefaultsProvider.h>

NS_ASSUME_NONNULL_BEGIN

//FOUNDATION_EXPORT NSString * const DPLNonRetinaDisplayModesEnabledDefaultsKey;
//FOUNDATION_EXPORT NSString * const DPLIncreaseResolutionShortcutDefaultsKey;
//FOUNDATION_EXPORT NSString * const DPLDecreaseResolutionShortcutDefaultsKey;

@interface DTIPreferences : NSObject
@property (class, nonatomic, readonly) DTIPreferences *sharedPreferences;
@property (nonatomic, readonly) id<DTIDefaultsProvider> defaults;

//@property (nonatomic, getter=isLaunchAtLoginEnabled) BOOL launchAtLoginEnabled;

- (instancetype)init;
- (instancetype)initWithDefaultsProvider:(id<DTIDefaultsProvider>)defaults NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
