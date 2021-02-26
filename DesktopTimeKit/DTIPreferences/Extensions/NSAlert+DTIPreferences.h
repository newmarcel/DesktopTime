//
//  NSAlert+DTIPreferences.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 26.02.21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAlert (DTIPreferences)
@property (class, nonatomic, readonly) NSAlert *dti_welcomeAlert;

- (void)dti_runWelcomeAlertWithOpenPreferencesHandler:(void(^)(void))handler;

@end

NS_ASSUME_NONNULL_END
