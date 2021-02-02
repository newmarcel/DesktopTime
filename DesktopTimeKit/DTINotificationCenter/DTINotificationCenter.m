//
//  DTINotificationCenter.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 09.01.21.
//

#import "DTINotificationCenter.h"
#import "DTIDefines.h"

const DTINotificationName DTIAppShouldTerminateNotification = @"DTIAppShouldTerminateNotification";

@interface DTINotificationCenter ()
@property (nonatomic) NSDistributedNotificationCenter *distributedCenter;
@end

@implementation DTINotificationCenter

+ (instancetype)defaultCenter
{
    static dispatch_once_t once;
    static DTINotificationCenter *defaultCenter;
    dispatch_once(&once, ^{
        defaultCenter = [self new];
    });
    return defaultCenter;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.distributedCenter = NSDistributedNotificationCenter.defaultCenter;
    }
    return self;
}

- (void)postNotification:(DTINotificationName)notification
{
    NSParameterAssert(notification);
    
    [self.distributedCenter postNotificationName:notification
                                          object:nil userInfo:nil
                              deliverImmediately:YES];
}

- (void)addObserver:(id)observer selector:(SEL)selector name:(DTINotificationName)notificationName
{
    NSParameterAssert(observer);
    NSParameterAssert(selector);
    NSParameterAssert(notificationName);
    
    [self.distributedCenter addObserver:observer
                               selector:selector
                                   name:notificationName
                                 object:nil];
}

- (void)removeObserver:(id)observer name:(DTINotificationName)notificationName
{
    NSParameterAssert(observer);
    NSParameterAssert(notificationName);
    
    [self.distributedCenter removeObserver:observer name:notificationName object:nil];
}

@end
