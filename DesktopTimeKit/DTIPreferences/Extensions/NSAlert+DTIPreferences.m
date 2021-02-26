//
//  NSAlert+DTIPreferences.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 26.02.21.
//

#import "NSAlert+DTIPreferences.h"
#import "DTIDefines.h"

#define DTI_L10N_WELCOME_TITLE NSLocalizedString(@"Welcome to DesktopTime", @"Welcome to DesktopTime")
#define DTI_L10N_WELCOME_MESSAGE NSLocalizedString( \
    @"DesktopTime allows you to show the time, date and other information on your desktop. Open the app again to show preferences and to completely quit the app.", \
    @"DesktopTime allows you to show the time, date and other information on your desktop. Open the app again to show preferences and to completely quit the app.")
#define DTI_L10N_WELCOME_OK NSLocalizedString(@"OK", @"OK")
#define DTI_L10N_WELCOME_OPEN_PREFERENCES NSLocalizedString(@"Open Preferences", @"Open Preferences")

@implementation NSAlert (DTIPreferences)

+ (NSAlert *)dti_welcomeAlert
{
    Auto alert = [NSAlert new];
    alert.alertStyle = NSAlertStyleInformational;
    alert.informativeText = DTI_L10N_WELCOME_MESSAGE;
    alert.messageText = DTI_L10N_WELCOME_TITLE;
    [alert addButtonWithTitle:DTI_L10N_WELCOME_OK];
    [alert addButtonWithTitle:DTI_L10N_WELCOME_OPEN_PREFERENCES];
    return alert;
}

- (void)dti_runWelcomeAlertWithOpenPreferencesHandler:(void (^)(void))handler
{
    NSParameterAssert(handler);
    
    NSModalResponse response = [self runModal];
    if(response == NSAlertSecondButtonReturn)
    {
        handler();
    }
}

@end
