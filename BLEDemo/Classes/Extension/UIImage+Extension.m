//
//  UIImage+Extension.m
//  HomeLock
//
//  Created by chensen on 16/8/8.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

// 图片剪切
+ (UIImage *)cropImageWithName:(NSString *)imageName inRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

/*
 在设置一个较小图片作为一个较大的控件的背景时，图片会发生较大的拉伸导致变形。
 因此，想要图片显示正常，需要把图片的局部像素进行拉伸填充。
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName
{
    // 加载原有图片
    UIImage *image = [UIImage imageNamed:imageName];
    // 获取原有图片的宽高一半
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    return newImage;
}

/**
 *  实现图片的缩小或者放大
 *
 *  @param image 原图
 *  @param size  大小范围
 *
 *  @return 新的图片
 */
- (UIImage *)scaleImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);    // Size为CGSize类型，即你所需要的图片尺寸
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;   // 返回的就是已经改变后的图片
}

/**
 *  颜色变成图片
 *
 *  @param color 颜色
 *  @param size  大小范围
 *
 *  @return 新的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // 绘图（相当于H5中的canvas）
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
