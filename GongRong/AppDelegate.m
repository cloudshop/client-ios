//
//  AppDelegate.m
//  GongRong
//
//  Created by 王旭 on 2018/1/5.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainTabBarController.h"
#import "WGPublicData.h"
#import "WGLocationManager.h"
#import "HomeVC.h"
#import "HomeWKWebVC.h"
#import "ClassifyVC.h"
#import "baseWkWebVC.h"
#import "UserLoadViewController.h"

#pragma mark 极光
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif



@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:Rect(0, 0, ScreenWidth, ScreenHeight)];
    
    UIInterfaceOrientation orientation = UIInterfaceOrientationPortrait;
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation];
    
    NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    if(url)
    {
        
    }
    NSString *bundleId = [launchOptions objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
    if(bundleId)
    {
        
    }
    UILocalNotification * localNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotify)
    {
        
    }
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo)
    {
    }
    
    HomeWKWebVC *vc1=[[HomeWKWebVC alloc]init];
    
    ClassifyVC *vc2=[[ClassifyVC alloc]init];
    [vc1 setUrl:@"http://192.168.1.102:8080/#/HomePage"];
    [vc2 setUrl:@"http://www.baidu.com"];
    /*
    HomeVC *vc2=[[HomeVC alloc] init];
    ViewController *vc3=[[ViewController alloc]init];
     */
    UserLoadViewController *vc4=[[UserLoadViewController alloc]init];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:vc1];
    nav1.navigationBarHidden=YES;
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:vc2];
    nav2.navigationBarHidden=YES;
    /*
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:vc3];
    nav3.navigationBarHidden=YES;
     */
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:vc4];
    nav4.navigationBarHidden=YES;
    
    //[tBC setViewControllers:[NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil]];
    
   
   // self.window.backgroundColor=[UIColor redColor];
    MainTabBarController *tBC=[[MainTabBarController alloc]initWithViewControllers:[NSArray arrayWithObjects:nav1,nav2,nav1,nav4, nil]];
    self.window.rootViewController=tBC;
    [self.window makeKeyAndVisible];
//    [[WGPublicData sharedInstance] initCityAndlocationInfo];
//    [[WGLocationManager sharedInstance] startBMKMap];
//    
//    [[WGLocationManager sharedInstance] startLocationByType:YES];
//    
   // [ConUtils createFilterListPlistFile];
   // [[WGPublicData sharedInstance] clearLoginInfo];
    
    
#pragma mark 极光初始化
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
   
    
    
  
    //建立相册文件
    NSString *imageDocPath = [FILE_PATH stringByAppendingPathComponent:@"MinePhoto"];
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //注册系统声音
//    NSString *path = [[NSBundle mainBundle] resourcePath];
//    NSString *filePath = [NSString stringWithFormat:@"%@%@",path,@"/order_sound.caf"];
//    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &WGsoundId);
//
    //公共参数请求
//    [HttpRequestComm getCommonparamsList:self];
    
    NSDictionary *userInfoTmp = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfoTmp != nil)
    {
        NSString *payload = (NSString *)[userInfo objectForKey:@"payload"];
        
        if(payload.length > 0)
        {
            NSError *error;
            NSDictionary *dicPlayload = [[NSDictionary alloc] initWithDictionary:(NSDictionary*)[NSJSONSerialization JSONObjectWithData:[payload dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error]];
            /*
             UIView *testView=[[UIView alloc]initWithFrame:Rect(0, -50, ScreenWidth-120, 44)];
             testView.backgroundColor=[UIColor greenColor];
             UILabel *title=[[UILabel alloc]initWithFrame:Rect(50, 10, 200, 25)];
             title.text=@"didFinishLaunchingWithOptions";
             title.font=[UIFont systemFontOfSize:12];
             [testView addSubview:title];
             [self.window addSubview:testView];
             self.window.top+=400;
             
             [self handleRemoteNotification:dicPlayload isShowAlert:NO];
             */
            
        }
    }
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
