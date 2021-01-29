//
//  NSURL+DTIPreferences.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 26.12.20.
//

#import "NSURL+DTIPreferences.h"
#import "DTIDefines.h"

static NSString * const DTIPreferencesAppBundleName = @"DesktopTime Preferences.app";

@implementation NSURL (DTIPreferences)

+ (NSURL *)dti_preferencesAppURL
{
    Auto executableBaseURL = NSBundle.mainBundle.executableURL.URLByDeletingLastPathComponent;
    return [executableBaseURL URLByAppendingPathComponent:DTIPreferencesAppBundleName
                                              isDirectory:NO];
}

@end
