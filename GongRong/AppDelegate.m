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
#import "SharedUserDefault.h"
#import "HomeVC.h"
#import "HomeWKWebVC.h"
#import "ClassifyVC.h"
#import "baseWkWebVC.h"
#import "UserLoadViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

#pragma mark 极光
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif



@interface AppDelegate ()<JPUSHRegisterDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;
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
    
    HomeVC *Home1=[[HomeVC alloc]init];
    
    
    ClassifyVC *vc2=[[ClassifyVC alloc]init];
    NSString *urlStr =@"http://192.168.1.102:8888/#/HomePage";
   
//    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                                                    (CFStringRef)urlStr,
//                                                                                                    (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
//                                                                                                    NULL,
//                                                                                                    kCFStringEncodingUTF8));
    
    [vc1 setUrl:urlStr];
    vc1.view.backgroundColor=[UIColor redColor];
    //[vc2 setUrl:@"http://www.baidu.com"];
    [vc2 setUrl:@"http://192.168.1.102:8888/#/Classify"];
    vc2.view.backgroundColor=[UIColor greenColor];
    baseWkWebVC *vc3=[[baseWkWebVC alloc]init];
    [vc3 setUrl:@"http://192.168.1.102:8888/#/Shopping"];
    vc3.view.backgroundColor=[UIColor blueColor];
    baseWkWebVC *vc4=[[baseWkWebVC alloc]init];
    [vc4 setUrl:@"http://192.168.1.102:8888/#/Mine"];
    // [vc4 setUrl:@"http://192.168.1.109:8888/#/Login"];
    vc4.view.backgroundColor=[UIColor yellowColor];
    /*
    HomeVC *vc2=[[HomeVC alloc] init];
    ViewController *vc3=[[ViewController alloc]init];
     */
  //  UserLoadViewController *vc4=[[UserLoadViewController alloc]init];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:vc1];
    nav1.navigationBarHidden=YES;
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:vc2];
    nav2.navigationBarHidden=YES;
    
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:vc3];
    nav3.navigationBarHidden=YES;
    
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:vc4];
    nav4.navigationBarHidden=YES;
    
    //[tBC setViewControllers:[NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil]];
    NSLog(@"VC1:%@VC2:%@VC3:%@VC4:%@",vc1,vc2,vc3,vc4);
   
   // self.window.backgroundColor=[UIColor redColor];
    MainTabBarController *tBC=[[MainTabBarController alloc]initWithViewControllers:[NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil]];
    self.window.rootViewController=tBC;
    [self.window makeKeyAndVisible];
    
    GDMapManager *manager=[GDMapManager shareInstance];
    [manager getLocation];
   [WGPublicData sharedInstance].roottabBarVC=tBC ;
//    [[WGLocationManager sharedInstance] startBMKMap];
//    
//    [[WGLocationManager sharedInstance] startLocationByType:YES];
//    
   // [ConUtils createFilterListPlistFile];
   // [[WGPublicData sharedInstance] clearLoginInfo];
    
#pragma mark 初始化IQKeyboardManager
    [self setUpIQKeyBordManager];
#pragma mark 极光初始化
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
#pragma mark 首次启动引导
    [self  cheackFirstStart];
  
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
-(void)cheackFirstStart
{
    if ([[SharedUserDefault sharedInstance] isFirstStartApp] == nil ||
        [[[SharedUserDefault sharedInstance] isFirstStartApp] isEqualToString:@"Y"])
    {
       
        _array = [NSArray arrayWithObjects:@"guide640x1280_01",@"guide640x1280_02",@"guide640x1280_03",nil];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scrollView.backgroundColor=[UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 3, ScreenHeight);
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.window addSubview:_scrollView];
       
        [self initScrollViewContent];
        
    }
}

- (void)initScrollViewContent
{
    for (int i=0; i<3; i++)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight)];
        img.userInteractionEnabled = YES;
        [img setBackgroundColor:[UIColor clearColor]];
        NSString *path = [[NSBundle mainBundle] pathForResource:[_array objectAtIndex:i] ofType:@"jpg"];
        [img setImage:[UIImage imageWithContentsOfFile:path]];
        // img.image=[UIImage imageNamed:[_array objectAtIndex:i]];
        img.contentMode=UIViewContentModeScaleAspectFill;
        img.clipsToBounds=YES;
        [img setUserInteractionEnabled:YES];
        [_scrollView addSubview:img];
        if (i == 2) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-143)/2, ScreenHeight-85-34, 143, 34)];
            label.font=[UIFont systemFontOfSize:18];
            label.backgroundColor=UIColorWithHex(0xfa7b14);
            label.text=@"立即体验";
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
            [img addSubview:label];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [img addGestureRecognizer:tapGesture];
        }
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((ScreenWidth-100)/2, ScreenHeight-80, 100, 30)];
    //页数
    _pageControl.currentPage=0;
    _pageControl.numberOfPages = 3;
    
    // [pageControl addTarget:self action:@selector(dealPageControl:) forControlEvents:UIControlEventValueChanged];
    
    [self.window addSubview:_pageControl];
//    [self.view bringSubviewToFront:_scrollView];
//    [self.view bringSubviewToFront:_pageControl];
    
}
-(void)dealPageControl:(UIPageControl *)pc
{
    double x = ScreenWidth * pc.currentPage;
    _scrollView.contentOffset = CGPointMake(x, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)ScrollView
{
    // [super scrollViewDidScroll:ScrollView];
    
    if (ScrollView == _scrollView) {
        float index =_scrollView.contentOffset.x / ScreenWidth;
        _pageControl.currentPage = (NSInteger)(index+0.5);
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture
{
    [[SharedUserDefault sharedInstance] setFirstStartApp:@"N"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [_scrollView removeFromSuperview];
    [_pageControl removeFromSuperview];
    _scrollView = nil;
    _pageControl = nil;
  
}
-(void)setUpIQKeyBordManager
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
 
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    if ([url.absoluteString rangeOfString:@"pay"].location == NSNotFound) {
       // [JSHAREService handleOpenUrl:url];
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kAliPayCallBack" object:resultDic];
        }];
        return YES;
    }
    return [WXApi handleOpenURL:url delegate:self];
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
