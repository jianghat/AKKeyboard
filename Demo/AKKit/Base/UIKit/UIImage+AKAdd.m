//
//  UIImage+AKKit.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/7.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "UIImage+AKAdd.h"
#import "AKKitMacro.h"

@implementation UIImage (AKAdd)

+ (UIImage *)ak_imageWithColor:(UIColor *)color {
  return [self ak_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)ak_imageWithColor:(UIColor *)color size:(CGSize)size {
  NSParameterAssert(color);
  
  CGRect rect = CGRectMake(0, 0, size.width, size.height);
  
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
  [color setFill];
  UIRectFill(rect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)ak_imageWithString:(NSString *)str font:(UIFont *)font color:(UIColor *)color inRect:(CGRect)rect {
  NSDictionary *attributes = @{
                               NSFontAttributeName: font,
                               NSForegroundColorAttributeName: color
                               };
  [str drawInRect:rect withAttributes:attributes];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

+ (UIImage *)ak_generateQRCodeWithString:(NSString *)str {
  NSParameterAssert(str);
  
  CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
  [filter setDefaults];
  
  NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
  [filter setValue:data forKey:@"inputMessage"];
  
  CIImage *outputImage = [filter outputImage];
  
  CIContext *context = [CIContext contextWithOptions:nil];
  CGImageRef cgImage = [context createCGImage:outputImage
                                     fromRect:[outputImage extent]];
  
  UIImage *image = [UIImage imageWithCGImage:cgImage
                                       scale:1.
                                 orientation:UIImageOrientationUp];
  CGImageRelease(cgImage);
  
  
  CGFloat rate = kScreenWidth / MAX(image.size.width, image.size.height);
  CGFloat width = image.size.width * rate;
  CGFloat height = image.size.height * rate;
  
  UIGraphicsBeginImageContext(CGSizeMake(width, height));
  CGContextRef cgContext = UIGraphicsGetCurrentContext();
  CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
  [image drawInRect:CGRectMake(0, 0, width, height)];
  UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return resized;
}

- (UIImage *)ak_imageWithTintColor:(UIColor *)tintColor {
  UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
  [tintColor setFill];
  CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
  UIRectFill(bounds);
  [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.f];
  UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

- (UIImage *)imageWithWaterMask:(UIImage *)mask inRect:(CGRect)rect {
  UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
  //原图
  [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
  //水印图
  [mask drawInRect:rect];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

- (UIImage *)imageWithString:(NSString *)str font:(UIFont *)font color:(UIColor *)color inRect:(CGRect)rect {
  UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
  [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
  NSDictionary *attributes = @{
                               NSFontAttributeName: font,
                               NSForegroundColorAttributeName: color
                               };
  [str drawInRect:rect withAttributes:attributes];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

@end
