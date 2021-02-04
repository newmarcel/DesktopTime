//
//  DTILayout.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 04.02.21.
//

#import <Foundation/Foundation.h>
#import <DesktopTimeKit/DTILayoutElement.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DTILayoutDisplayMode)
{
    DTILayoutDisplayModeAllDisplays = 0,
    DTILayoutDisplayModeOnlyMainDisplay,
    DTILayoutDisplayModeOnlySecondaryDisplays,
};

@interface DTILayout : NSObject <NSSecureCoding>
@property (nonatomic) DTILayoutDisplayMode displayMode;

@property (nonatomic, nullable) __kindof DTILayoutElement *topLeftElement;
@property (nonatomic, nullable) __kindof DTILayoutElement *topMiddleElement;
@property (nonatomic, nullable) __kindof DTILayoutElement *topRightElement;

@property (nonatomic, nullable) __kindof DTILayoutElement *bottomLeftElement;
@property (nonatomic, nullable) __kindof DTILayoutElement *bottomMiddleElement;
@property (nonatomic, nullable) __kindof DTILayoutElement *bottomRightElement;

@end

NS_ASSUME_NONNULL_END
