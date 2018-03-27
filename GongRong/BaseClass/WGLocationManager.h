//
//  WGLocationManager.h
//  Booking
//
//  Created by wihan on 14-10-28.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//#import "BMapKit.h"

#define  WGLastLongitude @"WGLastLongitude"
#define  WGLastLatitude  @"WGLastLatitude"
#define  WGLastCity      @"WGLastCity"
#define  WGLastAddress   @"WGLastAddress"

typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock)(NSError *error);
typedef void (^NSStringBlock)(NSString *cityString);
typedef void (^NSStringBlock)(NSString *addressString);

@interface WGLocationManager : NSObject
//<
//  //  MKMapViewDelegate,
//  //  BMKGeoCodeSearchDelegate,
//  //  BMKLocationServiceDelegate
//>

@property (nonatomic) CLLocationCoordinate2D lastCoordinate;
//@property (nonatomic, strong) BMKLocationService *locService;
//@property (nonatomic, strong) BMKGeoCodeSearch *search;
//@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSString *lastCity;
@property (nonatomic, strong) NSString *lastAddress;
@property (nonatomic, strong) NSString *currentAddress;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, assign) BOOL needStopRelocation;
@property (nonatomic, assign) BOOL needUpdateGeoOnly;//High priority and need to set before start location
@property (nonatomic,assign)BOOL locationServeceEnbal;
@property (nonatomic, assign) BOOL needUpdateGeoEveryTime;
@property (nonatomic, assign) BOOL needUpdateGeoAlways;
@property (nonatomic, assign) BOOL needUpdateCurrentAdr;
@property (assign) BOOL mapMoveFlag;
@property (strong) NSString *mapMoveAddress;

+ (WGLocationManager *)sharedInstance;

//For BMKMap
- (void)startBMKMap;
- (void)startLocation;
- (void)stopLocation;
- (void)startLocationByType:(BOOL)type;

//For System Normal
- (void)getLocationCoordinate:(LocationBlock) locaiontBlock ;
- (void)getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock;
- (void)getAddress:(NSStringBlock)addressBlock;
- (void)getCity:(NSStringBlock)cityBlock;
- (void)getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock;

@end
