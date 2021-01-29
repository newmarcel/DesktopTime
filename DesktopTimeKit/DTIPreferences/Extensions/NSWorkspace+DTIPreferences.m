//
//  NSWorkspace+DTIPreferences.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 27.12.20.
//

#import "NSWorkspace+DTIPreferences.h"
#import "DTIDefines.h"
#import "NSURL+DTIPreferences.h"

@implementation NSWorkspace (DTIPreferences)

- (void)dti_openPreferencesWithCompletionHandler:(void(^)(NSRunningApplication *app, NSError *error))completionHandler
{
    Auto appURL = NSURL.dti_preferencesAppURL;
    Auto config = [NSWorkspaceOpenConfiguration configuration];
    config.addsToRecentItems = NO;
    
    [self openApplicationAtURL:appURL
                 configuration:config
             completionHandler:^(NSRunningApplication *app, NSError *error) {
        if(completionHandler != nil)
        {
            completionHandler(app, error);
        }
    }];
}

@end
