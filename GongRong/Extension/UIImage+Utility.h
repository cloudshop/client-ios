//
//  UIImage+Utility.m
//  WG
//
//  Created by jie.yuan on 13-6-8.
//  Copyright (c) 2013年 Qunar.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)

+ (UIImage *)imageFromColor:(UIColor *)color;
-(UIImage *) getSubImage:(CGRect)rect;
-(UIImage *)scaleToSize:(CGSize)size;
+ (UIImage *)TransformtoSize:(CGSize)size image:(UIImage *)image;

- (UIImage *)imageWithMaxLength:(CGFloat)sideLenght;


- (UIImage *) boxBlurWithRadius:(CGFloat) radius;
- (UIImage *) applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
