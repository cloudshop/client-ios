//
//  UIFont+Extension.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//



@interface UIFont (Extension)

/**
 *  获取系统默认字体的字号为size的UIFont对象
 */
+ (UIFont *)appNormalFont:(CGFloat)size;

/**
 *  获取系统默认加粗字体的字号为size的UIFont对象
 */
+ (UIFont *)appBoldFont:(CGFloat)size;


@end
