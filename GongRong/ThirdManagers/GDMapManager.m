//
//  GDMapManager.m
//  GongRongCredits
//
//  Created by 王旭 on 2018/3/10.
//

#import "GDMapManager.h"



@interface GDMapManager ()

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
    if (self=[super init]) {
        
        [self getLocation];
    }
    return self;
}
-(void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationmanager) {
            _locationmanager = [[CLLocationManager alloc]init];
        }
       
        _locationmanager.delegate = self;
       // [_locationmanager requestAlwaysAuthorization];
        _currentCity = [NSString new];
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
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    UIViewController *VC=[WGPublicData sharedInstance].currentViewController;
    [VC presentViewController:alert animated:YES completion:nil];
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
    
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            _currentCity = placeMark.locality;
            if (!_currentCity) {
                _currentCity = @"无法定位当前城市";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
            NSLog(@"%@",_currentCity);//当前的城市
           
            
        }
    }];
    
}
@end
