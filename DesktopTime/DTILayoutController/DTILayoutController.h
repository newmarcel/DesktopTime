//
//  DTILayoutController.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 05.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTILayoutController : NSObject
@property (nonatomic, readonly, nullable) DTILayout *currentLayout;

- (void)reloadLayout;

@end

NS_ASSUME_NONNULL_END
