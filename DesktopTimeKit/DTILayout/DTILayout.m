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

+ (NSSet<Class> *)knownElementClasses
{
    return [NSSet setWithArray:@[[DTILayoutElement class]]];
}

#pragma mark - NSSecureCoding

#define kCodingKeyDisplayMode @"DTIDisplayMode"

#define kCodingKeyTopLeftElement @"DTITopLeftElement"
#define kCodingKeyTopMiddleElement @"DTITopMiddleElement"
#define kCodingKeyTopRightElement @"DTITopRightElement"

#define kCodingKeyBottomLeftElement @"DTIBottomLeftElement"
#define kCodingKeyBottomMiddleElement @"DTIBottomMiddleElement"
#define kCodingKeyBottomRightElement @"DTIBottomRightElement"

#define DTI_DECODE_LAYOUT_ELEMENT(__klasses, __key) (__kindof DTILayoutElement *)[coder \
    decodeObjectOfClasses:__klasses forKey:__key];

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
        
        Auto klasses = [[self class] knownElementClasses];
        self.topLeftElement = DTI_DECODE_LAYOUT_ELEMENT(klasses, kCodingKeyTopLeftElement);
        self.topMiddleElement = DTI_DECODE_LAYOUT_ELEMENT(klasses, kCodingKeyTopMiddleElement);
        self.topRightElement = DTI_DECODE_LAYOUT_ELEMENT(klasses, kCodingKeyTopRightElement);
        
        self.bottomLeftElement = DTI_DECODE_LAYOUT_ELEMENT(klasses, kCodingKeyBottomLeftElement);
        self.bottomMiddleElement = DTI_DECODE_LAYOUT_ELEMENT(klasses, kCodingKeyBottomMiddleElement);
        self.bottomRightElement = DTI_DECODE_LAYOUT_ELEMENT(klasses, kCodingKeyBottomRightElement);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:(NSInteger)self.displayMode forKey:kCodingKeyDisplayMode];
    
    [coder encodeObject:self.topLeftElement forKey:kCodingKeyTopLeftElement];
    [coder encodeObject:self.topMiddleElement forKey:kCodingKeyTopMiddleElement];
    [coder encodeObject:self.topRightElement forKey:kCodingKeyTopRightElement];
    
    [coder encodeObject:self.bottomLeftElement forKey:kCodingKeyBottomLeftElement];
    [coder encodeObject:self.bottomMiddleElement forKey:kCodingKeyBottomMiddleElement];
    [coder encodeObject:self.bottomRightElement forKey:kCodingKeyBottomRightElement];
}

@end
