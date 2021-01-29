//
//  NSWorkspace+DTIPreferences.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 27.12.20.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DTIOpenPreferencesCompletionHandler)(NSRunningApplication *_Nullable app,
                                                   NSError *_Nullable error);

@interface NSWorkspace (DTIPreferences)

/// Opens the preferences app and calls the completion handler
/// either with the running app instance or an error.
/// @param completionHandler An optional completion handler, called on a private queue
- (void)dti_openPreferencesWithCompletionHandler:(nullable DTIOpenPreferencesCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
