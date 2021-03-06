//
//  DTILayoutPreferencesViewController.h
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import <Cocoa/Cocoa.h>
#import "DTIPreferencesContentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTILayoutPreferencesViewController : DTIPreferencesContentViewController
@property (nonatomic, readonly) DTILayout *layout;

@end

NS_ASSUME_NONNULL_END
