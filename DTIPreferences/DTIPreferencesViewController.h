//
//  DTIPreferencesViewController.h
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTIPreferencesViewController : NSViewController <NSOutlineViewDataSource, NSOutlineViewDelegate>
@property (weak, nonatomic, nullable) IBOutlet NSOutlineView *outlineView;
@end

NS_ASSUME_NONNULL_END
