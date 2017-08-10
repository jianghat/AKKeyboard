//
//  UIImage+AKKit.h
//  AKKitDemo
//
//  Created by jianghat on 2017/8/7.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AKAdd)

/**
 生成图片 1x1 point.
 
 @param color  The color.
 */
+ (UIImage *)ak_imageWithColor:(UIColor *)color;

/**
 生成图片
 
 @param color 颜色
 @param size  大小
 */
+ (UIImage *)ak_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 生成文字图片
 
 @param str 内容.
 */
+ (UIImage *)ak_imageWithString:(NSString *)str font:(UIFont *)font color:(UIColor *)color inRect:(CGRect)rect;

/**
 生成二维码图片
 
 @param str  二维码内容.
 */
+ (UIImage *)ak_generateQRCodeWithString:(NSString *)str;

// 改变图片颜色
- (UIImage *)ak_imageWithTintColor:(UIColor *)tintColor;

/**
 图片加图片水印
 @param mask  水印图片
 @param rect  水印frame
 */
- (UIImage *)imageWithWaterMask:(UIImage *)mask inRect:(CGRect)rect;

/**
 图片加文字水印
 
 @param str   水印文字
 @param font  文字大小
 @param color 文字颜色
 @param rect  水印frame
 */
- (UIImage *)imageWithString:(NSString *)str font:(UIFont *)font color:(UIColor *)color inRect:(CGRect)rect;

@end
