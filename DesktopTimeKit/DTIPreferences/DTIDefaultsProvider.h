//
//  DTIDefaultsProvider.h
//  DesktopTimeKit
//
//  Created by Marcel Dierkes on 23.12.20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTIDefaultsProvider <NSObject>
- (void)removeObjectForKey:(NSString *)defaultName;

- (nullable id)objectForKey:(NSString *)defaultName;
- (void)setObject:(nullable id)value forKey:(NSString *)defaultName;

- (nullable NSString *)stringForKey:(NSString *)defaultName;
- (nullable NSData *)dataForKey:(NSString *)defaultName;

- (NSInteger)integerForKey:(NSString *)defaultName;
- (float)floatForKey:(NSString *)defaultName;
- (double)doubleForKey:(NSString *)defaultName;
- (BOOL)boolForKey:(NSString *)defaultName;
- (nullable NSURL *)URLForKey:(NSString *)defaultName;

- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)setFloat:(float)value forKey:(NSString *)defaultName;
- (void)setDouble:(double)value forKey:(NSString *)defaultName;
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
- (void)setURL:(nullable NSURL *)url forKey:(NSString *)defaultName;
@end

@interface NSUserDefaults (DTIDefaultsProvider) <DTIDefaultsProvider>
@end

NS_ASSUME_NONNULL_END
