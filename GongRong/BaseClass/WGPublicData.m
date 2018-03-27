//
//  WGPublicData.m
//  Booking
//
//  Created by wihan on 14-11-4.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import "WGPublicData.h"
//#import "Configuration.h"
//#import "SharedUserDefault.h"
#import "WGLocationManager.h"

@implementation WGPublicData

#pragma mark Public Function

+ (WGPublicData *)sharedInstance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{instance = [[[self class] alloc] init];});
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _totalProductDic = [NSMutableDictionary new];
       // _currentHotCityInfo = [[HotCityElement alloc] init];
//        _tabBarItemType = WGTabBarTypeHome;
//        _recommendType = WGSegmentTypeHot;
//        _homeType = WGHomeTypeOther;
        _oldIndex = -1;
        _oldType = -1;
        _myMsgCount = 0;
        _sysMsgCount = 0;
    }
    return self;
}

- (BOOL)checkCity:(NSString *)currentCity
{
    BOOL result = FALSE;
//    if([SharedUserDefault sharedInstance].getHotCityInfo && currentCity)
//    {
//        NSString *saveCity = [[SharedUserDefault sharedInstance].getHotCityInfo objectForKey:@"areaName"];
//        if(![currentCity compare:saveCity])
//        {
//            result = TRUE;
//        }
//    }
//    else
    {
        //no data it is the same as the same city
        result = TRUE;
    }
    return result;
}

/*
- (HotCityElement *)changeCity:(NSString *)currentCity
{
    HotCityElement *result = nil;
    if(_currentHotCityArray && _currentHotCityArray.count)
    {
        for(HotCityElement *cityElement in _currentHotCityArray)
        {
            if(![currentCity compare:cityElement.areaName])
            {
                result = cityElement;
                _currentHotCityInfo = cityElement;
                [self saveCurrentCityInfo:cityElement];
                break;
            }
        }
    }
    if(_currentOpenCityArray && _currentOpenCityArray.count)
    {
        for(HotCityElement *cityElement in _currentOpenCityArray)
        {
            if(![currentCity compare:cityElement.areaName])
            {
                result = cityElement;
                _currentHotCityInfo = cityElement;
                [self saveCurrentCityInfo:cityElement];
                break;
            }
        }
    }

    return result;
}

- (BOOL)checkSameCity
{
    BOOL reslut = FALSE;
    NSString *myCityName = [SharedUserDefault sharedInstance].getCityName;
    HotCityElement *cityInfo = [WGPublicData sharedInstance].currentHotCityInfo;
    //Current select city
    if(cityInfo && myCityName)
    {
        NSString *currentCityName = cityInfo.areaName;
        if(![myCityName compare:currentCityName])
        {
            reslut = TRUE;
        }
    }
    else
    {
        //No data the same as the same city
        reslut = TRUE;
    }
    return reslut;
}
*/
/*
- (void)saveCurrentCityInfo:(HotCityElement *)cityInfo
{
    NSLog(@"publicData  saveCurrentCityInfo");
    _currentHotCityInfo = cityInfo;
    NSLog(@"cityInfo.scale:%@",cityInfo.scale);
    if(cityInfo)
    {
        NSMutableDictionary *cityDic = [NSMutableDictionary new];
        NSLog(@"cityInfo.scale:%@",cityInfo.scale);
        [cityDic setObject:cityInfo.scale forKey:@"scale"];
       // NSLog(@"cityInfo.scale:%@",cityInfo.scale);
        [cityDic setObject:cityInfo.areaName forKey:@"areaName"];
        [cityDic setObject:cityInfo.longitude forKey:@"longitude"];
        [cityDic setObject:cityInfo.latitude forKey:@"latitude"];
        [cityDic setObject:cityInfo.baiduId forKey:@"baiduId"];
        [cityDic setObject:cityInfo.areaId forKey:@"areaId"];
        [cityDic setObject:cityInfo.areaCode forKey:@"areaCode"];
        
        [[SharedUserDefault sharedInstance] setHotCityInfo:cityDic];
       
    }
    else
    {
        NSLog(@"saveCurrentCityInfo 失败");
    }
}
*/
/*
- (void)initCityAndlocationInfo
{
   //--------v2.5.5之前的处理方法
    /*
    _currentHotCityInfo.scale = @"12";
    _currentHotCityInfo.areaId = @"110100";
    _currentHotCityInfo.areaName = @"北京市";
    _currentHotCityInfo.baiduId = @"131";
    _currentHotCityInfo.latitude = @"39.929986";
    _currentHotCityInfo.longitude = @"116.395645";
    _currentHotCityInfo.areaCode = @"S";
    
    
 
    //-------V2.5.6-----初始化Public 没有数据直接return
    if([SharedUserDefault sharedInstance].getHotCityInfo)  //得到当前所选城市信息
    {
        NSDictionary *dic=[SharedUserDefault sharedInstance].getHotCityInfo;
        _currentHotCityArray=[[SharedUserDefault sharedInstance] getCurrentCityArr];
        _currentOpenCityArray=[[SharedUserDefault sharedInstance] getCurrentOpenCityArr];
        
        NSLog(@"初始化publicData%@",dic);
        _currentHotCityInfo.scale = [dic objectForKey:@"scale"];
        _currentHotCityInfo.areaId =  [dic objectForKey:@"areaId"];
        _currentHotCityInfo.areaName =  [dic objectForKey:@"areaName"];
        _currentHotCityInfo.baiduId =  [dic objectForKey:@"baiduId"];
        _currentHotCityInfo.latitude =  [dic objectForKey:@"latitude"];
        _currentHotCityInfo.longitude =  [dic objectForKey:@"longitude"];
        _currentHotCityInfo.areaCode =  [dic objectForKey:@"areaCode"];
    }
    else
    {
        return;
    }
    
    if(![SharedUserDefault sharedInstance].getLongitude || ![SharedUserDefault sharedInstance].getLatitude)
    {
        [[SharedUserDefault sharedInstance] setLatitudeAndLongitude:_currentHotCityInfo.latitude andLat:_currentHotCityInfo.longitude];
    }
    
    if(![SharedUserDefault sharedInstance].getCurrentAddress)
    {
        [[SharedUserDefault sharedInstance] setCurrentAddress:_currentHotCityInfo.areaName];
    }
    
    if(![SharedUserDefault sharedInstance].getCityName)
    {
        [[SharedUserDefault sharedInstance] setCityName:_currentHotCityInfo.areaName];
    }
    [WGLocationManager sharedInstance].latitude = [_currentHotCityInfo.latitude floatValue];
    [WGLocationManager sharedInstance].longitude = [_currentHotCityInfo.longitude floatValue];
    [WGLocationManager sharedInstance].lastCity = _currentHotCityInfo.areaName;
    [WGLocationManager sharedInstance].lastAddress = _currentHotCityInfo.areaName;
    
    if(![SharedUserDefault sharedInstance].getMyCurrentAddress)
    {
        [[SharedUserDefault sharedInstance] setMyCurrentAddress:_currentHotCityInfo.areaName];
    }
    
    if(![SharedUserDefault sharedInstance].getMyCurrentCity)
    {
        [[SharedUserDefault sharedInstance] setMyCurrentCity:_currentHotCityInfo.areaName];
    }
    
    if(![SharedUserDefault sharedInstance].getMyLatitude || ![SharedUserDefault sharedInstance].getMyLongitude)
    {
        [[SharedUserDefault sharedInstance] setMyLatitudeAndLongitude:_currentHotCityInfo.latitude andLat:_currentHotCityInfo.longitude];
    }
}
-(void)saveCurrentHotCityArr:(NSMutableArray *)arr andOpenCitArr:(NSMutableArray *)openArr
{
    NSLog(@" publicData saveCurrentHotCityArr");
    [[SharedUserDefault sharedInstance] setCurrentCityArr:arr];
    _currentHotCityArray=arr;
    _currentOpenCityArray=openArr;
    [[SharedUserDefault sharedInstance] setCurrentOpenCityArr:openArr];
}
- (void)setMyMsgCountInfo
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations)
    {
        unreadCount += conversation.unreadMessagesCount;
    }
    
    [WGPublicData sharedInstance].myMsgCount = unreadCount;
}

- (void)setGPSCityInfo
{
    NSString *curCity = [SharedUserDefault sharedInstance].getMyCurrentCity;
    NSLog(@"从本地NSuserdafault里取的city是%@",curCity);
   // if ((id)curCity!=[NSNull null]) {
   
    if(_currentHotCityArray && _currentHotCityArray.count)
    {
        for(HotCityElement *cityElement in _currentHotCityArray)
        {
            if (cityElement!=nil) {
                NSRange range = [cityElement.areaName rangeOfString:curCity];
                if (range.length >0)
                {
                    _currentGPSCityInfo = cityElement;
                    break;
                }
            }
        }
    }
    else{
    
        NSLog(@"本地没有取到GPSCityInfo!");
    }
   // }
}
*/
- (void)cancelBannerTimer
{
    if([WGPublicData sharedInstance].bannerTimer)
    {
        [[WGPublicData sharedInstance].bannerTimer invalidate];
        [WGPublicData sharedInstance].bannerTimer = nil;
    }
}

- (void)clearLoginInfo
{
//    if([SharedUserDefault sharedInstance].isUpgrade == nil || ![[SharedUserDefault sharedInstance].isUpgrade compare:@"Y"])
//    {
//        [[SharedUserDefault sharedInstance] setLoginState:@"N"];
//        UserElement *userElement = [UserElement new];
//        [[SharedUserDefault sharedInstance] setUserInfo:[NSKeyedArchiver archivedDataWithRootObject:userElement]];
//        [[SharedUserDefault sharedInstance] setUpgrade:@"N"];
//    }
}

@end
