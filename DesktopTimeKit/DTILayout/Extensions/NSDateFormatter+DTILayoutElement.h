//
//  NSDateFormatter+DTILayoutElement.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 06.02.21.
//

#import <Foundation/Foundation.h>
#import <DesktopTimeKit/DTILayoutElement.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (DTILayoutElement)

+ (instancetype)dti_dateFormatterForLayoutElement:(DTILayoutElement)layoutElement;

@end

NS_ASSUME_NONNULL_END
