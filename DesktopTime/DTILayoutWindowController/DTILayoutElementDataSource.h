//
//  DTILayoutElementDataSource.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 08.02.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTILayoutElementDataSource : NSObject
@property (nonatomic, readonly) DTILayoutElement element;
@property (nonatomic, readonly, nullable) NSString *stringValue;

+ (nullable instancetype)dataSourceForElement:(DTILayoutElement)element;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithElement:(DTILayoutElement)element;

@end

NS_ASSUME_NONNULL_END
