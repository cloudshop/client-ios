//
//  CustomNaviBarView.h
//  Booking
//
//  Created by wihan on 14-10-20.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Configuration.h"
#import "CommonDef.h"

#define FLOAT_TitleSizeNormal               17.0f
#define FLOAT_TitleSizeMid                  15.0f
#define FLOAT_TitleSizeMini                 14.0f
#define FLOAT_TitleLabelWidth               200.0f
#define FLOAT_TitleLabelHeight              20.0f
#define FLOAT_BackBtnX                      6.0f //-5.5f
#define FLOAT_BackBtnWidth                  32.0f //55.0f
#define FLOAT_LeftBtnX                      6.0f  //5.0f
#define FLOAT_LeftBtnWidth                  40.0f
#define FLOAT_RightBtnX                     (ScreenWidth-FLOAT_RightBtnWidth-FLOAT_BtnOffset)
#define FLOAT_RightSubBtnX                  (FLOAT_RightBtnX-FLOAT_RightBtnWidth-FLOAT_BtnOffset)
#define FLOAT_RightBtnWidth                 32.0f//60.0f
#define FLOAT_LeftImgWidth                  15.0f
#define FLOAT_LeftImgHeight                 15.0f
#define FLOAT_LeftImgX                      40.0f
#define FLOAT_SearchBarX                    50.0f
#define FLOAT_SearchBarWidth                    (ScreenWidth-FLOAT_SearchBarX-15.0f)
#define FLOAT_SegmentBarWidth               150.0f
#define FLOAT_SegmentBarHeight              30.0f
#define FLOAT_NormalBtnWidth                32.0f //25.0f
#define FLOAT_NormalBtnHeight               32.0f //25.0f
#define FLOAT_LeftBtnOffset                 4.0f
#define FLOAT_BtnOffset                     (6.0f) //1.0f
#define FLOAT_LeftImgY                     (StatusBarHeight + (NaviBarHeight-FLOAT_LeftImgHeight)/2)
#define FLOAT_SegmentX                     ((ScreenWidth - FLOAT_SegmentBarWidth)/2)
#define FLOAT_SegmentY                     ((NaviBarHeight - FLOAT_SegmentBarHeight)/2 + StatusBarHeight)
//60.0f
#define FLOAT_BtnNormalWidth               ((ScreenWidth - FLOAT_TitleLabelWidth)/2)
//50.0f
#define FLOAT_BtnSmallWidth                (((ScreenWidth - FLOAT_TitleLabelWidth)/2) - FLOAT_LeftImgWidth)

#define RGB_TitleNormal                    RGB(80.0f, 80.0f, 80.0f)
//#define RGB_TitleNormal                    RGB(101, 94, 230)
#define RGB_TitleMini                      [UIColor blackColor]

@protocol CustomNaviBarViewDelegate;

typedef enum {
    NavBarTypeTitleOnly = 0,//标题
    NavBarTypeLeftTitle,//返回按钮+中间标题
    NavBarTypeLeftTitleRight,//左右两个按钮 +中间标题
    NavBarTypeLeftImgSearchRight,//
    NavBarTypeLeftSearch,//左返回+搜索框
    NavBarTypeLeftTwoTitle,//
    NavBarTypeSegmentLeft,//左返回+中间选择器
    NavBarTypeLeftTitleRightAndClear,
    NavBarTypeRightTitle,//
    NavBarTypeThreeBtn,//左中右三个按钮
    NavBarTypeLeftBackRightSearch,//左返回+右搜索
    NavBarTypeRightButton,//右按钮
    NavBarTypeSegmentRight,//中间选择器 +右按钮
    NavBarTypeLeftTitleSearchRight,//右边点击 导航栏改变格式
} NavBarType;

typedef enum {
    WGSearchFromSearchMainType = 0,
    WGSearchFromRecommendMainType,
    WGSearchFromAssignShopMainType
} WGSearchFromType;

@interface CustomNaviBarView : UIView

@property (nonatomic, readonly) UIButton *m_btnBack;
@property (nonatomic, readonly) UIImageView *m_leftImgView;
@property (nonatomic, readonly) UILabel *m_labelTitle;
@property (nonatomic, readonly) UILabel *m_subLabelTitle;
@property (nonatomic, readonly) UIImageView *m_imgViewBg;
@property (nonatomic, readonly) UIButton *m_btnLeft;
@property (nonatomic, readonly) UIButton *m_btnRight;
@property (nonatomic, readonly) UIButton *m_btnRightSub;
@property (nonatomic, readonly) UIButton * m_btnMidSub;
@property (nonatomic, readonly) UIImageView *m_bottomLineImageView;
@property (nonatomic, readonly) BOOL m_bIsBlur;
@property (nonatomic, readonly) UINavigationBar *naviBar;
@property (nonatomic, readonly) CGRect m_searchBarNewFrame;
@property (nonatomic, readonly) NSInteger m_searchFromType;

@property (nonatomic, weak) UIViewController *m_viewCtrlParent;
@property (nonatomic, readonly, strong) UISearchBar *m_searchBar;
@property (nonatomic, readonly, strong) NYSegmentedControl *m_segmentedBar;
@property (nonatomic, readonly) BOOL m_bIsCurrStateMiniMode;
@property (nonatomic, weak) id<CustomNaviBarViewDelegate> cnbvDelegate;
@property (nonatomic, assign) BOOL backHandleByBar;

+ (CGRect)rightBtnFrame;
+ (CGRect)leftBtnFrame;
+ (CGSize)barBtnSize;
+ (CGSize)smallBarBtnSize;
+ (CGSize)barSize;
+ (CGRect)titleViewFrame;
+ (CGRect)subTitleViewFrame;
+ (CGRect)leftImgViewFrame;
+ (CGRect)searchBarFrame;

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action;

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight target:(id)target action:(SEL)action;
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight imgSelected:(NSString *)strImgSelected target:(id)target action:(SEL)action;

// 用自定义的按钮和标题替换默认内容
- (void)setLeftBtn:(UIButton *)btn;
- (void)setRightBtn:(UIButton *)btn;
- (void)setMidBtn:(UIButton *)btn;
- (void)setTitle:(NSString *)strTitle;
- (void)setSubTitle:(NSString *)strTitle;
- (void)setLeftBtnDetail:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight text:(NSString *)text target:(id)target action:(SEL)action;
- (void)setRightBtnDetail:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight text:(NSString *)text target:(id)target action:(SEL)action;
- (void)setMidBtnDetail:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight text:(NSString *)text target:(id)target action:(SEL)action;
#pragma mark searchBar
- (void)setSearchBarToFullView;
- (void)setSearchBarToShowMenuBTView;
- (void)setSearchBarToNormalView;
- (void)setSearchBarForCustom;
- (void)setSearchBarToFullViewForRecommend;
- (void)setSearchBarToNormalViewForRecommend;
- (void)setSearchBarToNormalViewForAssignShop;
- (void)setSearchBarToFullViewForAssign;
// 设置导航栏模式
-(void)setLogInMode;//登录注册模块用蓝色背景方案
- (void)setNavBarMode:(NSInteger)type;
- (void)setNavBarClear;
- (void)resetLeftBtnFrame:(NSString *)str;
- (void)resetFrameForMain:(NSString *)str;
- (void)setMainLeftBtn:(NSString *)imgStr;
- (void)setMainRightBtn:(NSString *)imgStr;

//设置渐变色
-(void)setGradientClolr:(UIColor *)color;

@end

@protocol CustomNaviBarViewDelegate <NSObject>
@optional
- (void)selectSegmentedAction:(NSInteger)index;
-(void)NavBarSearchInfo:(NSString *)searchKey;
@end
