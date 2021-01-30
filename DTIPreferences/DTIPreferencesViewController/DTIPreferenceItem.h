//
//  DTIPreferenceItem.h
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import <Cocoa/Cocoa.h>
#import <DesktopTimeKit/DesktopTimeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTIPreferenceItem : NSObject
@property (nonatomic) NSUUID *UUID;
@property (nonatomic) NSString *name;

@property (nonatomic, nullable) id representedObject;

@property (nonatomic, getter=isHeader) BOOL header;
@property (nonatomic, getter=isExpanded) BOOL expanded;

@property (nonatomic, nullable) NSArray<DTIPreferenceItem *> *children;
@property (weak, nonatomic, nullable) DTIPreferenceItem *parent;

@property (nonatomic, nullable) NSImage *image;
@property (nonatomic, nullable) NSColor *tintColor;
@property (nonatomic, nullable, readonly) NSTintConfiguration *tintConfiguration;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithUUID:(NSUUID *)UUID
                        name:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithUUID:(NSUUID *)UUID
                  headerName:(NSString *)name
                       image:(nullable NSImage *)image
                    children:(nullable NSArray<DTIPreferenceItem *> *)children;

@end

NS_ASSUME_NONNULL_END
