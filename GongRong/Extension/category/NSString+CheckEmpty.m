//
//  NSString+CheckEmpty.m
//  Booking
//
//  Created by hanfei on 15/2/3.
//  Copyright (c) 2015年 Bluecreate. All rights reserved.
//

#import "NSString+CheckEmpty.h"

@implementation NSString (CheckEmpty)

//检测string是否为nil或者@""
- (BOOL)checkEmpty
{
    return ((self && ![self isEqualToString:@""]) ? NO : YES);
}
//如果为nil或@""替换成string
- (NSString *)emptyToString:(NSString *)string
{
    return ([self checkEmpty] ? string : self);
}

@end
