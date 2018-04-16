//
//  WGPublicData.h
//  Booking
//
//  Created by wihan on 14-11-4.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>
////#import "WGRecommendMainViewController.h"
////#import "WGSearchMainViewController.h"
////#import "WGMyselfViewController.h"
//#import "WGOrderMainViewController.h"
//#import "WGGoodsMainViewController.h"
//#import "HotCityElement.h"
//#import "WGRoundMainViewController.h"
#import "MainTabBarController.h"
////#import "WGMainAppViewController.h"
//#import "WGRoundMainViewController.h"
//#import "WGMessageViewController.h"
//#import "WGMyContactViewController.h"
@interface WGPublicData : NSObject


//@property (nonatomic, strong) WGMyCenterViewController *mycenterselfViewController;
////@property (nonatomic, strong) WGMainAppViewController *mainAppViewController;
//@property (nonatomic, strong) WGMessageViewController *messageViewController;
//
//@property (nonatomic, strong) WGOrderMainViewController *orderMainViewController;
//@property (nonatomic, strong) WGGoodsMainViewController *goodsMainViewController;
//@property (nonatomic, strong) WGRoundMainViewController *roundMainViewController;
//@property (nonatomic,strong) WGMyContactViewController *myContactViewController;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic,strong) MainTabBarController *roottabBarVC;
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) NSMutableArray *listFilterAry;
@property (nonatomic, strong) NSMutableArray *topModeListArray;
@property (nonatomic, strong) NSMutableArray *topModeListSelectArray;
@property (nonatomic, strong) NSMutableArray *topModeListSelectArrayForRecommend;
//@property (nonatomic, strong) HotCityElement *currentHotCityInfo;
//@property (nonatomic, strong) HotCityElement *currentGPSCityInfo;
@property (nonatomic, strong) NSArray *goodsTopTypeArray;
@property (nonatomic, strong) NSMutableArray *currentHotCityArray;
@property (nonatomic, strong) NSMutableArray *currentOpenCityArray;
@property (nonatomic, strong) NSMutableDictionary * totalProductDic;
@property (nonatomic, strong) NSMutableArray *hotKeyWordArray;
@property (nonatomic, assign) NSInteger tabBarItemType;
@property (nonatomic, assign) NSInteger recommendType;
@property (nonatomic, assign) NSInteger homeType;

@property (nonatomic, strong) NSMutableDictionary *wishListDictionary;
@property (nonatomic, assign) NSInteger oldIndex;
@property (nonatomic, assign) NSInteger oldType;
@property (nonatomic, strong) NSMutableArray *finishHeadImageArray;
@property (nonatomic, strong) UILabel *myRedPoint;
@property (nonatomic, strong) UIButton *dynamicBtn;
@property (nonatomic, strong) UIView *BgView;
@property (nonatomic, strong) NSMutableArray *assignShopAry;

//For 6.0
@property (nonatomic, assign) NSInteger myMsgCount;
@property (nonatomic, assign) NSInteger sysMsgCount;
@property (nonatomic, strong) NSMutableArray *allAreaArray;
@property (nonatomic, strong) NSMutableDictionary *otherPersionInfoDic;
@property (nonatomic, strong) NSMutableDictionary *groupInfoDic;
@property (nonatomic, strong) NSTimer *bannerTimer;

//记录网络状态  每次改变都会更新一下
@property (nonatomic,assign) NetworkStatus networkStatus;

+ (WGPublicData *)sharedInstance;

//For city
- (BOOL)checkCity:(NSString *)currentCity;
//- (HotCityElement *)changeCity:(NSString *)currentCity;
//- (void)saveCurrentCityInfo:(HotCityElement *)cityInfo;
-(void)saveCurrentHotCityArr:(NSMutableArray *)arr andOpenCitArr:(NSMutableArray *)openArr;
- (BOOL)checkSameCity;
- (void)initCityAndlocationInfo;
- (void)setMyMsgCountInfo;
- (void)setGPSCityInfo;
- (void)cancelBannerTimer;
- (void)clearLoginInfo;

@end
