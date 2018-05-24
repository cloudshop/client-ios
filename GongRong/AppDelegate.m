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
#import "GongRong.pch"
#import "HomeVC.h"
#import "HomeWKWebVC.h"
#import "ClassifyVC.h"
#import "baseWkWebVC.h"
#import "UserLoadViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "HttpBaseRequest.h"
#pragma mark 极光
// 引入JPush功能所需头文件
//#import "JPUSHService.h"
//#import "JSHAREService.h"
#import "JGManager.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif



@interface AppDelegate ()<UIScrollViewDelegate,HttpRequestCommDelegate,WXApiDelegate>
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
   
#pragma 由推送启动时 做处理
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
    
    //直接测试支付扫描用 正式用不到
    HomeVC *Home1=[[HomeVC alloc]init];
    
    baseWkWebVC *vc2=[[baseWkWebVC alloc]init];
    NSString *urlStr =[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/homepage/"];
   // NSString *urlStr =[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/#/HomePage"];
   // NSString *urlStr= @"http://cloud.eyun.online:8888/simpleregister/storage.html";
    [vc1 setUrl:urlStr];
   // vc1.view.backgroundColor=[UIColor redColor];
    
  
    [vc2 setUrl:[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/#/Classify"]];
   // [vc2 setUrl:@"http://www.baidu.com"];
   // vc2.view.backgroundColor=[UIColor greenColor];
    
    baseWkWebVC *vc3=[[baseWkWebVC alloc]init];
    [vc3 setUrl:[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/#/Shopping"]];
   // [vc3 setUrl:@"http://192.168.1.110:8888/#/Shopping"];
   // vc3.view.backgroundColor=[UIColor blueColor];
    baseWkWebVC *vc4=[[baseWkWebVC alloc]init];
    [vc4 setUrl:[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/#/Mine"]];
   // [vc4 setUrl:[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/#/Login"]];
   // vc4.view.backgroundColor=[UIColor yellowColor];
   
      
  //  UserLoadViewController *vc4=[[UserLoadViewController alloc]init];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:vc1];
    nav1.navigationBarHidden=YES;
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:vc2];
    nav2.navigationBarHidden=YES;
    
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:vc3];
    nav3.navigationBarHidden=YES;
    
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:vc4];
    nav4.navigationBarHidden=YES;
    
    MainTabBarController *tBC=[[MainTabBarController alloc]initWithViewControllers:[NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil]];
    self.window.rootViewController=tBC;
    [self.window makeKeyAndVisible];
    
    GDMapManager *manager=[GDMapManager shareInstance];
    [manager getLocation];
   [WGPublicData sharedInstance].roottabBarVC=tBC ;

    
#pragma mark 初始化IQKeyboardManager
    [self setUpIQKeyBordManager];

    
#pragma mark 极光推送 分享
    [self registerRemoteNotification];
    [JGManager shareInstance];

    [WXApi registerApp:@"wxf177c6755716fa32" enableMTA:YES];
    
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
    
#pragma 推送测试
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
//自定义方法
- (void)registerRemoteNotification
{
#if !TARGET_IPHONE_SIMULATOR
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    
    // 判读系统版本是否是“iOS 8.0”以上
    if (IOS8) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else if (IOS8_10)
    {
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    else if (IOS10)
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                [[UIApplication sharedApplication] registerForRemoteNotifications]; // required to get the app to do anything at all about push notifications
                LRLog(@"succeeded!");
            }
        }];
    }
    else {      // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // 注册远程通知 -根据远程通知类型
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
#endif
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
        [JSHAREService handleOpenUrl:url];
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
-(void) onResp:(BaseResp*)resp
{
     NSString *strMsg = [NSString stringWithFormat:@"支付结果"];
    NSLog(@"tbrefds");
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"success";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
           // [[NSNotificationCenter defaultCenter] postNotificationName:@"payOrderSucess" object:nil];
            break;
        case WXErrCodeUserCancel:
            strMsg = @"cancel";
            break;
        case WXErrCodeSentFail:
            strMsg = @"failed";
            break;
        case WXErrCodeAuthDeny:
            strMsg = @"failed";
            break;
        case WXErrCodeUnsupport:
            strMsg = @"failed";
            break;
        default:
            strMsg = @"failed";
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kWechatPayCallBack" object:strMsg];
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //[3-EXT]:如果APNS注册失败，通知个推服务器
    LRLog(@"didFailToRegisterForRemoteNotificationsWithError===%@",[error localizedDescription]);
    

    
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
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"version"];
    HttpBaseRequest *req=[[HttpBaseRequest alloc] initWithDelegate:self];
    
    [req initGetRequestComm:dic withURL:VERSION_CHECK operationTag:VERSIONCHECK];
    
}
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *)error
{
    
}
-(void)httpRequestSuccessComm:(NSInteger)tagId withInParams:(id)inParam
{
    BaseResponse *res=[[BaseResponse alloc]init];
    [res setHeadData:inParam];
    switch (tagId) {
            
        case VERSIONCHECK:{
            if (res.code == 0) {
                
            }
        }break;
            default:
            break;
    }
}
#pragma 强制更新 或者用户选择升级后 跳到AppStore中更新
- (void)gotoVersionUpdate
{
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/wei-ge/id1099079540?mt=8"/*_versionCheckElement.downLoadUrl*/]])
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/wei-ge/id1099079540?mt=8"/*_versionCheckElement.downLoadUrl*/]];
//    }
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
