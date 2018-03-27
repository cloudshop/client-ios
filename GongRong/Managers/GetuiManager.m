//
//  GetuiManager.m
//  Booking
//
//  Created by wihan on 14-10-15.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import "GetuiManager.h"

#if GR_GETUI

@interface GetuiManager ()

@end

@implementation GetuiManager

#pragma mark Public Function

+ (GetuiManager *)sharedInstance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{instance = self.new;});
    return instance;
}

- (void)registerRemoteNotification
{
    /*
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] intValue]>7)
    {
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    }
    else
    {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
     */
    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else {      // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
      //  UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // 注册远程通知 -根据远程通知类型
      //  [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret target:(id)target
{
    if (!_gexinPusher)
    {
        _sdkStatus = SdkStatusStoped;
        self.appID = appID;
        self.appKey = appKey;
        self.appSecret = appSecret;
        _clientId = nil;
        
       // NSError *err = nil;
        _gexinPusher =[[GeTuiSdk alloc] init];
        [GeTuiSdk startSdkWithAppId:_appID appKey:_appKey appSecret:_appSecret delegate:target];
        _clientId=[GeTuiSdk clientId];
       
        if (!_gexinPusher) {
            
        } else {
           
            _sdkStatus = SdkStatusStarting;
        }
    }
}

- (void)stopSdk
{
    if (_gexinPusher)
    {
       // [_gexinPusher destroy];
        _gexinPusher = nil;
        _clientId = nil;
        _sdkStatus = SdkStatusStoped;
    }
}

- (BOOL)checkSdkInstance
{
    if (!_gexinPusher) {
        return NO;
    }
    return YES;
}

- (void)setDeviceToken:(NSString *)aToken
{
    if (![self checkSdkInstance]) {
        return;
    }
    _deviceToken = [aToken copy];
    [GeTuiSdk registerDeviceToken:aToken];
}

- (BOOL)setTags:(NSArray *)aTags error:(NSError **)error
{
    if (![self checkSdkInstance]) {
        return NO;
    }
    
    return [GeTuiSdk setTags:aTags];
}

@end

#endif //GR_GETUI
