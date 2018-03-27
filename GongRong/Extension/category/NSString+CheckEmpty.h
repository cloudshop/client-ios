//
//  NSString+CheckEmpty.h
//  Booking
//
//  Created by hanfei on 15/2/3.
//  Copyright (c) 2015年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

#define String_ZanWu        @"暂无"

@interface NSString (CheckEmpty)

//检测string是否为nil或者@""
- (BOOL)checkEmpty;

//如果为nil或@""替换成string
- (NSString *)emptyToString:(NSString *)string;

@end
