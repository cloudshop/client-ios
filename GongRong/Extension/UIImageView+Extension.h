//
//  UIImageView+Extension.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//



@interface UIImageView (Extension)

/**
 *  根据图片名初始化imageView
 *
 *  @param name 图片名
 *
 *  @return imageView对象
 */
- (id)initWithImageNamed:(NSString *)name;

/**
 *  根据图片名设置UIImageView
 *
 *  @param name 图片名
 */
- (void)setImageNamed:(NSString *)name;

/**
 *  使用图片名称设置UIImageView 并且使用image的size作为UIImageView的frame
 *
 *  @param name         图片名
 *  @param useImageSize 是否使用image的size作为imageView的size
 */
- (void)setImageNamed:(NSString *)name useImageSize:(BOOL)useImageSize;

- (void)useImageSize;

@end
