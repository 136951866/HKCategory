//
//  UIImage+HKQRCode.h
//  Takeaway
//
//  Created by hank on 2020/9/1.
//  Copyright © 2020 CJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HKQRCode)
/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

+ (UIImage*)codeImageWithString:(NSString*) string;

// 添加logo
+ (UIImage *)drawLogoImage:(UIImage *)logoImage sourceImage:(UIImage *)sourceImage;
@end

NS_ASSUME_NONNULL_END
