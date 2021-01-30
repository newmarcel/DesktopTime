//
//  DTIBatteryStatus.h
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 21.12.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT const CGFloat DTIBatteryStatusUnavailable;

typedef void(^DTIBatteryStatusChangeBlock)(CGFloat capacity);

/**
 An object that represents the current battery capacity.
 */
@interface DTIBatteryStatus : NSObject

/**
 Returns YES if the current device actually has a built-in battery.
 */
@property (nonatomic, readonly, getter=isBatteryStatusAvailable) BOOL batteryStatusAvailable;

/// Returns the current battery charging level of the internal battery,
/// or `DTIBatteryStatusUnavailable`.
@property (nonatomic, readonly) CGFloat currentCapacity;

/// Returns a localized string representation of `currentCapacity`.
@property (nonatomic, readonly) NSString *localizedCurrentCapacity;

/**
 An optional block that will be called when the power source changes and
 registerForCapacityChanges was called.
 */
@property (copy, nonatomic, nullable) DTIBatteryStatusChangeBlock capacityChangeHandler;

/**
 Registers the current instance with the runloop to receive power source change notifications.
 
 The capacityChangeHandler block will be called when a power source change occurs.
 */
- (void)registerForCapacityChangesIfNeeded;

/**
 Unregisters the current instance from all capacity change notifications.
 This method will automatically be called on dealloc.
 */
- (void)unregisterFromCapacityChanges;

@end

NS_ASSUME_NONNULL_END
