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
    
    return size;
}
@end
