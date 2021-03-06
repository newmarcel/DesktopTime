//
//  DTILayout.m
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 04.02.21.
//

#import "DTILayout.h"
#import "DTIDefines.h"

@interface DTILayout ()
@end

@implementation DTILayout

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.bottomRightElement = DTILayoutElementDateTime;
    }
    return self;
}

- (DTILayoutElement)elementAtPosition:(DTILayoutPosition)position
{
    switch(position)
    {
        case DTILayoutPositionUndefined: return DTILayoutElementNone;
        case DTILayoutPositionTopLeft: return self.topLeftElement;
        case DTILayoutPositionTopMiddle: return self.topMiddleElement;
        case DTILayoutPositionTopRight: return self.topRightElement;
        case DTILayoutPositionBottomLeft: return self.bottomLeftElement;
        case DTILayoutPositionBottomMiddle: return self.bottomMiddleElement;
        case DTILayoutPositionBottomRight: return self.bottomRightElement;
    }
}

#pragma mark - Description

- (NSString *)description
{
    return [NSString stringWithFormat:
            @"%@:\n"
            @"[%@] - [%@] - [%@]\n"
            @"[%@] - [%@] - [%@]",
            super.description,
            DTILayoutElementGetLocalizedName(self.topLeftElement),
            DTILayoutElementGetLocalizedName(self.topMiddleElement),
            DTILayoutElementGetLocalizedName(self.topRightElement),
            DTILayoutElementGetLocalizedName(self.bottomLeftElement),
            DTILayoutElementGetLocalizedName(self.bottomMiddleElement),
            DTILayoutElementGetLocalizedName(self.bottomRightElement)
            ];
}

#pragma mark - KVO

- (void)didChangeValueForKey:(NSString *)key
{
    [super didChangeValueForKey:key];
    
    Auto delegate = self.delegate;
    if([delegate respondsToSelector:@selector(layoutDidChange:keyPath:)])
    {
        [delegate layoutDidChange:self keyPath:key];
    }
}

#pragma mark - NSSecureCoding

#define kCodingKeyDisplayMode @"DTIDisplayMode"

#define kCodingKeyTopLeftElement @"DTITopLeftElement"
#define kCodingKeyTopMiddleElement @"DTITopMiddleElement"
#define kCodingKeyTopRightElement @"DTITopRightElement"

#define kCodingKeyBottomLeftElement @"DTIBottomLeftElement"
#define kCodingKeyBottomMiddleElement @"DTIBottomMiddleElement"
#define kCodingKeyBottomRightElement @"DTIBottomRightElement"

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if(self)
    {
        self.displayMode = (DTILayoutDisplayMode)[coder decodeIntegerForKey:kCodingKeyDisplayMode];
        
        self.topLeftElement = (DTILayoutElement)[coder decodeIntegerForKey:kCodingKeyTopLeftElement];
        self.topMiddleElement = (DTILayoutElement)[coder decodeIntegerForKey:kCodingKeyTopMiddleElement];
        self.topRightElement = (DTILayoutElement)[coder decodeIntegerForKey:kCodingKeyTopRightElement];
        
        self.bottomLeftElement = (DTILayoutElement)[coder decodeIntegerForKey:kCodingKeyBottomLeftElement];
        self.bottomMiddleElement = (DTILayoutElement)[coder decodeIntegerForKey:kCodingKeyBottomMiddleElement];
        self.bottomRightElement = (DTILayoutElement)[coder decodeIntegerForKey:kCodingKeyBottomRightElement];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:(NSInteger)self.displayMode forKey:kCodingKeyDisplayMode];
    
    [coder encodeInteger:(NSInteger)self.topLeftElement forKey:kCodingKeyTopLeftElement];
    [coder encodeInteger:(NSInteger)self.topMiddleElement forKey:kCodingKeyTopMiddleElement];
    [coder encodeInteger:(NSInteger)self.topRightElement forKey:kCodingKeyTopRightElement];
    
    [coder encodeInteger:(NSInteger)self.bottomLeftElement forKey:kCodingKeyBottomLeftElement];
    [coder encodeInteger:(NSInteger)self.bottomMiddleElement forKey:kCodingKeyBottomMiddleElement];
    [coder encodeInteger:(NSInteger)self.bottomRightElement forKey:kCodingKeyBottomRightElement];
}

@end
