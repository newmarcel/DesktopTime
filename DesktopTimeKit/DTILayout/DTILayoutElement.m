//
//  DTILayoutElement.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 04.02.21.
//

#import "DTILayoutElement.h"
#import "DTIDefines.h"

NSString *DTILayoutElementGetLocalizedName(DTILayoutElement layoutElement)
{
    switch(layoutElement)
    {
        case DTILayoutElementNone: return NSLocalizedString(@"–", @"–");
        case DTILayoutElementDateTime: return NSLocalizedString(@"Date & Time", @"Date & Time");
        case DTILayoutElementDate: return NSLocalizedString(@"Date", @"Date");
        case DTILayoutElementTime: return NSLocalizedString(@"Time", @"Time");
        case DTILayoutElementBatteryLevel: return NSLocalizedString(@"Battery Level", @"Battery Level");
        default: return @"";
    }
}
