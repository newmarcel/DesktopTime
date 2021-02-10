//
//  DTILayoutWindowController.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 07.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTILayoutWindowElementDataSource;

@interface DTILayoutWindowController : NSWindowController
@property (nonatomic, nullable) DTILayout *layout;
@property (weak, nonatomic, nullable) NSScreen *targetScreen;
@property (weak, nonatomic, nullable) id<DTILayoutWindowElementDataSource> elementDataSource;

- (void)reloadWindow;

@end

@class DTILayoutElementDataSource;

@protocol DTILayoutWindowElementDataSource <NSObject>
- (nullable DTILayoutElementDataSource *)dataSourceForLayoutElement:(DTILayoutElement)element;
- (void)applyStyleOfLayoutElement:(DTILayoutElement)element toLabel:(NSTextField *)label;
@end

NS_ASSUME_NONNULL_END
