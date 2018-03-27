//
//  SharedUserDefault.h
//  Booking
//
//  Created by wihan on 14-10-16.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserElement.h"
//
//#import "TestContentElement.h"


@interface SharedUserDefault : NSObject


+(SharedUserDefault *)sharedInstance;

/*
 * 设置用户是否是第一次启动app
 */
-(void)setFirstStartApp:(NSString *)isFirst;

/*
 * 判断用户是否是第一次启动app
 */
-(NSString *)isFirstStartApp;


/*
 * 判断用户是否登入状态
 */
-(BOOL)isLogin;

/*
 * 设置用户的登陆状态
 */
- (void)setLoginState:(NSString *)state;

/*
 * 存储用户的数据
 */
- (void)setUserInfo:(NSData *)userElement;

/*
 * 删除用户的数据
 */
- (void)removeUserInfo;


/*
 * 获取用户的数据
 */
- (UserElement *)getUserInfo;


/*
 * 存储会话的token
 */
- (void)setUserToken:(NSString *)usertoken;
/*
 * 获取会话的token
 */
- (NSString *)getUserToken;
/*
 * 删除会话的token
 */
-(void)removeUserToken;

/*
 * 存储手机计入后台的时间
 */
- (void)setBackgroundTime:(NSDate *)backgroundDate;
/*
 * 获取手机上次进入后台的时间
 */
- (NSDate *)getBackgroundTime;

/**
 * 计算两个时间的差
 */
- (NSDictionary *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/*
 * 判断是否发送唯一标识及版本状态
 */
-(BOOL) isSendVersionIndentifier ;

/*
 * 根据系统参数名获取该类数组
 * @param typeName 系统参数键值
 */
-(NSArray *) getSystemType:(NSString *) typeName ;

/*
 * 根据系统参数获取对应的参数值
 * @param typeName 系统参数键值
 * @param paramId 类型id
 */
-(NSString *) getSystemNameType:(NSString *) typeName andTypeKey:(NSString *) paramId ;

/*
 * 系统参数的保存数据
 */
-(void) saveSysetmParam:(id) inParam ;

/*
 * 系统参数的获取
 */
-(id) getSystemParam ;

/**
 *  保存用户调用版本检测接口的时间
 *
 *  @param dateStr 时间值
 *
 *  @since 1.0.0
 */
-(void) setVersionCheckDate:(NSString*)dateStr;

/**
 *  获取用户上次调用版本检测接口的时间
 *
 *  @return 版本检测的时间值
 *
 *  @since 1.0.0
 */
-(NSString*) getVersionCheckDate;

/*
 * 存储用户搜索内容
 */
- (void)setSearchHistoryInfo:(NSMutableArray *)info;

/*
 * 获取用户搜索内容
 */
- (NSMutableArray *)getSearchHistoryInfo;


/*
 * 设置红点提醒
 */
-(void) setMyRedPointFlag:(BOOL) flag;

/*
 * 得到红点提醒
 */
-(BOOL) getMyRedPointFlag;


/*
 * 设置版本更新flag
 */
- (void)setUpdateFlag:(NSString *)flag;

/*
 * 得到版本更新flag
 */
- (NSString*)getUpdateFlag;

/*
 * 设置上一个更新版本
 */
- (void)setUpdatePreviousVersion:(NSString *)version;

/*
 * 得到上一个更新版本
 */
- (NSString*)getUpdatePreviousVersion;

/*
 * 缓存首页场所信息
 */
- (void)setRootFindPlaceCache:(NSDictionary *)dic;

/*
 * 得到首页场所信息
 */
- (NSDictionary*)getRootFindPlaceCache;

/*
 * 缓存朋友圈信息
 */
- (void)setCircleFriendCache:(NSDictionary *)dic;


/*
 * 得到朋友圈缓存信息
 */
- (NSDictionary*)getCircleFriendCache;

/*
 * 缓存token
 */
- (void)setTokenCache:(NSString *)dic;


/*
 * 得到token
 */
- (NSString*)getTokenCache;


@end
