//
//  DTIWorkspaceMetrics.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.02.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DTIWorkspaceDockPosition)
{
    DTIWorkspaceDockPositionNone = 0,
    DTIWorkspaceDockPositionLeft,
    DTIWorkspaceDockPositionBottom,
    DTIWorkspaceDockPositionRight
};

@class DTIPreferences;

@interface DTIWorkspaceDockMetrics : NSObject
@property (nonatomic, readonly) CGFloat thickness;
@property (nonatomic, readonly) DTIWorkspaceDockPosition position;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

@interface DTIWorkspaceMenuBarMetrics : NSObject
@property (nonatomic, readonly) CGFloat thickness;
@property (nonatomic, readonly, getter=isHidden) BOOL hidden;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

@interface DTIWorkspaceMetrics : NSObject
@property (nonatomic, readonly) DTIWorkspaceDockMetrics *dockMetrics;
@property (nonatomic, readonly) DTIWorkspaceMenuBarMetrics *menuBarMetrics;
@property (nonatomic, readonly) CGRect usableFrame;
@property (nonatomic, readonly) NSEdgeInsets usableEdgeInsets;
@property (nonatomic, readonly) DTIPreferences *preferences;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithScreenFrame:(CGRect)screenFrame
                       visibleFrame:(CGRect)visibleFrame
                        preferences:(DTIPreferences *)preferences NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
