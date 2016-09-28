//
//  UIImage+Extension.h
//  HomeLock
//
//  Created by chensen on 16/8/8.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

// 剪切出图片
+ (UIImage *)cropImageWithName:(NSString *)imageName inRect:(CGRect)rect;
// 调整图片大小
+ (UIImage *)resizableImageWithName:(NSString *)imageName;
// 实现图片的放大缩小
- (UIImage *)scaleImageWithSize:(CGSize)size;
// 颜色变成Image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
