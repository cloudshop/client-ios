//
//  CustomTabBar.m
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import "CustomTabBar.h"
#import "CustomTabBarBT.h"

@interface CustomTabBar ()
/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) CustomTabBarBT *selectedBtn;


@end


@implementation CustomTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithNormalIMG:(NSArray *)normal AndSelectedIMG:(NSArray *)selectedArr AndRect:(CGRect)frame AndtitleArr:(NSArray *)titleArr
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initBTInfo:normal AndSelectedIMG:selectedArr AndtitleArr:titleArr];
    }
    return self;
}
-(void)initBTInfo:(NSArray *)normal AndSelectedIMG:(NSArray *)selectedArr AndtitleArr:(NSArray *)titleArr
{
    for (int i=0; i<normal.count; i++) {
        
        
        NSString *imageName = [normal objectAtIndex:i];
        NSString *imageNameSel = [selectedArr objectAtIndex:i];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        CustomTabBarBT *btn = [[CustomTabBarBT alloc]initWithNormalImg:image AndSelectedIMG:imageSel AndTitle:titleArr[i]];
        
        btn.tag =100+ i; //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        [self addSubview:btn];
        
        //带参数的监听方法记得加"冒号"
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat x = i * self.bounds.size.width /normal.count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / normal.count;
        CGFloat height = self.bounds.size.height;
        btn.frame = CGRectMake(x, y, width, height);
        
        //如果是第一个按钮, 则选中(按顺序一个个添加)
        if (self.subviews.count == 1) {
            [self clickBtn:btn];
        }
        
        CustomTabBarBT *BT2=[self viewWithTag:101];
         CustomTabBarBT *BT3=[self viewWithTag:102];
        BT2.iconLeftOffset=20;
        BT3.iconLeftOffset=-20;
    
        // button图片的偏移量  //顺序是上左下右
//        BT2.imageEdgeInsets = UIEdgeInsetsMake(0, -BT2.intrinsicContentSize.width, 0, 0);
//        BT3.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,BT3.intrinsicContentSize.width);
    }
}
- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage {
//    CustomTabBarBT *btn = [[CustomTabBarBT alloc]initWithNormalImg:image AndSelectedIMG:selectedImage andTitle:];
//    
//    [self addSubview:btn];
//    
//    //带参数的监听方法记得加"冒号"
//    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    //如果是第一个按钮, 则选中(按顺序一个个添加)
//    if (self.subviews.count == 1) {
//        [self clickBtn:btn];
//    }
}

/**专门用来布局子视图, 别忘了调用super方法*/
/*
 - (void)layoutSubviews {
 [super layoutSubviews];
 int count = self.subviews.count;
 for (int i = 0; i < count; i++) {
 //取得按钮
 CustomTabBarBT *btn = self.subviews[i];
 
 btn.tag =100+ i; //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
 
 CGFloat x = i * self.bounds.size.width / count;
 CGFloat y = 0;
 CGFloat width = self.bounds.size.width / count;
 CGFloat height = self.bounds.size.height;
 btn.frame = CGRectMake(x, y, width, height);
 
 }
 
 }
 */
-(void)clickBtnWithIndex:(NSInteger)index
{
    CustomTabBarBT *BT=[self viewWithTag:100+index];
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    BT.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    
    
    //却换视图控制器的事情,应该交给controller来做
    //最好这样写, 先判断该代理方法是否实现
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag-100 to:BT.tag-100];
    }
    self.selectedBtn = BT;
    
}

- (void)clickBtn:(CustomTabBarBT *)button {
    CustomTabBarBT *bT=(CustomTabBarBT*)button;
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    bT.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    
    
    //却换视图控制器的事情,应该交给controller来做
    //最好这样写, 先判断该代理方法是否实现
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag-100 to:button.tag-100];
    }
    self.selectedBtn = bT;
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    //self.selectedIndex = button.tag;
}

@end
