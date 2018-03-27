//
//  CityListCell.m
//  GongRongCredits
//
//  Created by 王旭 on 2018/3/15.
//

#import "CityListCell.h"

@implementation CityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)initSubViews
{
    self.cityNameLB=[[UILabel alloc]init];
    self.cityNameLB.font=kAppFont5;
    self.cityNameLB.textColor=kAppColor1;
    [self.contentView addSubview:self.cityNameLB];
    self.citySubLB=[[UILabel alloc]init];
    self.citySubLB.font=kAppFont6;
    self.citySubLB.textColor=kAppColor8;
    [self.contentView addSubview:self.citySubLB];
    
    self.lineView=[[UIView alloc]init];
    self.lineView.backgroundColor=kAppColorSeparate;
    [self.contentView addSubview:self.lineView];
}
-(void)setsubViewsLayout
{
    CGSize CLSS=[self.cityNameLB getLableSize];
    [self.cityNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CLSS);
        make.top.left.mas_equalTo(10);
    }];
    CGSize CSLS=[self.citySubLB getLableSize];
    [self.citySubLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CSLS);
        
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
