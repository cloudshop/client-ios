//
//  CustomTabBarBT.m
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import "CustomTabBarBT.h"

@implementation CustomTabBarBT

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithNormalImg:(UIImage *)normalIMG AndSelectedIMG:(UIImage *)selectIMG
{
    self=[super init];
    if (self ) {
        self.image = normalIMG;
        self.selectedImage = selectIMG;
        
        self.imgIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.imgIcon];
        self.imgIcon.contentMode = UIViewContentModeScaleAspectFit;
        self.imgIcon.image = normalIMG;
        [self.imgIcon sizeToFit];
        [self initView];
        
    }
    return self;
}
/*
- (void)touchDown
{
    self.imgIcon.image = self.selectedImage;
    //    self.labelTitle.textColor = [UIColor lightGrayColor];
}

- (void)touchUp
{
    self.imgIcon.image = self.image;
    //    self.labelTitle.textColor = [UIColor whiteColor];
}
*/
-(void)initView
{
    self.messageCountLB=[[UILabel alloc]init];
    self.messageCountLB.backgroundColor=[UIColor redColor];
    self.messageCountLB.textColor=[UIColor whiteColor];
    self.messageCountLB.font=[UIFont systemFontOfSize:12];
    self.messageCountLB.textAlignment=NSTextAlignmentCenter;
    self.messageCountLB.layer.cornerRadius=10;
    self.messageCountLB.clipsToBounds=YES;
    self.messageCountLB.userInteractionEnabled=YES;
    self.messageCountLB.hidden=YES;
    [self addSubview:self.messageCountLB];
    
}
-(void)layoutSubviews
{
    if (!self.selected) {
        self.imgIcon.image=self.image;
    }
    else
    {
        self.imgIcon.image=self.selectedImage;
    }
    self.imgIcon.center=CGPointMake(self.width/2, self.height/2);
    if(self.iconLeftOffset!=0)
    {
        self.imgIcon.left-=self.iconLeftOffset;
    }
    self.imgIcon.height=self.height-19;
    self.imgIcon.top=10;
    self.messageCountLB.bottom=self.imgIcon.top+10;
    self.messageCountLB.left=self.imgIcon.right-10;
    
}
/**什么也不做就可以取消系统按钮的高亮状态*/
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
}

@end
