//
//  DTIPreferencesWindowController.h
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 29.01.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTIPreferencesWindowController : NSWindowController

- (IBAction)completelyTerminate:(id)sender;
- (IBAction)showAboutPanel:(nullable id)sender;

@end

NS_ASSUME_NONNULL_END
