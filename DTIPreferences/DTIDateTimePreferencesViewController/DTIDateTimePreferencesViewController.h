//
//  DTIDateTimePreferencesViewController.h
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import <Cocoa/Cocoa.h>
#import "DTIPreferencesContentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTIDateTimePreferencesViewController : DTIPreferencesContentViewController
@property (weak, nonatomic, nullable) IBOutlet NSTextField *fontTextField;

- (IBAction)resetDefaultValues:(id)sender;

@end

NS_ASSUME_NONNULL_END
