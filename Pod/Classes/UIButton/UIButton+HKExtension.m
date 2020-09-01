//
//  UIButton+HKExtension.m
//  Takeaway
//
//  Created by hank on 2020/9/1.
//  Copyright © 2020 CJ. All rights reserved.
//

#import "UIButton+HKExtension.h"

@implementation UIButton (HKExtension)
#pragma make--标题在下
- (void)titleOnBottom:(CGFloat)spacing
{
    self.titleLabel.backgroundColor = [UIColor clearColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}
#pragma make--标题在左
-(void)titleOnLeft:(CGFloat)spacing{
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.imageView.backgroundColor = [UIColor clearColor];
    //在使用一次titleLabel和imageView后才能正确获取titleSize
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    //    CGFloat interval = 1.0;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + spacing, 0, -(titleSize.width + spacing));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + spacing), 0, imageSize.width + spacing);

}

-(void)titleOnRight:(CGFloat)spacing{
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.imageView.backgroundColor = [UIColor clearColor];
    //在使用一次titleLabel和imageView后才能正确获取titleSize
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    //    CGFloat interval = 1.0;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0,(imageSize.width - spacing ), 0, -(imageSize.width - spacing+15));
    self.imageEdgeInsets= UIEdgeInsetsMake(0, -(titleSize.width - spacing-10), 0, titleSize.width - spacing);
}

@end
