//
//  GetuiManager.h
//  Booking
//
//  Created by wihan on 14-10-15.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GongRong.pch"

//#import <GTSDK/GeTuiSdk.h>

#if GR_GETUI

#if ZY_DEBUG
//Demo
#define kAppId           @"G5JIitEdgA8oobZGfMm3Y2"
#define kAppKey          @"f4UIc9BRhr8YMKbfWSFyk9"
#define kAppSecret       @"MFatnoxpBm9FVvjm5oewd3"
#else
//Distribution
#define kAppId           @"NNOrY5Btbo908lvAiSX9M4"
#define kAppKey          @"glGnSq3fMG8XMWtcXszwB1"
#define kAppSecret       @"MFatnoxpBm9FVvjm5oewd3"
#endif

#if WG_YOUMENG_DEBUG
//TEST
#define UMAppKey @"54995231fd98c560160004a6"
#else
//DISTRIBUTION
#define UMAppKey @"5451b829fd98c5627a00200b"
#endif

#if TY_HUANXIN_DEBUG
//TEST
#define HUANXIN_APNSNAME @"develop_push"
#define HUANXIN_APPID   @"tuyou#leifengtest"
#else
//DISTRIBUTION
#define HUANXIN_APNSNAME @"distribution"
#define HUANXIN_APPID   @"tuyou#tuyou"
#endif


//typedef enum {
//    SdkStatusStoped,
//    SdkStatusStarting,
//    SdkStatusStarted
//} SdkStatus;

@interface GetuiManager : NSObject //<GexinSdkDelegate>

@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *appID;
@property (strong, nonatomic) NSString *deviceToken;
//@property (strong, nonatomic) GeTuiSdk *gexinPusher;
@property (strong, nonatomic) NSString *clientId;
//@property (assign, nonatomic) SdkStatus sdkStatus;
@property (assign, nonatomic) int lastPayloadIndex;
@property (strong, nonatomic) NSString *payloadId;
@property (strong, nonatomic) NSDictionary *dataDic;

+ (GetuiManager *)sharedInstance;

- (void)registerRemoteNotification;
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret target:(id)target;
- (void)stopSdk;
- (void)setDeviceToken:(NSString *)aToken;
- (BOOL)setTags:(NSArray *)aTag error:(NSError **)error;

@end

#endif //GR_GETUI
