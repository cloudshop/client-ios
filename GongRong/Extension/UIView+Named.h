//
//  UIView+Named.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//



@interface UIView (Named)

// 设置view的name
@property (nonatomic) NSString* name;

// 根据名字找到view对象 (包括本身)
- (id)viewWithName:(NSString*)name;

@end
