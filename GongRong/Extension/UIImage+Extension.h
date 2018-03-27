//
//  UIImage+Extension.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//



@interface UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */

+(UIImage *)resizedImage:(NSString *)name;

/**
 *  根据颜色创建UIImage
 *
 *  @param color 给定的颜色
 *
 *  @return 创建的UIImage对象
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 *  根据某个view创建相应的UIImage/也就是截图
 *
 *  @param view 给定的view
 *
 *  @return 创建的UIImage对象
 */
+ (UIImage *)imageFromView:(UIView *)view;

/**
 *  截取部分图像
 *
 *  @param rect 要截取部分的frame
 *
 *  @return 截取部分的UIImage
 */
-(UIImage *) getSubImage:(CGRect)rect;

/**
 *  等比转换image的size，如果给定的size宽高比不同，则取小的进行缩放
 *
 *  @param size 给定的size
 *
 *  @return 转换后的image
 */
-(UIImage *)scaleToSize:(CGSize)size;

/**
 *  等比裁剪image的size，如果给定的size宽高比不同，则取小的进行缩放
 *
 *  @param width 给定的width
 *  @param height 给定的height
 *
 *  @return 转换后的image
 */
//裁剪图片到subImageSize，x，y是起始裁剪坐标
- (UIImage *)cropToSize:(CGSize)subImageSize offx:(CGFloat)x offy:(CGFloat)y;
- (UIImage*)cropImgToSize: (CGFloat)width height:(CGFloat)height toCropImg:(UIImage*)sImg;

/**
 *  将给定的image进行size转换，不考虑等比
 *
 *  @param size  给定的size
 *  @param image 给定的image
 *
 *  @return 转换后的image
 */
+ (UIImage *)TransformtoSize:(CGSize)size image:(UIImage *)image;

/**
 *  设置image最长的边长，进行等比缩放
 *
 *  @param sideLenght 最长的边长值
 *
 *  @return 转换后的image
 */
- (UIImage *)imageWithMaxLength:(CGFloat)sideLenght;

@end
