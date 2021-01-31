//
//  NSFont+DTILocalizedDisplayName.h
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 31.01.21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFont (DTILocalizedDisplayName)
/// A localized version of `displayName`, incl. the font size.
@property (nonatomic, readonly) NSString *dti_localizedDisplayName;
@end

NS_ASSUME_NONNULL_END
