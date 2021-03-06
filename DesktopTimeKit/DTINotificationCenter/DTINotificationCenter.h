//
//  DTINotificationCenter.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 09.01.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSNotificationName DTINotificationName NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT const DTINotificationName DTIAppShouldTerminateNotification;
FOUNDATION_EXPORT const DTINotificationName DTILayoutDidChangeNotification;

@interface DTINotificationCenter : NSObject
@property (class, nonatomic, readonly) DTINotificationCenter *defaultCenter;

- (void)postNotification:(DTINotificationName)notification;

- (void)addObserver:(id)observer selector:(SEL)selector name:(DTINotificationName)notificationName;
- (void)removeObserver:(id)observer name:(DTINotificationName)notificationName;

@end

NS_ASSUME_NONNULL_END
