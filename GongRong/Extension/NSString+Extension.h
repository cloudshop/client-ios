//
//  NSString+Extension.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  URL编码,解码
 */
- (NSString *)stringWithUrlEncode;
- (NSString *)stringWithUrlDecode;

/**
 *  根据字体计算字符串size
 */
- (CGSize)stringSizeWithFont:(UIFont *)font;
- (CGFloat)stringHeightWithFont:(UIFont *)font withWidth:(CGFloat)width;
/**
 *  根据给定的宽度和字体计算字符串的高度，与前一个方法区别是option选择的是NSStringDrawingUsesLineFragmentOrigin
 */
- (CGFloat)getStringHeightWithFont:(UIFont *)font withWidth:(CGFloat)width;

- (NSString*)concat:(NSString*)string;

//连接两个字符串为http完整地址
- (NSString*)concatPath:(NSString*)pathString;

@end
