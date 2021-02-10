//
//  DTILayoutWindowController.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 07.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTILayoutWindowController : NSWindowController
@property (nonatomic, nullable) DTILayout *layout;
@property (weak, nonatomic) NSScreen *targetScreen;

- (void)reloadWindow;

@end

NS_ASSUME_NONNULL_END
