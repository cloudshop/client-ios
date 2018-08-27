//
//  CommonDef.h
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#ifndef CommonDef_h
#define CommonDef_h

#import "UIKit+AFNetworking.h"

#import "UIView+RelativeLayout.h"
#import "UIColor+Extension.h"
#import "UIImage+Extension.h"
#import "UIFont+Extension.h"
#import "UIImageView+Extension.h"
#import "NSMutableDictionary+OrNil.h"
#import "NSArray+OrNil.h"
#import "NSMutableArray+OrNil.h"
#import "NSString+Extension.h"
#import "UIView+Named.h"
#import "NSObject+AutoParse.h"
#import "UIView+VCFinder.h"
#import "NSString+JSONUtils.h"
#import "UIViewController+BackAction.h"
#import "UIView+Factory.h"
#import "UIImageView+LBBlurredImage.h"

#import "NYSegmentedControl.h"

#import "SVProgressHUD.h"
#import "MJExtension.h"
//网络图片
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

//
#import "Reachability.h"
//
#import "JSONModel.h"
#import "JSONKeyMapper.h"

//监控
#import "Mcu_sdk/MCUVmsNetSDK.h"

/*
 广播字段
 */
//登录状态变化
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
//token失效
#define KNOTIFICATION_TokenInvalid @"TokenInvalid"

#define TOKENCACHE @"UserTokenCache"

//后台时间超长应该返回首页
#define KNOTIFICATION_ShouldBackHome @"ShouldBackHome"

//在播放页进入挂起状态 挂起时间过长的话 关闭播放器
#define KNOTIFICATION_CloseVideoPlayer @"CloseVideoPlayer"

//文件下载完成后广播
#define KNOTIFICATION_FileDownloadOK @"FileDownloadSuccess"
//网络由wifi切换到4g通知
#define KNOTIFICATION_NetworkChangeWLAN @"NetworkChangeWLAN"
//#define KNOTIFICATION_FileDownloadOK @"FileDownloadSuccess"

#define UPDATE_UNREAD_MESSAGE @"updateUnreadMessage"

#define kNotification_didSelectCity @"didSelectedNewCity"

// 登陆 注销登录通知
#define kLoginSuccessNotification @"kLoginSuccessNotification"
#define kLoginOutNotification @"kLoginOutNotification"
#define kSignSuccessNotification @"kSignSuccessNotification"


#define IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0)
#define IOS8_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 10.0)
#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

//提示语 TEXT
#define NO_DATA_TEXT @"已经到底了!"
#define NO_NETWORK_TEXT @"网络连接异常，请检查网络!"

//JS调用方法的合法标记
#define FunctionNameTag  @"GongRongCredits"

#define JSModel @"GongrongAppModel"
#define JSRefreshAllTag @"refreshAll"
#define     JSFuncOpenTag       @"openURL"
#define        JSFuncCloseTag        @"closeCurrent"
#define  JSFuncShareTag   @"share"

#define  JSFuncLogisticsTag  @"checkLogistics"
#define  JSFuncsetNewCity    @"setNewCity"
#define  JSFuncScanTag  @"scan"
#define JSFuncPayTag    @"pay"
#define  JSPayType  @"payType"
#define  JSPay_Wechat  @"Wechat"
#define  JSPay_Ali  @"Ali"
/*
 *16进制颜色转换
 */
#define UIColorWithHex(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define kAppColorBackground     RGB(243,244,248)//页面背景颜色
#define kVCBackgroundColor      kAppColorBackground
#define INFO_TEXT_COLOR [UIColor colorWithRed:0.780 green:0.780 blue:0.780 alpha:1]

// 字体颜色
#define kHexColor1              0x2F9CFF //蓝
#define kHexColor2              0xFF7D73 //
#define kHexColor3              0x918EFF //浅紫
#define kHexColor4              0x484848 //常用浅黑
#define kHexColor5              0x323232 //常用字黑色
#define kHexColor6              0x777777 //常用字灰色
#define kHexColor12              0x5c677d //常用字蓝灰
#define kHexColor7              0xE6E6E6 //
#define kHexColor8              0xFFFFFF //白色
#define kHexColor9              0x9B9B9B // 未选中button灰
#define kHexColor10             0xF5482A //button红
#define kHexColor11             0xEFEFF4 //页面背景灰


#define kHexOrderBTBGColor      0xFE711C //订单按钮背景色
#define kAppColorSeparate       [UIColor colorWithHex:kHexColor7 alpha:1.0]//分割颜色

#define kAppMainColor           [UIColor colorWithHex:0xff0103 alpha:1.0]
#define kAppColor1              [UIColor colorWithHex:kHexColor1 alpha:1.0]
#define kAppColor2              [UIColor colorWithHex:kHexColor2 alpha:1.0]
#define kAppColor3              [UIColor colorWithHex:kHexColor3 alpha:1.0]
#define kAppColor4              [UIColor colorWithHex:kHexColor4 alpha:1.0]
#define kAppColor5              [UIColor colorWithHex:kHexColor5 alpha:1.0]
#define kAppColor6              [UIColor colorWithHex:kHexColor6 alpha:1.0]
#define kAppColor7              [UIColor colorWithHex:kHexColor12 alpha:1.0]//中意蓝灰字颜色

#define kAppColor8              [UIColor colorWithHex:kHexColor8 alpha:1.0]//control color
#define kAppColor9              [UIColor colorWithHex:kHexColor9 alpha:1.0]
#define kAppColor10             [UIColor colorWithHex:kHexColor10 alpha:1.0]

// 字体大小
#define kFontSize1              17
#define kFontSize2              16
#define kFontSize3              15
#define kFontSize4              14
#define kFontSize5              13
#define kFontSize6              12
#define kFontSize7              11
#define kFontSize8              10
//普通字体
#define kAppFont1               [UIFont appNormalFont:kFontSize1]
#define kAppFont2               [UIFont appNormalFont:kFontSize2]
#define kAppFont3               [UIFont appNormalFont:kFontSize3]
#define kAppFont4               [UIFont appNormalFont:kFontSize4]
#define kAppFont5               [UIFont appNormalFont:kFontSize5]
#define kAppFont6               [UIFont appNormalFont:kFontSize6]
#define kAppFont7               [UIFont appNormalFont:kFontSize7]
#define kAppFont8               [UIFont appNormalFont:kFontSize8]

//加粗字体
#define kAppBoldFont1           [UIFont appBoldFont:kFontSize1]
#define kAppBoldFont2           [UIFont appBoldFont:kFontSize2]
#define kAppBoldFont3           [UIFont appBoldFont:kFontSize3]
#define kAppBoldFont4           [UIFont appBoldFont:kFontSize4]
#define kAppBoldFont5           [UIFont appBoldFont:kFontSize5]
#define kAppBoldFont6           [UIFont appBoldFont:kFontSize6]
#define kAppBoldFont7           [UIFont appBoldFont:kFontSize7]

/*
 *系统常用字段的定义
 */
#define FILE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define SYSTEM_VERSION [UIDevice currentDevice].systemVersion.intValue //判断系统版本

#define ApplicationDelegate                 ((BubblyAppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define SelfNavBar                          self.navigationController.navigationBar
#define SelfTabBar                          self.tabBarController.tabBar
#define SelfNavBarHeight                    self.navigationController.navigationBar.bounds.size.height
#define SelfTabBarHeight                    self.tabBarController.tabBar.bounds.size.height
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define ScreenCenter                         CGPointMake(ScreenWidth/2, ScreenHeight/2);
#define TouchHeightDefault                  44
#define TouchHeightSmall                    32
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define FlushPool(p)                        [p drain]; p = [[NSAutoreleasePool alloc] init]
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define SelfDefaultToolbarHeight            self.navigationController.navigationBar.frame.size.height
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsiOS7Later                         !(IOSVersion < 7.0)
#define IOSModel                            [UIDevice currentDevice].model
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)

#define IS_IPHONE_X (ScreenHeight == 812.0f) ? YES : NO

#define ImageHeight                         32.0f
#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define TabBarHeight                        (IS_IPHONE_X==YES)?83.0f: 49.0f
#define NaviBarHeight                       44.0f
#define HeightFor4InchScreen                568.0f
#define HeightFor3p5InchScreen              480.0f
#define TopScrollViewHeight                 44.0f
#define TableFooterViewHeight               30.0f

#define TopScrollImageViewHeight            160.0f
#define TopScrollImageViewWidth             320.0f
#define TopScrollImageViewRealHeight        ((TopScrollImageViewHeight * ScreenWidth)/TopScrollImageViewWidth)

#define HotRecommendImageViewHeight            150.0f
#define HotRecommendImageViewWidth             300.0f
#define KeyBoardHeight                         250.0f
#define HotRecommendImageViewRealHeight        ((HotRecommendImageViewHeight * ScreenWidth)/HotRecommendImageViewWidth)

#define MainCellImageRealHeight(w)        ((3.0f * (w))/5.0f)

#define ViewCtrlTopBarHeight                (IsiOS7Later ? (NaviBarHeight + StatusBarHeight) : NaviBarHeight)
#define IsUseIOS7SystemSwipeGoBack          (IsiOS7Later ? YES : NO)

#define OnePageCount                           10
#define PicSizeScale                           100.0f

#define kNavButtonSize          30.0


#define Is4Inch                                 [UtilityFunc is4InchScreen]
#define RGB_TextDark                            RGB(10.0f, 10.0f, 10.0f)


//监控

//登录界面相关
#pragma mark --登录及地址界面
static NSTimeInterval const delayTime = 2.5;

//textField允许输入的最大长度
#define ALLOWMAXLENGTH 32

#define CELL_LEFTDISTANCE 20.0f//tableview中图片离左边的距离
//判断iphone类型
#define IPHONE4 ([UIScreen mainScreen].bounds.size.height<568)
// 屏幕祥光
#define SCREEN_WIDTH_SCALE ScreenWidth/320.0
#define SCREEN_HEIGHT_SCALE ScreenHeight/568.0

#define CONTROLLER_VIEW_WIDTH self.view.frame.size.width
#define CONTROLLER_VIEW_HEIGHT self.view.frame.size.height


#define VIDEOVIEW_BACKGROUNDCOLOR [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]
//tableview中分割线的颜色
#define CELL_SEPARATOR_COLOR COLOR(240.0f,240.0f,240.0f,1.0f)
#define TABLE_SEPARATOR_COLOR COLOR(230.0f,230.0f,230.0f,1.0f)

//rgb颜色设置
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//背景色
#define backGroundColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]
/**
 *  字体大小
 */
#define SIZE10 10.0f
#define SIZE11 11.0f
#define SIZE12 12.0f
#define SIZE13 13.0f
#define SIZE14 14.0f
#define SIZE15 15.0f
#define SIZE17 17.0f
#define SIZE18 18.0f
#define SIZE20 20.0f
#define SIZE25 25.0f



#define MSP_ADDRESS     @"MSP_8710_Address"
#define MSP_PORT        @"MSP_871_Port"
#define MSP_USERNAME    @"MSP_871_username"
#define MSP_PASSWORD    @"MSP_871_password"
#define DEFAULT_MSP_PORT @"443"
#define PUSH_SERVER_ADDRESS @"60.191.22.218"
#define PUSH_SERVER_PORT @"8443"

//云台控制
#define PTZ_COMMAND_ZOOM_IN             11      //焦距增大
#define PTZ_COMMAND_ZOOM_OUT            12      //焦距减小
#define PTZ_COMMAND_FOCUS_NEAR          13      //聚焦增大
#define PTZ_COMMAND_FOCUS_FAR           14      //聚焦减小
#define PTZ_COMMAND_IRIS_OPEN           15      //光圈增大
#define PTZ_COMMAND_IRIS_CLOSE          16      //光圈减小

#define PTZ_COMMAND_TILT_UP             21
#define PTZ_COMMAND_TILT_DOWN           22
#define PTZ_COMMAND_PAN_LEFT            23
#define PTZ_COMMAND_PAN_RIGHT           24
#define PTZ_COMMAND_UP_LEFT             25
#define PTZ_COMMAND_UP_RIGHT            26
#define PTZ_COMMAND_DOWN_LEFT           27
#define PTZ_COMMAND_DOWN_RIGHT          28

#define PTZ_COMMAND_PRESET_SET          8       //设置预置点
#define PTZ_COMMAND_PRESET_CLEAN        9       //清除预置点
#define PTZ_COMMAND_PRESET_GOTO         39      //调用预置点

//清晰度
#define VIDEO_QUALITY_FLUENCY           2       //流畅
#define VIDEO_QUALITY_CLEAR             1       //标清
#define VIDEO_QUALITY_HIGHDEFINITION    0       //高清

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] show]

//监控 end


#ifdef GR_DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define LRLog(...) printf(" %s 第%d行: %s\n\n", [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define LRLog(...)
#endif

#endif /* CommonDef_h */
