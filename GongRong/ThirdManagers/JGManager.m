//
//  JGManager.m
//  GongRongCredits
//
//  Created by 王旭 on 2018/3/13.
//

#import "JGManager.h"
#import "GongRong.pch"

@implementation JGManager

+(instancetype)shareInstance
{
    static JGManager*manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[JGManager alloc]init];
    });
    return manager;
}
-(instancetype)init
{
   
        
    if (self==[super init]) {
        
    
    #pragma mark 极光初始化
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            // 可以添加自定义categories
            // NSSet<UNNotificationCategory *> *categories for iOS10 or later
            // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
        }
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
        
        JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
        config.appKey = @"bd5ea486e324b235c89b6340";
        //    config.SinaWeiboAppKey = @"374535501";
        //    config.SinaWeiboAppSecret = @"baccd12c166f1df96736b51ffbf600a2";
        //    config.SinaRedirectUri = @"https://www.jiguang.cn";
        //    config.QQAppId = @"1105864531";
        //    config.QQAppKey = @"glFYjkHQGSOCJHMC";
        config.WeChatAppId = @"wxf177c6755716fa32";
        config.WeChatAppSecret = @"8ced9a149b6c5b79e2bcb682092256e2";
        //    config.FacebookAppID = @"1847959632183996";
        //    config.FacebookDisplayName = @"JShareDemo";
        
        [JSHAREService setupWithConfig:config];
        #if GR_DEBUG
        [JSHAREService setDebug:YES];
        #else
         [JSHAREService setDebug:NO];
        #endif
    }
    return self;
}
-(NSString *)registrationID
{
    return [JPUSHService registrationID];
}
/*
 * @brief handle UserNotifications.framework [willPresentNotification:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param notification 前台得到的的通知对象
 * @param completionHandler 该callback中的options 请使用UNNotificationPresentationOptions
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler
{
    
}
/*
 * @brief handle UserNotifications.framework [didReceiveNotificationResponse:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param response 通知响应对象
 * @param completionHandler
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    
}
@end
