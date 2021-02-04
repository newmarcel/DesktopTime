//
//  DTILayoutElementValueTransformer.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 04.02.21.
//

#import "DTILayoutElementValueTransformer.h"
#import "DTIDefines.h"

@implementation DTILayoutElementValueTransformer

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
    Auto numberValue = (NSNumber *)value;
    if(![numberValue isKindOfClass:[NSNumber class]]) { return [value description]; }
    DTILayoutElement layoutElement = (DTILayoutElement)numberValue.unsignedIntegerValue;
    return DTILayoutElementGetLocalizedName(layoutElement);
}

@end
