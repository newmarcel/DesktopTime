//
//  DTITimeWindowController.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTITimeWindowController : NSWindowController
@property (weak, nonatomic) NSScreen *targetScreen;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
