//
//  UIColor+Extension.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//



@interface UIColor (Extension)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHex:(NSInteger)hexValue;

+ (UIColor *)colorWithColor:(UIColor*)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
