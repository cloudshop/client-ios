//
//  UIColor+Utility.h
//  WG
//
//  Created by jie.yuan on 13-6-8.
//  Copyright (c) 2013年 Qunar.com. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
						   green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
							blue:((float)(hexValue & 0xFF))/255.0
						   alpha:alpha];
}

+ (UIColor *)colorWithARGB:(NSInteger)ARGBValue
{
	return [UIColor colorWithRed:((float)((ARGBValue & 0xFF0000) >> 16)) / 255.0
						   green:((float)((ARGBValue & 0xFF00) >> 8)) / 255.0
							blue:((float)(ARGBValue & 0xFF))/255.0
						   alpha:((float)((ARGBValue & 0xFF000000) >> 24)) / 255.0];
}

+ (UIColor *)qunarBlueColor
{
	return [UIColor colorWithHex:0x1ba9ba alpha:1.0];
}

+ (UIColor *)qunarBlueHighlightColor
{
	return [UIColor colorWithHex:0x168795 alpha:1.0];
}

+ (UIColor *)qunarRedColor
{
	return [UIColor colorWithHex:0xff4500 alpha:1.0];
}

+ (UIColor *)qunarRedHighlightColor
{
	return [UIColor colorWithHex:0xbe3300 alpha:1.0];
}

+ (UIColor *)qunarTextRedColor
{
	return [UIColor colorWithHex:0xff3300 alpha:1.0];
}

+ (UIColor *)qunarTextBlackColor
{
	return [UIColor colorWithHex:0x333333 alpha:1.0];
}

+ (UIColor *)qunarTextGrayColor
{
	return [UIColor colorWithHex:0x888888 alpha:1.0];
}

+ (UIColor *)qunarGrayColor
{
	return [UIColor colorWithHex:0xc7ced4 alpha:1.0];
}

+ (UIColor *)warningYellowColor
{
	return [UIColor colorWithHex:0xf8facd alpha:1.0];
}

@end
