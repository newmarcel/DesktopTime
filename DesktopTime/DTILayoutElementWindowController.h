//
//  DTILayoutElementWindowController.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 05.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DTIDateTimeDisplayMode) {
    DTIDateTimeDisplayModeDateTime = 0,
    DTIDateTimeDisplayModeDate,
    DTIDateTimeDisplayModeTime
};

@interface DTILayoutElementWindowController : NSWindowController
@property (nonatomic, readonly) DTILayoutPosition position;
@property (weak, nonatomic) NSScreen *targetScreen;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithWindowNibName:(NSNibName)windowNibName NS_UNAVAILABLE;

- (instancetype)initWithPosition:(DTILayoutPosition)position;

- (void)reloadWindow;

@end

@interface DTIDateTimeLayoutElementWindowController : DTILayoutElementWindowController
@property (nonatomic) DTIDateTimeDisplayMode displayMode;
@end

@interface DTIBatteryLevelLayoutElementWindowController : DTILayoutElementWindowController
@end

NS_ASSUME_NONNULL_END
