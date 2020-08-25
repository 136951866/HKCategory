//
//  NSArray+HKErrorHandle.m
//  Takeaway
//
//  Created by hank on 2020/8/25.
//  Copyright © 2020 LZQ. All rights reserved.
//

#import "NSArray+HKErrorHandle.h"

@implementation NSArray (HKErrorHandle)
/**
 *  防止数组越界
 */
- (id)objectAtIndexVerify:(NSUInteger)index{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}
/**
 *  防止数组越界
 */
- (id)objectAtIndexedSubscriptVerify:(NSUInteger)idx{
    if (idx < self.count) {
        return [self objectAtIndexedSubscript:idx];
    }else{
        return nil;
    }
}

@end
