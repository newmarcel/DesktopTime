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

+ (instancetype)new;
- (instancetype)init;

- (void)startTimer;
- (void)stopTimer;

- (void)reloadLayout;

@end

NS_ASSUME_NONNULL_END
