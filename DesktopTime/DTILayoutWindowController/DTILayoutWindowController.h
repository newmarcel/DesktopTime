//
//  DTILayoutWindowController.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 07.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTILayoutWindowControllerDataSource;

@interface DTILayoutWindowController : NSWindowController
@property (weak, nonatomic, nullable) id<DTILayoutWindowControllerDataSource> dataSource;
@property (weak, nonatomic) NSScreen *targetScreen;

- (void)reloadLayout;

@end

@protocol DTILayoutWindowControllerDataSource <NSObject>
//- (DTILayout *)layoutForLayoutWindowController:(DTILayoutWindowController *)controller;
@end

NS_ASSUME_NONNULL_END
