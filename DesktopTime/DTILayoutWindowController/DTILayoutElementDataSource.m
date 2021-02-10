//
//  DTILayoutElementDataSource.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 08.02.21.
//

#import "DTILayoutElementDataSource.h"
#import "DTIDefines.h"

typedef NS_ENUM(NSUInteger, DTILayoutElementDateTimeMode)
{
    DTILayoutElementDateTimeModeDateTime = 0,
    DTILayoutElementDateTimeModeDate,
    DTILayoutElementDateTimeModeTime,
};

@interface DTILayoutElementDataSource ()
@property (nonatomic, readwrite) DTILayoutElement element;
@end

@interface DTILayoutElementDateTimeDataSource : DTILayoutElementDataSource
@property (nonatomic) DTILayoutElementDateTimeMode mode;
@property (nonatomic) NSDateFormatter *dateFormatter;
@end

@interface DTILayoutElementBatteryLevelDataSource : DTILayoutElementDataSource
@property (nonatomic) DTIBatteryStatus *batteryStatus;
@end

@implementation DTILayoutElementDataSource

+ (instancetype)dataSourceForElement:(DTILayoutElement)element
{
    switch(element)
    {
        case DTILayoutElementDateTime:
        case DTILayoutElementDate:
        case DTILayoutElementTime:
            return [[DTILayoutElementDateTimeDataSource alloc] initWithElement:element];
        case DTILayoutElementBatteryLevel:
            return [[DTILayoutElementBatteryLevelDataSource alloc] initWithElement:element];
        default:
            return nil;
    }
}

- (instancetype)initWithElement:(DTILayoutElement)element
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

- (NSString *)stringValue
{
    return nil;
}

@end

@implementation DTILayoutElementDateTimeDataSource

- (instancetype)initWithElement:(DTILayoutElement)element
{
    self = [super initWithElement:element];
    if(self)
    {
        self.dateFormatter = [NSDateFormatter dti_dateFormatterForLayoutElement:element];
    }
    return self;
}

- (NSString *)stringValue
{
    Auto now = [NSDate date];
    return [self.dateFormatter stringFromDate:now];
}

@end

@implementation DTILayoutElementBatteryLevelDataSource

- (instancetype)initWithElement:(DTILayoutElement)element
{
    self = [super initWithElement:element];
    if(self)
    {
        self.batteryStatus = [DTIBatteryStatus new];
    }
    return self;
}

- (NSString *)stringValue
{
    return self.batteryStatus.localizedCurrentCapacity;
}

@end
