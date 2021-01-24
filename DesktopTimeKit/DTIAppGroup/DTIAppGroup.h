//
//  DTIAppGroup.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.12.20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const DTIAppGroupIdentifier;

NSURL *DTIAppGroupGetURLWithPathComponent(NSString *);

NSURL *DTIAppGroupGetDefaultDirectoryURL(void);

NSUserDefaults *DTIAppGroupGetUserDefaults(void);

NS_ASSUME_NONNULL_END
