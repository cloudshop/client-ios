//
//  GDMapManager.m
//  GongRongCredits
//
//  Created by 王旭 on 2018/3/10.
//

#import "GDMapManager.h"
//#import <AMapSearchKit/AMapSearchKit.h>
//#import <AMapSearch/AMapSearchAPI.h>


@interface GDMapManager ()<AMapSearchDelegate>
@property (nonatomic,strong) AMapGeoPoint *_Point;
@property (nonatomic,strong)AMapSearchAPI *search;
@property (nonatomic,strong)AMapServices *services;
@end

@implementation GDMapManager
static GDMapManager * manager;

+(instancetype)shareInstance
{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[GDMapManager  alloc] init];
    });
    return manager;
}
-(instancetype)init
{
    if (self==[super init]) {
       
        self.services = [AMapServices sharedServices];
        self.services.apiKey = @"076b44ad71b2b10a38afdf4eda72ace8";
        self.services.enableHTTPS=NO;
        [self getLocation];
    }
    return self;
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    if (response.count == 0)
    {
        return;
    }
    
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(newCityLocation:)]) {
        [self.delegate newCityLocation:nil];
    }
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
}
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    NSDictionary *dic;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(newCityLocation:)]) {
        if (response.geocodes.count == 0)
        {
            [self.delegate newCityLocation:nil];
        }
        else
        {
            AMapGeocode *code=response.geocodes[0];
            dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",code.location.longitude],@"longitude",[NSString stringWithFormat:@"%f",code.location.latitude],@"latitude",code.district,@"cityName", nil];
            
        }
        //解析response获取地理信息，具体解析见 Demo
         [self.delegate newCityLocation:dic];
    }
   
}

-(void)getLoactionWithCityName:(NSString *)cityName
{
 
    self.search=  [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = cityName;
   
    //self.search.cityLimit=YES;
    [self.search AMapGeocodeSearch:geo];
    
    return ;
    
}
-(void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationmanager) {
            _locationmanager = [[CLLocationManager alloc]init];
        }
       
        _locationmanager.delegate = self;
         //_currentCity = [NSString new];
        
       // [_locationmanager requestAlwaysAuthorization];
       
      //  [_locationmanager requestWhenInUseAuthorization];
        if ([[[UIDevice currentDevice]systemVersion]doubleValue] >8.0){
            [_locationmanager requestWhenInUseAuthorization];
        }
//        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//            _locationmanager.allowsBackgroundLocationUpdates =YES;
//        }
        
        //设置寻址精度
        _locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationmanager.distanceFilter = 5.0;
        [_locationmanager startUpdatingLocation];
    }
}

//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(!self.strlongitude||self.strlongitude.length<1){
    //设置提示提醒用户打开定位服务
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        UIViewController *VC=[WGPublicData sharedInstance].currentViewController;
        [VC presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [_locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    self.strlongitude=[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    self.strlatitude=[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    //反地理编码
   // NSString *tempcity=@"";
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
           self.currentCity = [NSString stringWithFormat:@"%@",placeMark.locality];
            if (!self.currentCity) {
                self.currentCity = @"无法定位";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
            NSLog(@"%@",self.currentCity);//当前的城市
           
        }
    }];
    
    
}

@end
