//
//  DTIPreferencesChildViewController.h
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DTIPreferenceItem;

@interface DTIPreferencesChildViewController : NSViewController
@property (class, nonatomic, readonly) NSUserInterfaceItemIdentifier identifier;
@property (class, nonatomic, readonly) DTIPreferenceItem *preferenceItem;
@property (nonatomic, readonly) NSString *preferredTitle;
@end

NS_ASSUME_NONNULL_END
