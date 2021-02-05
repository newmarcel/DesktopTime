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

@protocol DTILayoutDelegate;

@interface DTILayout : NSObject <NSSecureCoding>
@property (weak, nonatomic, nullable) id<DTILayoutDelegate> delegate;

@property (nonatomic) DTILayoutDisplayMode displayMode;

@property (nonatomic) DTILayoutElement topLeftElement;
@property (nonatomic) DTILayoutElement topMiddleElement;
@property (nonatomic) DTILayoutElement topRightElement;

@property (nonatomic) DTILayoutElement bottomLeftElement;
@property (nonatomic) DTILayoutElement bottomMiddleElement;
@property (nonatomic) DTILayoutElement bottomRightElement;

@end

@protocol DTILayoutDelegate <NSObject>
@optional
- (void)layoutDidChange:(DTILayout *)layout keyPath:(NSString *)keyPath;
@end

NS_ASSUME_NONNULL_END
