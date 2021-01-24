//
//  DTIAppGroup.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.12.20.
//

#import "DTIAppGroup.h"
#import "DTIDefines.h"

NSString * const DTIAppGroupIdentifier = @"group.info.marcel-dierkes.DesktopTime";
static NSString * const DTIAppGroupDefaultDirectoryName = @"DesktopTime";

NSURL *DTIAppGroupGetURLWithPathComponent(NSString *pathComponent)
{
    NSCParameterAssert(pathComponent);
    
    Auto fileManager = NSFileManager.defaultManager;
    Auto identifier = DTIAppGroupIdentifier;
    Auto container = [fileManager containerURLForSecurityApplicationGroupIdentifier:identifier];
    
    Auto URL = [container URLByAppendingPathComponent:pathComponent];
    if(![fileManager fileExistsAtPath:URL.path])
    {
        NSError *error;
        [fileManager createDirectoryAtURL:URL withIntermediateDirectories:YES attributes:nil error:&error];
        if(error != nil)
        {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"Could not create app group directory."
                                         userInfo:@{NSUnderlyingErrorKey: error}];
        }
    }
    return URL;
}

NSURL *DTIAppGroupGetDefaultDirectoryURL()
{
    return DTIAppGroupGetURLWithPathComponent(DTIAppGroupDefaultDirectoryName);
}

NSUserDefaults *DTIAppGroupGetUserDefaults()
{
    return [[NSUserDefaults alloc] initWithSuiteName:DTIAppGroupIdentifier];
}
