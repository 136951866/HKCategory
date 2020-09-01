//
//  UIImage+HKQRCode.m
//  Takeaway
//
//  Created by hank on 2020/9/1.
//  Copyright © 2020 CJ. All rights reserved.
//

#import "UIImage+HKQRCode.h"

@implementation UIImage (HKQRCode)
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage*)codeImageWithString:(NSString*) string{
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    
    return [UIImage createNonInterpolatedUIImageFormCIImage:image withSize:140];
    
}

// 添加logo
+ (UIImage *)drawLogoImage:(UIImage *)logoImage sourceImage:(UIImage *)sourceImage {
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //画 自己想要画的内容(添加的图片)
    CGContextDrawPath(context, kCGPathStroke);
    // 注意logo的尺寸不要太大,否则可能无法识别
    CGRect rect = CGRectMake(imageSize.width / 2 - 15, imageSize.height / 2 - 15, 30, 30);
    //    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [logoImage drawInRect:rect];
    
    //返回绘制的新图形
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
