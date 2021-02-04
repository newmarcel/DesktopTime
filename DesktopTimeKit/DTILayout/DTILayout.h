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

@property (nonatomic) DTILayoutElement topLeftElement;
@property (nonatomic) DTILayoutElement topMiddleElement;
@property (nonatomic) DTILayoutElement topRightElement;

@property (nonatomic) DTILayoutElement bottomLeftElement;
@property (nonatomic) DTILayoutElement bottomMiddleElement;
@property (nonatomic) DTILayoutElement bottomRightElement;

@end

NS_ASSUME_NONNULL_END
