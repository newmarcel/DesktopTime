//
//  NSScreen+DTIWorkspaceMetrics.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.02.21.
//

#import "NSScreen+DTIWorkspaceMetrics.h"
#import "DTIDefines.h"
#import "DTIWorkspaceMetrics.h"
#import "DTIPreferences.h"

@implementation NSScreen (DTIWorkspaceMetrics)

- (DTIWorkspaceMetrics *)dti_workspaceMetrics
{
    Auto preferences = DTIPreferences.sharedPreferences;
    return [[DTIWorkspaceMetrics alloc] initWithScreenFrame:self.frame
                                               visibleFrame:self.visibleFrame
                                                preferences:preferences];
}

@end
