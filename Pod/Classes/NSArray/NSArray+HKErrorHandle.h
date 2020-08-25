//
//  NSArray+HKErrorHandle.h
//  Takeaway
//
//  Created by hank on 2020/8/25.
//  Copyright © 2020 LZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HKErrorHandle)
- (id)objectAtIndexVerify:(NSUInteger)index;
- (id)objectAtIndexedSubscriptVerify:(NSUInteger)idx;
@end

NS_ASSUME_NONNULL_END
