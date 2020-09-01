//
//  UIButton+HKExtension.h
//  Takeaway
//
//  Created by hank on 2020/9/1.
//  Copyright © 2020 CJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HKExtension)
//标题在下
- (void)titleOnBottom:(CGFloat)spacing;

//标题在左
-(void)titleOnLeft:(CGFloat)spacing;

//标题在右
-(void)titleOnRight:(CGFloat)spacing;
@end

NS_ASSUME_NONNULL_END
