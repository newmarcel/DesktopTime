//
//  DTILayoutElementWindowController.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 05.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTILayoutElementWindowController : NSWindowController
@property (nonatomic, readonly) DTILayoutElement element;
@property (nonatomic, readonly) DTILayoutPosition position;
@property (weak, nonatomic) NSScreen *targetScreen;

+ (nullable  instancetype)windowControllerForElement:(DTILayoutElement)element
                                          atPosition:(DTILayoutPosition)position;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithWindowNibName:(NSNibName)windowNibName NS_UNAVAILABLE;

- (instancetype)initWithElement:(DTILayoutElement)element
                       Position:(DTILayoutPosition)position;

- (void)reloadWindow NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
