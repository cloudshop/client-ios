//
//  UILabel+getSize.m
//  盛意华通
//
//  Created by 王旭 on 2018/1/19.
//  Copyright © 2018年 bwx. All rights reserved.
//

#import "UILabel+getSize.h"

@implementation UILabel (getSize)

-(CGSize)getLableSize
{
    CGSize size=[self.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName ,nil]];
    size.width+=1;  //计算出的值多为 XX.32190 这种类似的小数  如果直接使用的话 可能会出现宽度被截去的情况  为防止这种  统一加一个点
    return size;
}
@end
