//
//  DTIFontLocalizedDisplayNameValueTransformer.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 02.02.21.
//

#import "DTIFontLocalizedDisplayNameValueTransformer.h"
#import "NSFont+DTILocalizedDisplayName.h"

@implementation DTIFontLocalizedDisplayNameValueTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if(![value isKindOfClass:[NSFont class]]) { return [value description]; }
    return ((NSFont *)value).dti_localizedDisplayName;
}

@end
