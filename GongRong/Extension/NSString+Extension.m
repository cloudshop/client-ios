//
//  NSString+Extension.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

// URL编码
- (NSString *)stringWithUrlEncode
{
    CFStringRef originalStringRef = CFBridgingRetain([self mutableCopy]);
    CFStringRef strRef = CFURLCreateStringByAddingPercentEscapes(NULL, originalStringRef, NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return CFBridgingRelease(strRef);
}

// URL解码
- (NSString *)stringWithUrlDecode
{
    NSString *result = [[self mutableCopy] stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (CGSize)stringSizeWithFont:(UIFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,nil];
    CGSize labelSize = [self sizeWithAttributes:attributes];
    return labelSize;
}

- (CGFloat)stringHeightWithFont:(UIFont *)font withWidth:(CGFloat)width
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect labelRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return labelRect.size.height;
}

- (CGFloat)getStringHeightWithFont:(UIFont *)font withWidth:(CGFloat)width
{
    NSDictionary *dictionaryAttributes = @{NSFontAttributeName:font};
    CGRect stringRect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:dictionaryAttributes
                                           context:nil];
    
    CGFloat widthResult = stringRect.size.width;
    if(widthResult - width >= 0.0000001)
    {
        widthResult = width;
    }
    stringRect.size.width = widthResult;
    
    return stringRect.size.height;
}

- (NSString*)concat:(NSString*)string
{
    if (string.length <= 0) {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@%@", self, string];
}

- (NSString*)concatPath:(NSString*)pathString
{
    if ([pathString hasPrefix:@"http"]) {
        return pathString;
    }
    
    if ([self hasSuffix:@"/"] && [pathString hasPrefix:@"/"]) {
        pathString = [pathString substringFromIndex:1];
        return [self concat:pathString];
    } else if (![self hasSuffix:@"/"] && ![pathString hasPrefix:@"/"]) {
        return [NSString stringWithFormat:@"%@/%@", self, pathString];
    }
    
    return [self concat:pathString];
}

@end
