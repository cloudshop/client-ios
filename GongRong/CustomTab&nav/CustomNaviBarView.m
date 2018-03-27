//
//  CustomNaviBarView.m
//  Booking
//
//  Created by wihan on 14-10-20.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import "CustomNaviBarView.h"
#import "UtilityFunc.h"
//#import "Common.h"

@interface CustomNaviBarView ()

@end

@implementation CustomNaviBarView

@synthesize m_btnBack = _btnBack;
@synthesize m_leftImgView = _leftImgView;
@synthesize m_labelTitle = _labelTitle;
@synthesize m_subLabelTitle = _subLabelTitle;
@synthesize m_imgViewBg = _imgViewBg;
@synthesize m_btnLeft = _btnLeft;
@synthesize m_btnRight = _btnRight;
@synthesize m_btnRightSub = _btnRightSub;
@synthesize m_btnMidSub = _btnMidSub;
@synthesize m_searchBar = _searchBar;
@synthesize m_bIsBlur = _bIsBlur;
@synthesize m_segmentedBar = _segmentedBar;
@synthesize m_searchBarNewFrame = _searchBarNewFrame;
@synthesize m_searchFromType = _searchFromType;
@synthesize m_bottomLineImageView=_bottomLineImageView;
#pragma mark - Public Functions
#pragma mark - Public Functions For Factory Functions
+ (CGRect)backBtnFrame
{
    return Rect(FLOAT_BackBtnX, StatusBarHeight + (NaviBarHeight - FLOAT_BackBtnWidth)/2, FLOAT_BackBtnWidth, FLOAT_BackBtnWidth);//NaviBarHeight
}

+ (CGRect)rightBtnFrame
{
    return Rect(FLOAT_RightBtnX, StatusBarHeight + (NaviBarHeight - FLOAT_NormalBtnHeight)/2, FLOAT_NormalBtnWidth, FLOAT_NormalBtnHeight);
}

+ (CGRect)rightSubBtnFrame
{
    return Rect(FLOAT_RightSubBtnX, StatusBarHeight, FLOAT_RightBtnWidth, NaviBarHeight);
}

+ (CGRect)leftBtnFrame
{
    return Rect(FLOAT_BackBtnX, StatusBarHeight + (NaviBarHeight - FLOAT_BackBtnWidth)/2, FLOAT_BackBtnWidth, FLOAT_BackBtnWidth);//NaviBarHeight
//    return Rect(0, StatusBarHeight+(NaviBarHeight-FLOAT_NormalBtnHeight)/2, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
}

+ (CGSize)barBtnSize
{
    return Size(FLOAT_BtnNormalWidth, NaviBarHeight);
}

+ (CGSize)smallBarBtnSize
{
    return Size(FLOAT_BtnSmallWidth, NaviBarHeight);
}

+ (CGSize)barSize
{
    return Size(ScreenWidth, NaviBarHeight + StatusBarHeight);
}

+ (CGRect)titleViewFrame
{
    return Rect(FLOAT_BtnNormalWidth, StatusBarHeight+5, FLOAT_TitleLabelWidth, FLOAT_TitleLabelHeight);
}

+ (CGRect)subTitleViewFrame
{
    return Rect(FLOAT_BtnNormalWidth, NaviBarHeight, ScreenWidth-FLOAT_BtnNormalWidth, FLOAT_TitleLabelHeight);
}

+ (CGRect)leftImgViewFrame
{
    return Rect(FLOAT_LeftImgX, FLOAT_LeftImgY, FLOAT_LeftImgWidth, FLOAT_LeftImgHeight);
}

/**
 *  首页searchbar
 */
+ (CGRect)searchBarFrame
{
    return Rect(FLOAT_SearchBarX + 2, StatusBarHeight+7, FLOAT_SearchBarWidth-20, NaviBarHeight-14);
}

+ (CGRect)segmentedBarFrame
{
    return Rect(FLOAT_SegmentX, FLOAT_SegmentY, FLOAT_SegmentBarWidth, FLOAT_SegmentBarHeight);
}

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action
{
    UIButton *btn = [[self class] createImgNaviBarBtnByImgNormal:@"NaviBtn_Normal" imgHighlight:@"NaviBtn_Normal_H" target:target action:action];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:RGB_TextDark forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [UtilityFunc label:btn.titleLabel setMiniFontSize:8.0f forNumberOfLines:1];
    
    return btn;
}

// 创建一个导航条按钮：自定义按钮图片
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight target:(id)target action:(SEL)action
{
    return [[self class] createImgNaviBarBtnByImgNormal:strImg imgHighlight:strImgHighlight imgSelected:strImg target:target action:action];
}

+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight imgSelected:(NSString *)strImgSelected target:(id)target action:(SEL)action
{
    UIImage *imgNormal = [UIImage imageNamed:strImg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:imgNormal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:(strImgSelected ? strImgSelected : strImg)] forState:UIControlStateSelected];
    
    CGFloat fDeltaWidth = ([[self class] barBtnSize].width - imgNormal.size.width)/2.0f;
    CGFloat fDeltaHeight = ([[self class] barBtnSize].height - imgNormal.size.height)/2.0f;
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, fDeltaWidth, fDeltaHeight, fDeltaWidth)];
    
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, -imgNormal.size.width, fDeltaHeight, fDeltaWidth)];
    
    return btn;
}

#pragma mark - Public Functions For Set Functions
- (void)setTitle:(NSString *)strTitle
{
    [_labelTitle setText:strTitle];
}

- (void)setSubTitle:(NSString *)strTitle
{
    [_subLabelTitle setText:strTitle];
}

- (void)setLeftBtn:(UIButton *)btn
{
    if (_btnLeft)
    {
        [_btnLeft removeFromSuperview];
        _btnLeft = nil;
    }else{}
    
    _btnLeft = btn;
    if (_btnLeft)
    {
        _btnLeft.frame = [[self class] leftBtnFrame];
        [self addSubview:_btnLeft];
    }else{}
}

- (void)setRightBtn:(UIButton *)btn
{
    if (_btnRight)
    {
        [_btnRight removeFromSuperview];
        _btnRight = nil;
    }else{}
    
    _btnRight = btn;
    if (_btnRight)
    {
        _btnRight.frame = [[self class] rightBtnFrame];
        [self addSubview:_btnRight];
    }else{}
}

- (void)setRightSubBtn:(UIButton *)btn
{
    if (_btnRightSub)
    {
        [_btnRightSub removeFromSuperview];
        _btnRightSub = nil;
    }else{}
    
    _btnRightSub = btn;
    if (_btnRightSub)
    {
        _btnRightSub.frame = [[self class] rightSubBtnFrame];
        [self addSubview:_btnRightSub];
    }else{}
}

- (void)setMidBtn:(UIButton *)btn
{
    if (_btnMidSub)
    {
        [_btnMidSub removeFromSuperview];
        _btnMidSub = nil;
    }else{}
    
    _btnMidSub = btn;
    if (_btnMidSub)
    {
        _btnMidSub.frame = [[self class] rightBtnFrame];
        [self addSubview:_btnMidSub];
    }else{}
}

- (void)setLeftBtnDetail:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight text:(NSString *)text target:(id)target action:(SEL)action
{
    [_btnLeft setTitle:text forState:UIControlStateNormal];
    UIImage *imgNormal = [UIImage imageNamed:strImg];
    [_btnLeft setImage:imgNormal forState:UIControlStateNormal];
    [_btnLeft setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateHighlighted];
    [_btnLeft setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateSelected];
    
    [_btnLeft addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setMidBtnDetail:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight text:(NSString *)text target:(id)target action:(SEL)action
{
    [_btnMidSub setTitle:text forState:UIControlStateNormal];
    UIImage *imgNormal = [UIImage imageNamed:strImg];
    [_btnMidSub setImage:imgNormal forState:UIControlStateNormal];
    [_btnMidSub setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateHighlighted];
    [_btnMidSub setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateSelected];
    
    [_btnMidSub addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setRightBtnDetail:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight text:(NSString *)text target:(id)target action:(SEL)action
{
    [_btnRight setTitle:text forState:UIControlStateNormal];
    UIImage *imgNormal = [UIImage imageNamed:strImg];
    [_btnRight setImage:imgNormal forState:UIControlStateNormal];
    [_btnRight setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateHighlighted];
    [_btnRight setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateSelected];
    
    [_btnRight addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setRightSubBtnDetail:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight text:(NSString *)text target:(id)target action:(SEL)action
{
    [_btnRightSub setTitle:text forState:UIControlStateNormal];
    UIImage *imgNormal = [UIImage imageNamed:strImg];
    [_btnRightSub setImage:imgNormal forState:UIControlStateNormal];
    [_btnRightSub setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateHighlighted];
    [_btnRightSub setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateSelected];
    
    [_btnRightSub addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNavBarMode:(NSInteger)type
{
    switch (type) {
        case NavBarTypeTitleOnly:
            [self setNavBarTypeTitleOnlyMode];
            break;
            
        case NavBarTypeLeftTitle:
            [self setNavBarTypeLeftTitleMode];
            break;
            
        case NavBarTypeLeftTitleRight:
            [self setNavBarTypeLeftTitleRightMode];
            break;
            
        case NavBarTypeLeftImgSearchRight:
            [self setNavBarTypeLeftImgSearchRightMode];
            break;
            
        case NavBarTypeLeftSearch:
            [self setNavBarTypeLeftSearchMode];
            break;
            
        case NavBarTypeLeftTwoTitle:
            [self setNavBarTypeLeftTwoTitleMode];
            break;
            
        case NavBarTypeSegmentLeft:
            [self setNavBarTypeSegmentLeftMode];
            break;
            
        case NavBarTypeSegmentRight:
            [self setNavBarTypeSegmentRightMode];
            break;
            
        case NavBarTypeLeftTitleRightAndClear:
            [self setNavBarTypeLeftTitleRightAndClearMode];
            break;
        case NavBarTypeRightTitle:
            [self setNavBarTypeRightTitleMode];
            break;
        case NavBarTypeThreeBtn:
            [self setNavBarTypeThreeBtnMode];
            break;
        case NavBarTypeLeftBackRightSearch:
            [self setNavBarTypeLeftBackRightSearchMode];
            break;
        case NavBarTypeRightButton:
            [self setNavBarTypeRightButtonMode];
            break;
        case NavBarTypeLeftTitleSearchRight:
            [self setNavBarTypeLeftTitleSearchRightMode];
        default:
            break;
    }
}
//设置渐变色
-(void)setGradientClolr:(UIColor *)color
{
    if (!color) {
        return;
    }
    CGFloat R, G, B;
    CGColorRef cgcolor = [color CGColor];
    int numComponents = CGColorGetNumberOfComponents(cgcolor);
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(cgcolor);
        R = components[0];
        G = components[1];
        B = components[2];
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:R green:G blue:B alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:R/2 green:G/2 blue:B/2 alpha:1.0].CGColor,
                       (id)[UIColor whiteColor].CGColor, nil];
    [self.layer addSublayer:gradient];
    
    
}
#pragma mark 搜索框开始输入内容
- (void)setSearchBarToFullView
{
    _searchFromType = WGSearchFromSearchMainType;
    [UIView animateWithDuration:0.2f animations:^()
     {
         [_searchBar setFrame:Rect(0, StatusBarHeight, ScreenWidth, NaviBarHeight)];
     }completion:^(BOOL f){}];
}
- (void)setSearchBarToShowMenuBTView
{
    _searchFromType = WGSearchFromSearchMainType;
    [UIView animateWithDuration:0.2f animations:^()
     {
         [_searchBar setFrame:Rect(50, StatusBarHeight, ScreenWidth, NaviBarHeight)];
     }completion:^(BOOL f){}];
}

- (void)setSearchBarToFullViewForRecommend
{
    _searchFromType = WGSearchFromRecommendMainType;
    _searchBar.hidden = NO;
    _segmentedBar.hidden = YES;
    [_searchBar setShowsCancelButton:YES animated:YES];
    [_searchBar becomeFirstResponder];
    [UIView animateWithDuration:0.2f animations:^()
     {
         [_searchBar setFrame:Rect(0, StatusBarHeight, ScreenWidth, NaviBarHeight)];
     }completion:^(BOOL f){}];
}
#pragma mark 搜索框点击取消按钮 变成正常
- (void)setSearchBarToNormalView
{
    [UIView animateWithDuration:0.2f animations:^()
     {
         _searchBar.frame = _searchBarNewFrame;
     }completion:^(BOOL f){}];
}

- (void)setSearchBarToNormalViewForRecommend
{
    [UIView animateWithDuration:0.2f animations:^()
     {
         _searchBar.frame = _searchBarNewFrame;
         _searchBar.hidden = YES;
         _segmentedBar.hidden = YES;
     }completion:^(BOOL f){}];
}
- (void)setSearchBarToFullViewForAssign
{
    _searchFromType = WGSearchFromAssignShopMainType;
    _searchBar.hidden = NO;
    _segmentedBar.hidden = YES;
    [_searchBar setShowsCancelButton:YES animated:YES];
    [_searchBar becomeFirstResponder];
    [UIView animateWithDuration:0.2f animations:^()
     {
         [_searchBar setFrame:Rect(0, StatusBarHeight, ScreenWidth, NaviBarHeight)];
     }completion:^(BOOL f){}];
}
-(void)setSearchBarToNormalViewForAssignShop
{
    [UIView animateWithDuration:0.2f animations:^()
     {
         _searchBar.frame = _searchBarNewFrame;
         _searchBar.hidden = YES;
         _segmentedBar.hidden = YES;
     }completion:^(BOOL f){}];
}
#pragma mark 搜索框开始输入内容
- (void)setSearchBarForCustom
{
    _searchBar.backgroundColor = kAppColor8;
    for(id cc in [_searchBar subviews])
    {
        for (UIView *view in [cc subviews])
        {
            // 在这打个断点试试看
            // 遍历出来的是UINavigationButton。不知道是不是类，反正我跟不出来所以把他转成字符串再比较
            if ([NSStringFromClass(view.class)                 isEqualToString:@"UINavigationButton"])
            {
                UIButton *btn = (UIButton *)view;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                btn.titleLabel.textColor = kAppColor1;
            }
            
            if ([NSStringFromClass(view.class)                 isEqualToString:@"UISearchBarTextField"])
            {
                UITextField *text = (UITextField *)view;
                text.borderStyle = UITextBorderStyleNone;
                view.opaque = YES;
                view.backgroundColor = kAppColor8;
                view.layer.cornerRadius = 14;
            }
            
        }
    }
}

- (void)resetLeftBtnFrame:(NSString *)str
{
    CGSize btnLeftLabelTextSize = [str sizeWithFont:[UIFont systemFontOfSize:FLOAT_TitleSizeMid]
                                     constrainedToSize:CGSizeMake(MAXFLOAT, _btnLeft.frame.size.height)
                                         lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat offset = btnLeftLabelTextSize.width - _btnLeft.frame.size.width;
    if(offset > 0)
    {
        [_btnLeft setFrame:Rect(_btnLeft.frame.origin.x, _btnLeft.frame.origin.y, btnLeftLabelTextSize.width, _btnLeft.frame.size.height)];
        [_leftImgView setFrame:Rect(_leftImgView.frame.origin.x+offset+FLOAT_LeftBtnOffset, _leftImgView.frame.origin.y, _leftImgView.frame.size.width, _leftImgView.frame.size.height)];
        [_searchBar setFrame:Rect(_searchBar.frame.origin.x+offset+FLOAT_LeftBtnOffset, _searchBar.frame.origin.y, _searchBar.frame.size.width-offset-FLOAT_LeftBtnOffset, _searchBar.frame.size.height)];
    }
    _searchBarNewFrame = _searchBar.frame;
}

- (void)resetFrameForMain:(NSString *)str
{
    CGSize btnLeftLabelTextSize = [str sizeWithFont:[UIFont systemFontOfSize:FLOAT_TitleSizeNormal]
                                  constrainedToSize:CGSizeMake(MAXFLOAT, _btnMidSub.frame.size.height)
                                      lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat offset = btnLeftLabelTextSize.width - _btnMidSub.frame.size.width;
    if(offset > 0)
    {
        [_btnMidSub setFrame:Rect((ScreenWidth-btnLeftLabelTextSize.width)/2, _btnMidSub.frame.origin.y, btnLeftLabelTextSize.width, _btnMidSub.frame.size.height)];
        [_leftImgView setFrame:Rect(_btnMidSub.frame.origin.x+_btnMidSub.frame.size.width+FLOAT_LeftBtnOffset, _leftImgView.frame.origin.y, _leftImgView.frame.size.width, _leftImgView.frame.size.height)];
    }
}

#pragma mark - Private Functions
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _bIsBlur = (IsiOS7Later && Is4Inch);
        
        [self initUI];
    }
   // self.backgroundColor = RGB(101, 94, 230);
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initUI];
}
-(void)setLogInMode{
    
        self.backgroundColor =kAppMainColor;
    
         [_btnBack setImage:[UIImage imageNamed:@"back_new"]forState:UIControlStateNormal];
        _labelTitle.textColor =kAppColor8;
        [_btnLeft setTitleColor:kAppColor8 forState:UIControlStateNormal];
        [_btnRight setTitleColor:kAppColor8 forState:UIControlStateNormal];
    
}
- (void)initUI
{
    _backHandleByBar = TRUE;
    self.backgroundColor =kAppMainColor;//UIColorWithHex(0xe45252);//[UIColor whiteColor]; //RGB(101, 94, 230);
    //RGB(29, 39, 57);
    // 默认左侧显示返回按钮
//    _btnBack = [[self class] createImgNaviBarBtnByImgNormal:@"back_new" imgHighlight:@"back_new" target:self action:@selector(btnBack:)];
    
    _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnBack setImage:[UIImage imageNamed:@"back_black"]forState:UIControlStateNormal];
    [_btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _btnBack.autoresizingMask = UIViewAutoresizingNone;
    
    
    // 默认左侧显示返回按钮
    _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnLeft.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_btnLeft.titleLabel setFont:[UIFont boldSystemFontOfSize:FLOAT_TitleSizeMid]];
    [_btnLeft setTitleColor:kAppColor5 forState:UIControlStateNormal];
    _btnLeft.autoresizingMask = UIViewAutoresizingNone;
    
    // 默认右侧按钮
    _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRight.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_btnRight.titleLabel setFont:[UIFont boldSystemFontOfSize:FLOAT_TitleSizeMid]];
    [_btnRight setTitleColor:kAppColor5 forState:UIControlStateNormal];
    _btnRight.autoresizingMask = UIViewAutoresizingNone;
    
    // 默认右侧子按钮
    _btnRightSub = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRightSub.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_btnRightSub.titleLabel setFont:[UIFont boldSystemFontOfSize:FLOAT_TitleSizeMid]];
    [_btnRightSub setTitleColor:kAppColor5 forState:UIControlStateNormal];
    _btnRightSub.autoresizingMask = UIViewAutoresizingNone;
    
    // 默认中间按钮
    _btnMidSub = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnMidSub.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_btnMidSub.titleLabel setFont:[UIFont boldSystemFontOfSize:FLOAT_TitleSizeNormal]];
    [_btnMidSub setTitleColor:kAppColor5 forState:UIControlStateNormal];
    _btnMidSub.autoresizingMask = UIViewAutoresizingNone;
    
    // 下拉剪头image
    _leftImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _leftImgView.image = [UIImage imageNamed:@"map_up"];// title_icon_arrow_down
    
    // 主标题
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelTitle.backgroundColor = [UIColor clearColor];
    _labelTitle.textColor =kAppColor5; //RGB(74, 74, 74);
   //加粗  _labelTitle.font = [UIFont boldSystemFontOfSize:FLOAT_TitleSizeNormal];
    _labelTitle.font = [UIFont systemFontOfSize:FLOAT_TitleSizeNormal];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    
    // 副标题
    _subLabelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    _subLabelTitle.backgroundColor = [UIColor clearColor];
    _subLabelTitle.textColor = kAppColor6;
    _subLabelTitle.font = [UIFont boldSystemFontOfSize:FLOAT_TitleSizeMini];
    _subLabelTitle.textAlignment = NSTextAlignmentLeft;
    
    // 背景图
    _imgViewBg = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgViewBg.image = [[UIImage imageNamed:@"NaviBar_Bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _imgViewBg.alpha = 0.98f;
    
    _bottomLineImageView = [[UIImageView alloc] initWithFrame:Rect(0, self.frame.size.height-1.0f, ScreenWidth, 1.0f)];
    _bottomLineImageView.backgroundColor = RGB(232, 232, 232);
    
    
    // 搜索框
   // _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(180, 30, ScreenWidth, 30)];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:[[self class]searchBarFrame]];
    //_searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.layer.cornerRadius = 15;
    _searchBar.clipsToBounds = YES;
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    searchField.backgroundColor=kAppColor8;
    searchField.font=[UIFont systemFontOfSize:13];
    
    searchField.textAlignment=NSTextAlignmentCenter;
    _searchBar.placeholder = @"请输入要搜索的关键字";
    _searchBar.showsCancelButton = NO;
    
   // _searchBar.backgroundColor = RGB(29, 39, 57);
    _searchBar.backgroundColor =kAppColor8;//[UIColor whiteColor];  //GD_MainColor;//RGB(29, 39, 57);
    _searchFromType = WGSearchFromSearchMainType;
    for(id cc in [_searchBar subviews])
    {
        for (UIView *view in [cc subviews])
        {
            if ([NSStringFromClass(view.class)  isEqualToString:@"UISearchBarBackground"])
            {
                [view removeFromSuperview];
            }
            else if([NSStringFromClass(view.class)            isEqualToString:@"UISearchBarTextField"])
            {
                view.backgroundColor = kAppColor8;
            }
        }
    }

    // 修改查找取消按钮颜色
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kAppColor1,UITextAttributeTextColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextShadowOffset,[UIFont systemFontOfSize:14],UITextAttributeFont,nil] forState:UIControlStateNormal];
    //RGB(153, 153, 153)
    
    // Segmented bar
    _segmentedBar = [[NYSegmentedControl alloc] initWithItems:@[@"测验", @"考试"]];
    [_segmentedBar addTarget:self action:@selector(segmentSelected) forControlEvents:UIControlEventValueChanged];
    _segmentedBar.backgroundColor = [UIColor clearColor];
    _segmentedBar.segmentIndicatorBackgroundColor = [UIColor whiteColor];//RGB(101, 94, 230);
    _segmentedBar.segmentIndicatorInset = 0.0f;
    _segmentedBar.titleTextColor = kAppColor6;//RGB(160, 163, 181);
    _segmentedBar.titleFont=[UIFont systemFontOfSize:14];
    _segmentedBar.selectedTitleFont=[UIFont systemFontOfSize:14];
    _segmentedBar.selectedTitleTextColor = kAppColor1;//RGB(101, 94, 230);
    
    if (_bIsBlur)
    {// iOS7可设置是否需要现实磨砂玻璃效果
//        _imgViewBg.alpha = 0.0f;
//        _naviBar = [[UINavigationBar alloc] initWithFrame:self.bounds];
//        [self addSubview:_naviBar];
    }else{}
    
    // 设置frame
    _btnBack.frame = [[self class] backBtnFrame];
    _leftImgView.frame = [[self class] leftImgViewFrame];
    _labelTitle.frame = [[self class] titleViewFrame];
    _subLabelTitle.frame = [[self class] subTitleViewFrame];
//    _searchBar.frame = [[self class] searchBarFrame];
    _searchBarNewFrame = [[self class] searchBarFrame];
    _imgViewBg.frame = self.bounds;
//    _segmentedBar.frame = [[self class] segmentedBarFrame];
    
    [self addSubview:_btnBack];
    [self addSubview:_leftImgView];
    //[self addSubview:_imgViewBg];
    [self addSubview:_labelTitle];
    [self addSubview:_subLabelTitle];
    [self setLeftBtn:_btnLeft];
    [self setRightBtn:_btnRight];
    [self setMidBtn:_btnMidSub];
    [self setRightSubBtn:_btnRightSub];
    [self addSubview:_searchBar];
    [self addSubview:_segmentedBar];
    [self addSubview:_bottomLineImageView];
    /*
    UIView *lineView=[[UIView alloc]initWithFrame:Rect(0, self.bounds.size.height-0.5, ScreenWidth, 0.5)];
    lineView.backgroundColor=RGB(230, 230, 230);
    [self addSubview:lineView];
     */
}

- (void)setNavBarTypeTitleOnlyMode
{
    _btnBack.hidden = YES;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = NO;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = NO;
    _btnLeft.hidden = YES;
    _btnRight.hidden = YES;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = YES;
    
    [_labelTitle setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight,FLOAT_TitleLabelWidth, NaviBarHeight)];
}

- (void)setNavBarTypeLeftTitleMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = NO;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = NO;
    _btnLeft.hidden = YES;
    _btnRight.hidden = YES;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = YES;
    
    [_btnLeft setFrame:[[self class] leftBtnFrame]];
    [_labelTitle setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight,FLOAT_TitleLabelWidth, NaviBarHeight)];
}

- (void)setNavBarTypeLeftTitleRightMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = NO;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = NO;
    _btnLeft.hidden = YES;
    _btnRight.hidden = NO;
    _btnRightSub.hidden = YES;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = YES;
    
    [_btnLeft setFrame:[[self class] leftBtnFrame]];
    if(_btnRight.titleLabel.text)
    {
        [_btnRight setFrame:Rect((ScreenWidth-40.0f-FLOAT_BtnOffset), StatusBarHeight, 40.0f, NaviBarHeight)];
        _btnRight.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    }
    else
    {
        [_btnRight setFrame:[[self class] rightBtnFrame]];
    }
    
    [_labelTitle setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight,FLOAT_TitleLabelWidth, NaviBarHeight)];
}

- (void)setNavBarTypeLeftImgSearchRightMode
{
    _btnBack.hidden = YES;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = NO;
    _labelTitle.hidden = YES;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = NO;
    _btnLeft.hidden = NO;
    _btnRight.hidden = NO;
    _searchBar.hidden = NO;
    _segmentedBar.hidden = YES;
    
    [_btnLeft setFrame:Rect(FLOAT_LeftBtnX, StatusBarHeight, FLOAT_LeftBtnWidth, NaviBarHeight)];
    [_leftImgView setFrame:[[self class] leftImgViewFrame]];
    [_btnRight setFrame:[[self class] rightBtnFrame]];
    [_searchBar setFrame:[[self class] searchBarFrame]];
}

- (void)setNavBarTypeLeftSearchMode
{
    _btnBack.hidden = YES;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = YES;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = NO;
    _btnLeft.hidden = NO;
    _btnRight.hidden = YES;
    _searchBar.hidden = NO;
    _segmentedBar.hidden = YES;
    
    [_btnLeft setFrame:[[self class] leftBtnFrame]];
    [_searchBar setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight, FLOAT_TitleLabelWidth + FLOAT_BtnNormalWidth, NaviBarHeight)];
}

- (void)setNavBarTypeLeftTwoTitleMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = NO;
    _subLabelTitle.hidden = NO;
    _imgViewBg.hidden = NO;
    _btnLeft.hidden = YES;
    _btnRight.hidden = YES;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = YES;
    
    [_labelTitle setFrame:[[self class] titleViewFrame]];
    [_subLabelTitle setFrame:[[self class] subTitleViewFrame]];
}

- (void)setNavBarTypeSegmentLeftMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = YES;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = YES;
    _btnLeft.hidden = YES;
    _btnRight.hidden = NO;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = NO;
    
    [_segmentedBar setFrame:[[self class] segmentedBarFrame]];
}

- (void)setNavBarTypeSegmentRightMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = YES;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = YES;
    _btnLeft.hidden = YES;
    _btnRight.hidden = YES;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = NO;
    
    [_segmentedBar setFrame:[[self class] segmentedBarFrame]];
}

- (void)setNavBarTypeLeftTitleRightAndClearMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = NO;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = YES;
    _btnLeft.hidden = YES;
    _btnRight.hidden = NO;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
    
    [_btnLeft setFrame:[[self class] leftBtnFrame]];
    [_btnRight setFrame:[[self class] rightBtnFrame]];
    [_labelTitle setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight,FLOAT_TitleLabelWidth, NaviBarHeight)];
}

-(void)setNavBarTypeRightTitleMode
{
    _btnBack.hidden = YES;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = NO;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = NO;
    _btnLeft.hidden = YES;
    _btnRight.hidden = NO;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = YES;
    
    [_btnLeft setFrame:[[self class] leftBtnFrame]];
    [_labelTitle setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight,FLOAT_TitleLabelWidth, NaviBarHeight)];

}
-(void)setNavBarTypeRightButtonMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = NO;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = YES;
    _btnLeft.hidden = YES;
    _btnRight.hidden = NO;
    _btnRightSub.hidden = YES;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = YES;

    [_labelTitle setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight,FLOAT_TitleLabelWidth, NaviBarHeight)];
    [_btnRight setFrame:[[self class] rightBtnFrame]];
}

-(void)setNavBarTypeLeftTitleSearchRightMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = NO;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = YES;
    _btnLeft.hidden = YES;
    _btnRight.hidden = NO;
    _searchBar.hidden = NO;
    _segmentedBar.hidden = YES;

    [_labelTitle setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight,FLOAT_TitleLabelWidth, NaviBarHeight)];
    [_btnRight setFrame:[[self class] rightBtnFrame]];
    [_searchBar setFrame:[[self class] searchBarFrame]];
    _searchBar.left+=20;
   // _searchBar.backgroundColor=[UIColor redColor];
    
    
}

-(void)setNavBarTypeThreeBtnMode
{
    _btnBack.hidden = YES;
    _btnMidSub.hidden = NO;
    _btnRightSub.hidden = NO;
    _leftImgView.hidden = NO;
    _labelTitle.hidden = YES;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = YES;
    _btnLeft.hidden = NO;
    _btnRight.hidden = NO;
    _btnRightSub.hidden = NO;
    _searchBar.hidden = YES;
    _segmentedBar.hidden = YES;
    
    [_btnLeft setFrame:Rect(FLOAT_BtnOffset, StatusBarHeight+(NaviBarHeight-FLOAT_NormalBtnHeight)/2, FLOAT_NormalBtnWidth, FLOAT_NormalBtnHeight)];
    [_btnMidSub setFrame:Rect((ScreenWidth-FLOAT_NormalBtnWidth)/2, StatusBarHeight+(NaviBarHeight-FLOAT_NormalBtnHeight)/2, FLOAT_NormalBtnWidth, FLOAT_NormalBtnHeight)];
    [_leftImgView setFrame:Rect(_btnMidSub.frame.origin.x+_btnMidSub.frame.size.width+4.0f, FLOAT_LeftImgY, _leftImgView.frame.size.width, _leftImgView.frame.size.height)];
    [_btnRight setFrame:Rect(FLOAT_RightBtnX, StatusBarHeight+(NaviBarHeight-FLOAT_NormalBtnHeight)/2, FLOAT_NormalBtnWidth, FLOAT_NormalBtnHeight)];
    [_btnRightSub setFrame:Rect(FLOAT_RightSubBtnX, StatusBarHeight+(NaviBarHeight-FLOAT_NormalBtnHeight)/2, FLOAT_NormalBtnWidth, FLOAT_NormalBtnHeight)];
    //[_labelTitle setFrame:Rect(FLOAT_BtnNormalWidth, StatusBarHeight,FLOAT_TitleLabelWidth, NaviBarHeight)];
    
}

- (void)setNavBarTypeLeftBackRightSearchMode
{
    _btnBack.hidden = NO;
    _btnMidSub.hidden = YES;
    _btnRightSub.hidden = YES;
    _leftImgView.hidden = YES;
    _labelTitle.hidden = YES;
    _subLabelTitle.hidden = YES;
    _imgViewBg.hidden = YES;
    _btnLeft.hidden = YES;
    _btnRight.hidden = YES;
    _searchBar.hidden = NO;
    _segmentedBar.hidden = YES;
    
//    [_btnLeft setFrame:Rect(FLOAT_LeftBtnX, StatusBarHeight, FLOAT_LeftBtnWidth, NaviBarHeight)];
//    [_leftImgView setFrame:[[self class] leftImgViewFrame]];
//    [_btnRight setFrame:[[self class] rightBtnFrame]];
    [_searchBar setFrame:[[self class] searchBarFrame]];
    
}

- (void)btnBack:(id)sender
{
    if (self.m_viewCtrlParent && _backHandleByBar)
    {
        [self.m_viewCtrlParent.navigationController popViewControllerAnimated:YES];
    }//else{APP_ASSERT_STOP}
}

- (void)segmentSelected
{
    NSInteger index = _segmentedBar.selectedSegmentIndex;
    
    if(_cnbvDelegate
       && [_cnbvDelegate respondsToSelector:@selector(selectSegmentedAction:)])
    {
        [_cnbvDelegate selectSegmentedAction:index];
    }
}

- (void)setNavBarClear
{
    [_naviBar removeFromSuperview];
}

- (void)setMainLeftBtn:(NSString *)imgStr
{
    _btnLeft.hidden = NO;
    _btnBack.hidden = YES;
    [_btnLeft setFrame:Rect(FLOAT_BtnOffset, StatusBarHeight+(NaviBarHeight-FLOAT_NormalBtnHeight)/2, FLOAT_NormalBtnWidth, FLOAT_NormalBtnHeight)];
    [_btnLeft setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
}

- (void)setMainRightBtn:(NSString *)imgStr
{
    _btnRight.hidden = NO;
    [_btnRight setFrame:Rect(CGRectGetWidth(self.frame)-FLOAT_BtnOffset-FLOAT_NormalBtnWidth, StatusBarHeight+(NaviBarHeight-FLOAT_NormalBtnHeight)/2, FLOAT_NormalBtnWidth, FLOAT_NormalBtnHeight)];
    [_btnRight setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
}

@end

