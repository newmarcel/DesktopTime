//
//  NSDateFormatter+DTILayoutElement.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 06.02.21.
//

#import "NSDateFormatter+DTILayoutElement.h"
#import "DTIDefines.h"

@implementation NSDateFormatter (DTILayoutElement)

+ (instancetype)dti_dateFormatterForLayoutElement:(DTILayoutElement)layoutElement
{
    Auto locale = NSLocale.currentLocale;
    Auto df = [NSDateFormatter new];
    df.formattingContext = NSFormattingContextStandalone;
    
    switch(layoutElement)
    {
        case DTILayoutElementDate:
            df.dateStyle = NSDateFormatterLongStyle;
            df.timeStyle = NSDateFormatterNoStyle;
            break;
        case DTILayoutElementTime:
            df.dateStyle = NSDateFormatterNoStyle;
            df.timeStyle = NSDateFormatterShortStyle;
            break;
        default:
            df.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"eddMMMHHmm"
                                                            options:0
                                                             locale:locale];
            break;
    }
    
    return df;
}

@end
