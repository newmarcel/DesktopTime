//
//  DTILayoutElement.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 04.02.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DTILayoutElement)
{
    DTILayoutElementNone = 0,
    DTILayoutElementDateTime,
    DTILayoutElementDate,
    DTILayoutElementTime,
    DTILayoutElementBatteryLevel,
};

NSString *DTILayoutElementGetLocalizedName(DTILayoutElement);
NSArray<NSString *> *DTILayoutElementGetAllElements(void);

NS_ASSUME_NONNULL_END
