//
//  DTIPreferenceItemViewModel.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTIPreferenceItemViewModel.h"
#import "DTIDefines.h"

@interface DTIPreferenceItemViewModel ()
@end

@implementation DTIPreferenceItemViewModel

- (instancetype)initWithUUID:(NSUUID *)UUID name:(NSString *)name
{
    NSParameterAssert(UUID);
    NSParameterAssert(name);
    
    self = [super init];
    if(self)
    {
        self.UUID = UUID;
        self.name = name;
    }
    return self;
}

- (instancetype)initWithUUID:(NSUUID *)UUID headerName:(NSString *)name image:(NSImage *)image children:(NSArray<DTIPreferenceItemViewModel *> *)children
{
    NSParameterAssert(UUID);
    NSParameterAssert(name);
    
    Auto item = [self initWithUUID:UUID name:name];
    item.header = YES;
    item.expanded = YES;
    item.children = children;
    item.image = image;
    return item;
}

- (NSImage *)image
{
    Auto parent = self.parent;
    if(parent != nil && parent.image != nil) { return parent.image; }
    return _image;
}

- (NSColor *)tintColor
{
    Auto parent = self.parent;
    if(parent != nil && parent.tintColor != nil) { return parent.tintColor; }
    return _tintColor;
}

- (NSTintConfiguration *)tintConfiguration
{
    Auto tintColor = self.tintColor;
    if(tintColor != nil)
    {
        return [NSTintConfiguration tintConfigurationWithPreferredColor:tintColor];
    }
    return nil;
}

@end
