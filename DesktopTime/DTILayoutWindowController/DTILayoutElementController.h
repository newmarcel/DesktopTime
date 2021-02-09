//
//  DTILayoutElementController.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 08.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTILayoutElementController : NSObject
@property (nonatomic, readonly) DTILayoutElement element;
@property (weak, nonatomic, nullable, readonly) NSTextField *textLabel;

+ (nullable instancetype)controllerForElement:(DTILayoutElement)element
                                    textLabel:(NSTextField *)textLabel;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithElement:(DTILayoutElement)element
                      textLabel:(NSTextField *)textLabel;

@end

NS_ASSUME_NONNULL_END
