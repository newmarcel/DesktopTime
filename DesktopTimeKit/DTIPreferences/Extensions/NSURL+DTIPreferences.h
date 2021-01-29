//
//  NSURL+DTIPreferences.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 26.12.20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (DTIPreferences)
@property (class, nonatomic, readonly) NSURL *dti_preferencesAppURL;
@end

NS_ASSUME_NONNULL_END
