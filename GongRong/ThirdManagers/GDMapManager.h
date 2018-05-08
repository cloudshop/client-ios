//
//  GDMapManager.h
//  GongRongCredits
//
//  Created by 王旭 on 2018/3/10.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface GDMapManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *locationmanager;//定位服务
@property (nonatomic,strong)NSString * currentCity;//当前城市
@property (nonatomic,strong)NSString * strlatitude;//经度
@property (nonatomic,strong)NSString * strlongitude;//纬度

-(void)getLocation;
+(instancetype)shareInstance;
-(NSString *)getLoactionWithCityName:(NSString *)cityName;
@end
