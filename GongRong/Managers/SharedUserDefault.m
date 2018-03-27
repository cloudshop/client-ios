//
//  SharedUserDefault.m
//  Booking
//
//  Created by wihan on 14-10-16.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

/*
 *SharedUserDefault 用来存储用户信信息以及本地数据的缓存
 */

#import "SharedUserDefault.h"


#define kProduct_playType @"product_playType"

static SharedUserDefault *sharedDefault ;

@implementation SharedUserDefault

-(void)setFirstStartApp:(NSString *)isFirst
{
    [[NSUserDefaults standardUserDefaults] setObject:isFirst forKey:@"IsFirstStartApp"];
}

- (NSString *)isFirstStartApp
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirstStartApp"];
}
/*
 *提醒升级
 */
-(void)setUpgrade:(NSString *)upgrade
{
    [[NSUserDefaults standardUserDefaults] setObject:upgrade forKey:@"IsUpgrade"];
}
-(NSString *)isUpgrade
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"IsUpgrade"];
}
+(SharedUserDefault *)sharedInstance{
    if( sharedDefault == nil)
    {
        sharedDefault = [[SharedUserDefault alloc]init];
    }
    return sharedDefault ;
}

/*
 * 判断用户是否登入状态
 */
-(BOOL)isLogin{
    BOOL state = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userIsLogin"] != nil && [[[NSUserDefaults standardUserDefaults] objectForKey:@"userIsLogin"] isEqualToString:@"Y"])
    {
        state = YES;
    }
    return state;
}

- (BOOL)isUserComment
{
    BOOL state = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"IsCommentAlert"] != nil && [[[NSUserDefaults standardUserDefaults] objectForKey:@"IsCommentAlert"] isEqualToString:@"Y"])
    {
        state = YES;
    }
    return state;
}

- (void)setUserComment:(NSString *)comment
{
    [[NSUserDefaults standardUserDefaults] setObject:comment forKey:@"IsCommentAlert"];
}

/*
 * 设置用户的登陆状态
 */
- (void)setLoginState:(NSString *)state
{
    [[NSUserDefaults standardUserDefaults] setObject:state forKey:@"userIsLogin"];
}

/*
 * 存储用户的信息
 */
- (void)setUserInfo:(NSData *)userElement
{
    [[NSUserDefaults standardUserDefaults] setObject:userElement forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/*
 * 获取用户的数据
 */
- (UserElement *)getUserInfo
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"])
    {
        NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return [[UserElement alloc] init];
}

/*
 * 注销删除用户的数据
 */
- (void)removeUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
     [[NSUserDefaults standardUserDefaults]synchronize];
}

/*
 * 存储会话的token
 */
- (void)setUserToken:(NSString *)usertoken
{
    [[NSUserDefaults standardUserDefaults] setObject:usertoken forKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/*
 * 获取会话的token
 */
- (NSString *)getUserToken
{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
    return token;
}

/*
 * 删除会话的token
 */
-(void)removeUserToken
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 * 存储手机计入后台的时间
 */
- (void)setBackgroundTime:(NSDate *)backgroundDate
{
    [[NSUserDefaults standardUserDefaults] setObject:backgroundDate forKey:@"background"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/*
 * 获取手机上次进入后台的时间
 */
- (NSDate *)getBackgroundTime
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"background"])
    {
        NSDate *date=[[NSUserDefaults standardUserDefaults] objectForKey:@"background"];
        return date;
    }
    return nil;
}
/**
 * 计算两个时间的差
 */
- (NSDictionary *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"耗时%d秒",second];
    }
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",day],@"D",[NSString stringWithFormat:@"%d",house],@"H",[NSString stringWithFormat:@"%d",minute],@"M",[NSString stringWithFormat:@"%d",second],@"S", nil];
    return dic;
}

/*
 * 判断是否发送唯一标识及版本状态
 */
-(BOOL) isSendVersionIndentifier {
    BOOL isSendState = NO ;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *sendTimeStr = [userDefault objectForKey:@"sendDate"];
    
    //当前NSDate
    NSDate *date = [NSDate date];
    NSTimeInterval timeStr = [date timeIntervalSince1970];
    if(nil != sendTimeStr && ![@"" isEqualToString:sendTimeStr]){
        NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:[sendTimeStr doubleValue]];
        NSDate *cDate = [sendDate dateByAddingTimeInterval:24*60*60];
        NSDate *eDate = [cDate laterDate:date];
        if([eDate isEqualToDate:date]){
            isSendState = YES;
            [userDefault setObject:[NSString stringWithFormat:@"%f",timeStr] forKey:@"sendDate"];
        }
    }else{
        
        [userDefault setObject:[NSString stringWithFormat:@"%f",timeStr] forKey:@"sendDate"];
        isSendState = YES;
    }
    return isSendState ;
}



/*
 * 省份解析
 */
-(NSArray *) getProvincesList {
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"province.txt"];
    [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *textFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *citys = [textFile componentsSeparatedByString:@"\n"];
    NSMutableArray *provincesAry = [[NSMutableArray alloc] init];
    for (NSString *content in citys) {
        NSLog(@"%@",content);
        if([content isEqualToString:@""]) break;
        NSString *contentStr = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSArray *provinces = [contentStr componentsSeparatedByString:@";"];
        NSDictionary *proDic = [[NSDictionary alloc] initWithObjectsAndKeys:[provinces objectAtIndex:2],[provinces objectAtIndex:0], nil];
        [provincesAry addObject:proDic];
        
    }
    return provincesAry ;
}

/*
 * 城市文件的解析
 */
-(NSArray *) getCityList {
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"city.txt"];
    [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *textFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *citys = [textFile componentsSeparatedByString:@"\n"];
    NSMutableArray *provincesAry = [[NSMutableArray alloc] init];
    for (NSString *content in citys) {
        //        NSLog(@"%@",content);
        if([content isEqualToString:@""]) break;
        NSString *contentStr = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSArray *provinces = [contentStr componentsSeparatedByString:@";"];
        NSDictionary *proDic = [[NSDictionary alloc] initWithObjectsAndKeys:[provinces objectAtIndex:2],[provinces objectAtIndex:1],nil];
        [provincesAry addObject:proDic];
        
    }
    return provincesAry ;
}

/*
 * 省份城市列表
 */
-(NSMutableDictionary *) getProvinceCitysList {
    NSArray *provinces = [self getProvincesList];
    NSMutableArray *provinceKeys = [[NSMutableArray alloc] init];
    for (NSDictionary *provinceDic in provinces) {
        NSString *provinceKey = [[provinceDic allKeys] objectAtIndex:0];
        [provinceKeys addObject:provinceKey];
    }
    
    NSMutableDictionary *proCitys = [[NSMutableDictionary alloc] init];
    NSArray *citys = [self getCityList];
    for (NSString *key in provinceKeys) {
        NSMutableArray *cityMuAry = [[NSMutableArray alloc] init];
        for (NSDictionary *cityDic in citys) {
            NSString *cityKey = [[cityDic allKeys] objectAtIndex:0];
            if([key isEqualToString:cityKey]){
                [cityMuAry addObject:cityDic];
            }
        }
        [proCitys setObject:cityMuAry forKey:key];
    }
    return proCitys ;
}

/*
 * 依据城市名查找城市编号
 */
-(NSString *) getCityCode:(NSString *) cityName {
    NSString *cityCode = @"";
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"city.txt"];
    [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *textFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *citys = [textFile componentsSeparatedByString:@"\n"];
    for (NSString *content in citys) {
        //        NSLog(@"%@",content);
        if([content isEqualToString:@""]) break;
        NSString *contentStr = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSArray *provinces = [contentStr componentsSeparatedByString:@";"];
        if([[provinces objectAtIndex:2] isEqualToString:cityName]){
            cityCode = [provinces objectAtIndex:0];
        }
        
    }
    return cityCode ;
}



/*
 * 设置红点提醒
 */
-(void) setMyRedPointFlag:(BOOL) flag {
    NSNumber *flagNum = [NSNumber numberWithBool:flag];
    [[NSUserDefaults standardUserDefaults] setObject:flagNum forKey:@"REDPOINTFLAG"];
}

/*
 * 得到红点提醒
 */
-(BOOL) getMyRedPointFlag  {
    NSNumber *flagNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"REDPOINTFLAG"];
    BOOL flag = [flagNum boolValue];
    return flag ;
}


/*
 * 设置版本更新flag
 */
- (void)setUpdateFlag:(NSString *)flag
{
    [[NSUserDefaults standardUserDefaults] setObject:flag forKey:@"VERSIONFLAG"];
}

/*
 * 得到版本更新flag
 */
- (NSString*)getUpdateFlag
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"VERSIONFLAG"];
}

/*
 * 设置上一个更新版本
 */
- (void)setUpdatePreviousVersion:(NSString *)version
{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"PREVIOUSVERSION"];
}

/*
 * 得到上一个更新版本
 */
- (NSString*)getUpdatePreviousVersion
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"PREVIOUSVERSION"];
}

/*
 * 缓存首页场所信息
 */
- (void)setRootFindPlaceCache:(NSDictionary *)dic
{
//[[NSUserDefaults standardUserDefaults] setObject:dic forKey:ROOTFINDPLACECACHE];
}

/*
 * 得到首页场所信息
 */
- (NSDictionary*)getRootFindPlaceCache
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ROOTFINDPLACECACHE"];
}

/*
 * 缓存朋友圈信息
 */
- (void)setCircleFriendCache:(NSDictionary *)dic
{
    NSString *jsonStr=[dic JSONString];
   // [[NSUserDefaults standardUserDefaults] setObject:jsonStr forKey:CIRCLEFRIENDCACHE];
}

/*
 * 得到朋友圈缓存信息
 */
- (NSDictionary*)getCircleFriendCache
{
   
     NSString *jsonStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"CIRCLEFRIENDCACHE"];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
   
}
/*
 * 缓存token
 */
- (void)setTokenCache:(NSString *)dic
{
 [[NSUserDefaults standardUserDefaults] setObject:dic forKey:TOKENCACHE];
}


/*
 * 得到token
 */
- (NSString*)getTokenCache
{
return [[NSUserDefaults standardUserDefaults] objectForKey:TOKENCACHE];
}

@end
