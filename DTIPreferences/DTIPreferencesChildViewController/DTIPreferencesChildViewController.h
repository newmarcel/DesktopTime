//
//  DTIPreferencesChildViewController.h
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTIPreferencesChildViewController : NSViewController
@property (class, nonatomic, readonly) NSUserInterfaceItemIdentifier identifier;
@property (nonatomic, readonly) NSString *preferredTitle;
@end

NS_ASSUME_NONNULL_END