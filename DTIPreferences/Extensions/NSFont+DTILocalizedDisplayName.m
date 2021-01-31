//
//  NSFont+DTILocalizedDisplayName.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 31.01.21.
//

#import "NSFont+DTILocalizedDisplayName.h"
#import "DTIDefines.h"

@implementation NSFont (DTILocalizedDisplayName)

- (NSString *)dti_localizedDisplayName
{
    Auto fontName = self.displayName;
    Auto fontSize = @(self.pointSize);
    Auto fontSizeName = [[self numberFormatter] stringFromNumber:fontSize];
    return [NSString stringWithFormat:@"%@ %@", fontName, fontSizeName];
}

- (NSNumberFormatter *)numberFormatter
{
    Auto nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    nf.minimumFractionDigits = 1;
    nf.formattingContext = NSFormattingContextStandalone;
    return nf;
}

@end
