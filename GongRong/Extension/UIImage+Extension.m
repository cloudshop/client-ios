//
//  UIImage+Extension.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+(UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
}


+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 截取部分图像
- (UIImage *)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    CFRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

//裁剪图片到subImageSize，x，y是起始裁剪坐标
- (UIImage *)cropToSize:(CGSize)subImageSize offx:(CGFloat)x offy:(CGFloat)y
{
    //定义裁剪的区域相对于原图片的位置
    CGRect subImageRect = CGRectMake(x, y, subImageSize.width, subImageSize.height);
    CGImageRef imageRef = self.CGImage;
    UIImage* subImage = [UIImage imageWithCGImage:imageRef];
    
    CGRect scaleRect = CGRectMake(x*2, y*2, subImageSize.width*2, subImageSize.height*2);
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, scaleRect);
    subImage = [UIImage imageWithCGImage:subImageRef];
    
    UIGraphicsBeginImageContextWithOptions(subImageSize, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageRect, subImageRef);
    subImage = [UIImage imageWithCGImage:subImageRef scale:self.scale orientation:self.imageOrientation];
    
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    //返回裁剪的部分图像
    return subImage;
}

// 等比例缩放
- (UIImage *)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage*)cropImgToSize: (CGFloat)width height:(CGFloat)height toCropImg:(UIImage*)sImg
{
    CGFloat sw = sImg.size.width;
    CGFloat sh = sImg.size.height;
    
    CGFloat destW = 0;
    CGFloat destH = 0;
    if (sw > sh) {
        destH = height;
        destW = sw * destH / sh;
    }else{
        destW = width;
        destH = sh * destW / sw;
    }
    
    UIImage *destImg = [sImg scaleToSize:CGSizeMake(destW, destH)];
    if (destImg.size.width == width && height == destImg.size.height) {
        return destImg;
    }
    CGFloat offx = 0;
    CGFloat offy = 0;
    if (destH > destW) {
        offx = 0;
        offy = (destH - height)/2;
    }else{
        offx = (destW - width)/2;
        offy = 0;
    }
    return [destImg cropToSize:CGSizeMake(width, height) offx:offx offy:offy];
}


+ (UIImage *)TransformtoSize:(CGSize)size image:(UIImage *)image
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *transformedImg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return transformedImg;
}

- (UIImage *)imageWithMaxLength:(CGFloat)sideLenght
{
    CGSize size = [self fitSize:sideLenght];
    
    UIGraphicsBeginImageContext(size);
    
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationDefault);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
}

- (CGSize)fitSize:(CGFloat)sideLenght
{
    CGFloat scale;
    CGSize newsize;
    
    if(self.size.width <= sideLenght && self.size.height <= sideLenght)
    {
        newsize = self.size;
    }
    else
    {
        if(self.size.width >= self.size.height)
        {
            scale = sideLenght/self.size.width;
            newsize.width = sideLenght;
            newsize.height = ceilf(self.size.height*scale);
        }
        else
        {
            scale = sideLenght/self.size.height;
            newsize.height = sideLenght;
            newsize.width = ceilf(self.size.width*scale);
        }
    }
    
    return newsize;
}

@end
