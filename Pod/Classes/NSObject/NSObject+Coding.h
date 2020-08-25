//
//  NSObject+Coding.h
//  Takeaway
//
//  Created by hank on 2020/8/25.
//  Copyright © 2020 LZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 路径 */
//缓存路径-cach目录
NS_INLINE NSString *kHKFilePathAtCachWithName(NSString *fileNAme){
    static NSString *cachFilePath = nil;
    if (!cachFilePath) {
        cachFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    }
    return [cachFilePath stringByAppendingPathComponent:fileNAme];
}

//缓存路径-document目录
NS_INLINE NSString *kHKFilePathAtDocumentWithName(NSString *fileNAme){
    static NSString *documentFilePath = nil;
    if (!documentFilePath) {
        documentFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    }
    return [documentFilePath stringByAppendingPathComponent:fileNAme];
}

typedef enum{
    HKCodingPathDocument  = 0,//Document目录，不会清掉缓存
    HKCodingPathCach          = 1
}HKCodingPath;

@interface NSObject (Coding)

/**
 *  将模型的二进制数据写入Document目录
 *
 *  @param key 通过key来查找模型
 */
- (void)writeObjectForKey:(NSString *)key;

/**
 *  将模型的二进制数据写入指定路径
 *
 *  @param key  通过key来查找模型
 *  @param path 路径类型
 */
- (void)writeObjectForKey:(NSString *)key path:(HKCodingPath)path;

/**
 *  读取模型，注意要用读取的模型类调用
 *
 *  @param key 通过key来查找模型
 *
 *  @return 返回该模型实例
 */
+ (id)getObjctForKey:(NSString *)key;

/**
 *  读取模型，注意要用读取的模型类调用
 *
 *  @param key  通过key来查找模型
 *  @param path 路径类型
 *
 *  @return 返回该模型实例
 */
+ (id)getObjctForKey:(NSString *)key path:(HKCodingPath)path;

/**
 *  删除归档模型
 *
 *  @param key 通过key来删除归档的模型，默认删除Document目录
 */
+ (void)removeCodingForKey:(NSString *)key;

/**
 *  删除归档模型
 *
 *  @param key  通过key来删除归档的模型
 *  @param path 路径类型
 */
+ (void)removeCodingForKey:(NSString *)key path:(HKCodingPath)path;

@end


NS_ASSUME_NONNULL_END
