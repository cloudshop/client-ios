//
//  CustomTabBarBT.h
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarBT : UIButton

@property (nonatomic, strong) UIImageView* imgIcon;


@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) UIImage* selectedImage;

@property (nonatomic,strong)UILabel *messageCountLB;
@property (nonatomic,strong)UILabel *titleLB;

@property (nonatomic,assign)float iconLeftOffset;//图标的左偏移量  正数左移  负数右移

-(instancetype)initWithNormalImg:(UIImage *)normalIMG AndSelectedIMG:(UIImage *)selectIMG AndTitle:(NSString *)titleStr;
@end
