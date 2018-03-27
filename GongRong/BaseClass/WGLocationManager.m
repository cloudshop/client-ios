//
//  WGLocationManager.m
//  Booking
//
//  Created by wihan on 14-10-28.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import "WGLocationManager.h"
#import "GongRong.PCH"
//#import "BMapKit.h"
//#import "SharedUserDefault.h"
//#import "HotCityElement.h"

@interface WGLocationManager ()

//@property (nonatomic, strong) BMKMapManager *manager;
@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;

@end

@implementation WGLocationManager

#pragma mark Public Function

+ (WGLocationManager *)sharedInstance
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
//        SharedUserDefault *shared = [SharedUserDefault sharedInstance];
//
//        _longitude = [[shared getLongitude] floatValue];
//        _latitude = [[shared getLatitude] floatValue];
//        _lastCoordinate = CLLocationCoordinate2DMake(_longitude,_latitude);
//        _lastCity = [shared getCityName];
//        _lastAddress=[shared getCurrentAddress];
//        _needUpdateGeoOnly = FALSE;
//        _needUpdateGeoAlways = FALSE;
//        _mapMoveFlag = FALSE;
//        _locationServeceEnbal=YES;
//        _mapMoveAddress = [shared getCurrentAddress];
    }
    return self;
}
-(void)dealloc
{

}
- (void)getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void)getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock
{
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void)getAddress:(NSStringBlock)addressBlock
{
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void)getCity:(NSStringBlock)cityBlock
{
    self.cityBlock = [cityBlock copy];
    [self startLocation];
}

- (void)getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock
{
    self.cityBlock = [cityBlock copy];
    self.errorBlock = [errorBlock copy];
    [self startLocation];
}

-(void)startLocation
{
    /*
    NSLog(@"+++startLocation+++");
    if(!_locService)
    {
        NSLog(@"---startLocation+++");
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self ;
        [_locService startUserLocationService];
    }
    else{
       
        _locService.delegate = self ;
        [_locService startUserLocationService];

    }
    
    if(!_search)
    {
         NSLog(@"_search is not nil");
        _search = [[BMKGeoCodeSearch alloc] init];
        _search.delegate = self ;
    }
    */
    _needUpdateCurrentAdr = YES;
    _needUpdateGeoEveryTime = YES;
}

-(void)stopLocation
{
    
//    [_locService stopUserLocationService];
//    _locService.delegate = nil;
//    _locService = nil;
//    _search.delegate = nil;
//    _search = nil;
}

- (void)startLocationByType:(BOOL)type
{
    self.needStopRelocation = type;
    if(type)
    {
        [self startLocation];
    }
}

#pragma mark -BMKLocationService Delegate
/*
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
  //  NSLog(@"!!didUpdateUserHeading");
    //Abnormal handle
    if(!userLocation.location.coordinate.latitude && !userLocation.location.coordinate.latitude)
    {
        //NSLog(@"!userLocation.location.coordinate.latitude");
        return;
    }
    
    //For update coordinate
    _lastCoordinate = userLocation.location.coordinate;
    SharedUserDefault *shared = [SharedUserDefault sharedInstance];
    
    [shared setLatitudeAndLongitude:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] andLat:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude]];
    _latitude = userLocation.location.coordinate.latitude;
    _longitude = userLocation.location.coordinate.longitude;
    
    //For update GEO
    if(_needUpdateGeoOnly)
    {
       
        BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
        reversePotion.reverseGeoPoint = userLocation.location.coordinate ;
        [self.search reverseGeoCode:reversePotion];
        _needUpdateGeoOnly = FALSE;
        return;
    }
    
    if(_needUpdateGeoEveryTime || _needUpdateGeoAlways)
    {
       
        BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
        reversePotion.reverseGeoPoint = userLocation.location.coordinate ;
        
       BOOL result= [self.search reverseGeoCode:reversePotion];
        NSLog(@"reverseGeoCode result%d",result);
        _needUpdateGeoEveryTime = FALSE;
    }
   
    
    ///////////////
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LocationFinished object:nil];
 
}
*/
- (void)didFailToLocateUserWithError:(NSError *)error
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"微歌无法确认您当前的位置,请到设置-隐私-定位服务-开启微歌定位" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
//    [alert show];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"LOCATIONFAILED" object:nil];
    _locationServeceEnbal=NO;
}

#pragma mark -BMKGeocodeSearch Delegate
/*
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    NSLog(@"!!onGetReverseGeoCodeResult%@",result.addressDetail.city);
    //保存当前城市名称
    [[SharedUserDefault sharedInstance] setCityName:result.addressDetail.city];
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
    [[SharedUserDefault sharedInstance] setCurrentAddress:address];
    _lastCity = result.addressDetail.city;
    _lastAddress = address;
    /*
     (HotCityElement *)cityInfo
     {
     _currentHotCityInfo = cityInfo;
     if(cityInfo)
     {
     NSMutableDictionary *cityDic = [NSMutableDictionary new];
     [cityDic setObject:cityInfo.scale forKey:@"scale"];
     [cityDic setObject:cityInfo.areaName forKey:@"areaName"];
     [cityDic setObject:cityInfo.longitude forKey:@"longitude"];
     [cityDic setObject:cityInfo.latitude forKey:@"latitude"];
     [cityDic setObject:cityInfo.baiduId forKey:@"baiduId"];
     [cityDic setObject:cityInfo.areaId forKey:@"areaId"];
     [cityDic setObject:cityInfo.areaCode forKey:@"areaCode"];
     
     [[SharedUserDefault sharedInstance] setHotCityInfo:cityDic];
    */
    /*
    //For map
    if(_mapMoveFlag)
    {
        _mapMoveAddress = address;
        _mapMoveFlag = FALSE;
    }
    
    if(_needUpdateCurrentAdr)
    {
        NSLog(@"objectForKey:MYCURCITY");
        [[SharedUserDefault sharedInstance] setMyCurrentAddress:address];
        [[SharedUserDefault sharedInstance] setMyCurrentCity:result.addressDetail.city];
        [[SharedUserDefault sharedInstance] setMyLatitudeAndLongitude:[NSString stringWithFormat:@"%f",result.location.latitude] andLat:[NSString stringWithFormat:@"%f",result.location.longitude]];
        _needUpdateCurrentAdr = YES;
    }
    
    //Location update
//    NSMutableDictionary *locationDic = [NSMutableDictionary new];
//    [locationDic setObject:[NSString stringWithFormat:@"%f",result.location.latitude] forKey:LATITUDE];
//    [locationDic setObject:[NSString stringWithFormat:@"%f",result.location.longitude] forKey:LONGITUDE];
//    [locationDic setObject:result.addressDetail forKey:ADRRDETAIL];
    
    //Stop Location and later will update location manually
    if(_needStopRelocation)
    {
       
        [self stopLocation];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_UPDATE
                                                        object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:FIRST_UPDATE_BUSINESS_LIST
//                                                        object:nil];
    
    //Set get function
    if (_cityBlock) {
        _cityBlock(_lastCity);
        _cityBlock = nil;
    }
    
    if (_locationBlock) {
        _locationBlock(_lastCoordinate);
        _locationBlock = nil;
    }
    
    if (_addressBlock) {
        _addressBlock(_lastAddress);
        _addressBlock = nil;
    }
    
    NSLog(@"+++latitude = %f; longitude = %f, address = %@", result.location.latitude, result.location.longitude, address);
     
}
*/
//Start baidu map in didFinishLaunchingWithOptions function
- (void)startBMKMap
{
    /*
    self.manager = [[BMKMapManager alloc]init];
    //正式 KhiWxjEgZt1BUiwKqGRs3MkL
    BOOL ret = [self.manager start:@"KhiWxjEgZt1BUiwKqGRs3MkL"  generalDelegate:nil];
    
   // BOOL ret = [self.manager start:@"ChrIBwiRtg3LoTe5cH8f8lv5"  generalDelegate:nil]; //测试 ChrIBwiRtg3LoTe5cH8f8lv5
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
     */
}

//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
//{
//    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//}

@end
