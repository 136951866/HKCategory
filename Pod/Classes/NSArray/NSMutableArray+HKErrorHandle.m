//
//  NSMutableArray+HKErrorHandle.m
//  Takeaway
//
//  Created by hank on 2020/8/25.
//  Copyright © 2020 LZQ. All rights reserved.
//

#import "NSMutableArray+HKErrorHandle.h"

@implementation NSMutableArray (HKErrorHandle)

/**
 *  数组中插入数据
 */
- (void)insertObjectVerify:(id)object atIndex:(NSInteger)index{
    if (index < self.count && object) {
        [self insertObject:object atIndex:index];
    }
}
/**
 *  数组中添加数据
 */
- (void)addObjectVerify:(id)object{
    if (object) {
        [self addObject:object];
    }
}

@end
