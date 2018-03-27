//
//  CustomTabBar.h
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTabBar;

@protocol TabBarDelegate <NSObject>

/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void) tabBar:(CustomTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

@interface CustomTabBar : UIView
@property(nonatomic,weak) id<TabBarDelegate> delegate;
/**
 *  使用特定图片来创建按钮, 这样做的好处就是可扩展性. 拿到别的项目里面去也能换图片直接用
 *
 *  @param image         普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 */
-(void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *) selectedImage;
//- (void)clickBtn:(UIButton *)button;
-(void)clickBtnWithIndex:(NSInteger)index;
-(id)initWithNormalIMG:(NSArray *)normal AndSelectedIMG:(NSArray *)selectedArr AndRect:(CGRect)frame;

@end
