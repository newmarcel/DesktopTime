//
//  DTIBatteryStatus.m
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 21.12.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

#import "DTIBatteryStatus.h"
#import "DTIDefines.h"
#import <IOKit/ps/IOPowerSources.h>

const CGFloat DTIBatteryStatusUnavailable = -1.0;

static void DTIBatteryStatusChangeHandler(void *context);

@interface DTIBatteryStatus ()
@property (nonatomic, nullable) CFRunLoopSourceRef runLoopSource;
@property (nonatomic) NSNumberFormatter *percentFormatter;
@end

@implementation DTIBatteryStatus

- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

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

- (void)configurePercentFormatter
{
    Auto locale = NSLocale.currentLocale;
    Auto nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterPercentStyle;
    nf.locale = locale;
    nf.allowsFloats = NO;
    nf.formattingContext = NSFormattingContextStandalone;
    nf.lenient = YES;
    
    nf.minimum = @0.0f;
    nf.maximum = @100.0f;
    
    self.percentFormatter = nf;
}

- (NSString *)localizedCurrentCapacity
{
    CGFloat capacity = self.currentCapacity;
    if(capacity == DTIBatteryStatusUnavailable) { return @""; }
    
    if(self.percentFormatter == nil)
    {
        [self configurePercentFormatter];
    }
    
    return [self.percentFormatter stringFromNumber:@(capacity / 100.0f)];
}

- (CGFloat)currentCapacity
{
    Auto powerSourceInfos = [self powerSourceInfos];
    if(powerSourceInfos == nil)
    {
        return DTIBatteryStatusUnavailable;
    }
    
    Auto key = [NSString stringWithUTF8String:kIOPSCurrentCapacityKey];
    NSNumber *capacity = powerSourceInfos[key];
    if(capacity == nil)
    {
        return DTIBatteryStatusUnavailable;
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
    
    Auto runLoopSource = IOPSNotificationCreateRunLoopSource(DTIBatteryStatusChangeHandler, (__bridge void *)self);
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

#pragma mark - DTIBatteryStatusChangeHandler

static void DTIBatteryStatusChangeHandler(void *context)
{
    Auto batteryStatus = (__bridge DTIBatteryStatus *)context;
    if(batteryStatus.capacityChangeHandler)
    {
        batteryStatus.capacityChangeHandler(batteryStatus.currentCapacity);
    }
}
