//
//  NSScreen+DTIWorkspaceMetrics.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DTIWorkspaceMetrics.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSScreen (DTIWorkspaceMetrics)
@property (nonatomic, readonly) DTIWorkspaceMetrics *dti_workspaceMetrics;
@end

NS_ASSUME_NONNULL_END
