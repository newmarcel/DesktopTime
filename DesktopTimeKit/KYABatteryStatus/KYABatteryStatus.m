//
//  KYABatteryStatus.m
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 21.12.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

#import "KYABatteryStatus.h"
#import "DTIDefines.h"
#import <IOKit/ps/IOPowerSources.h>

const CGFloat KYABatteryStatusUnavailable = -1.0;

static void KYABatteryStatusChangeHandler(void *context);

@interface KYABatteryStatus ()
@property (nonatomic, nullable) CFRunLoopSourceRef runLoopSource;
@end

@implementation KYABatteryStatus

- (void)dealloc
{
    [self unregisterFromCapacityChanges];
}

- (BOOL)isBatteryStatusAvailable
{
    Auto powerSourceInfos = [self powerSourceInfos];
    if(powerSourceInfos == nil)
    {
        return NO;
    }
    
    Auto key = [NSString stringWithUTF8String:kIOPSTypeKey];
    Auto internalBatteryTypeKey = [NSString stringWithUTF8String:kIOPSInternalBatteryType];
    NSString *batteryType = powerSourceInfos[key];
    return [batteryType isEqualToString:internalBatteryTypeKey];
}

- (CGFloat)currentCapacity
{
    Auto powerSourceInfos = [self powerSourceInfos];
    if(powerSourceInfos == nil)
    {
        return KYABatteryStatusUnavailable;
    }
    
    Auto key = [NSString stringWithUTF8String:kIOPSCurrentCapacityKey];
    NSNumber *capacity = powerSourceInfos[key];
    if(capacity == nil)
    {
        return KYABatteryStatusUnavailable;
    }
    
    return capacity.floatValue;
}

- (nullable NSDictionary *)powerSourceInfos
{
    Auto blob = IOPSCopyPowerSourcesInfo();
    Auto sourcesList = IOPSCopyPowerSourcesList(blob);
    CFRelease(blob);
    
    if(CFArrayGetCount(sourcesList) == 0) {
        CFRelease(sourcesList);
        return nil;
    }
    
    Auto powerSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sourcesList, 0));
    CFRetain(powerSource);
    CFRelease(sourcesList);
    
    CFAutorelease(powerSource);
    return (__bridge NSDictionary *)powerSource;
}

#pragma mark - Capacity Change Handler

- (void)registerForCapacityChangesIfNeeded
{
    if(self.runLoopSource)
    {
        return;
    }
    
    Auto runLoopSource = IOPSNotificationCreateRunLoopSource(KYABatteryStatusChangeHandler, (__bridge void *)self);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopDefaultMode);
    
    self.runLoopSource = runLoopSource;
    CFRelease(runLoopSource);
}

- (void)unregisterFromCapacityChanges
{
    if(!self.runLoopSource)
    {
        return;
    }
    
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), self.runLoopSource, kCFRunLoopDefaultMode);
    self.runLoopSource = nil;
}

@end

#pragma mark - KYABatteryStatusChangeHandler

static void KYABatteryStatusChangeHandler(void *context)
{
    Auto batteryStatus = (__bridge KYABatteryStatus *)context;
    if(batteryStatus.capacityChangeHandler)
    {
        batteryStatus.capacityChangeHandler(batteryStatus.currentCapacity);
    }
}
