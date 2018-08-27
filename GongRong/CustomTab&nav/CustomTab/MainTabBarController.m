//
//  MainTabBarController.m
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import "MainTabBarController.h"


#import "WGPublicData.h"
#import "LoginViewController.h"


#import "CoderReader.h"
//#import "WGJumpUrlHandle.h"
//#import "WGTabbarItemBT.h"
#import "baseWkWebVC.h"




@interface MainTabBarController ()<TabBarDelegate>
{
    UIView *bgView;
    UIView *bgView1;
    
}
@property (nonatomic) Reachability *internetReachability;
@end

@implementation MainTabBarController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(id)initWithViewControllers:(NSArray *)arr
{
    self=[super init];
    if (self) {
        [self setViewControllers:arr];
        //删除现有的tabBar
        CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
        
        // [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条
        
        //测试添加自己的视图
        NSArray *iconArr=[NSArray arrayWithObjects:@"Tab1_Normal",@"Tab2_Normal",@"Tab3_Normal",@"Tab4_Normal", nil];
        NSArray *selectediconArr=[NSArray arrayWithObjects:@"Tab1_Selected",@"Tab2_Selected",@"Tab3_Selected",@"Tab4_Selected", nil];
        NSArray *titleArr=@[@"首页",@"分类",@"购物车",@"我的"];
        
        self.myView = [[CustomTabBar alloc] initWithNormalIMG:iconArr AndSelectedIMG:selectediconArr AndRect:rect AndtitleArr:titleArr]; //设置代理必须改掉前面的类型,不能用UIView
        self.myView.delegate = self; //设置代理
        self.myView.tag=9999;
        self.myView.backgroundColor=[UIColor whiteColor];
        // self.myView.frame = rect;
        [self.tabBar addSubview:self.myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
        
        [self updateMyRedPoint];
        [self addDynamic];
        
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.tabBar.tintColor = RGB(208, 10, 248);
    //self.tabBar.barTintColor = RGB(29, 39, 57);
   
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMyRedPoint) name:UPDATE_UNREAD_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView:) name:KNOTIFICATION_LOGINCHANGE object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNOTIFICATION_TokenInvalid object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView:) name:KNOTIFICATION_TokenInvalid object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToHome) name:KNOTIFICATION_ShouldBackHome object:nil];
    //监听网络变化
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
   // [self reachability:self.internetReachability];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    
   // LRLog(@"----->tabbarHeight%f",self.tabBar.height);
}
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self reachability:curReach];
}
- (void)reachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
    NSLog(@"connection status = [%@]",statusString);
}
- (void)networkStateChange
 {
     /*
      Reachability *reachability = [Reachability reachabilityForInternetConnection];
      _networkStatus=[reachability currentReachabilityStatus];
      */
     NetworkStatus netStatus = [self.internetReachability currentReachabilityStatus];
     [WGPublicData sharedInstance].networkStatus = netStatus;
     switch (netStatus)
     {
         case NotReachable:        {
           // [WGPublicData showToast_PB:@"网络连接已断开"];
             break;
         }
             
         case ReachableViaWWAN:        {
            // [WGPublicData showToast_PB:@"正在使用运营商网络"];
             //发送广播
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_NetworkChangeWLAN object:nil];
             break;
         }
         case ReachableViaWiFi:        {
            // statusString= NSLocalizedString(@"Reachable WiFi", @"");
             break;
         }
     }

    
 }
-(void)backToHome
{
     [[WGPublicData sharedInstance].currentViewController.navigationController popToRootViewControllerAnimated:NO];
    
    [self.myView clickBtnWithIndex:0];
    // self.selectedIndex = 0;
}
-(void)showLoginView:(NSNotification*)sender
{
//    if ([[PublicManager sharedInstance].currentViewController isKindOfClass:[UserLoadViewController class]]) {
//        return;
//    }
    
    NSLog(@"mainTabbar收到登录变化的通知 %@",sender);
    if ([sender.object integerValue]==0) {
        
//        UserLoadViewController *uvc=[[UserLoadViewController alloc]init];
//        [[PublicManager sharedInstance].currentViewController.navigationController popToRootViewControllerAnimated:NO];
//        [ [PublicManager sharedInstance].currentViewController.navigationController pushViewController:uvc animated:NO];
//
    }
    else{
        
    }
    
    
    // [self refreshDataSource];
}
- (void)loginStateChange:(NSNotification *)sender
{
    
    /*
    [[SharedUserDefault sharedInstance] setLoginState:@"N"];
    [[SharedUserDefault sharedInstance] removeUserToken];
    // 删除缓存的信息,解决了账户被踢后，还可以接单的bug
    [[SharedUserDefault sharedInstance] removeUserInfo];
    
    if([PublicManager sharedInstance].currentViewController)
    {
        if ([[PublicManager sharedInstance].currentViewController isKindOfClass:[UserLoadViewController class]]) {
            return;
        }
        
        if ([PublicManager sharedInstance].currentViewController.navigationController) {
            UINavigationController *nav=[PublicManager sharedInstance].currentViewController.navigationController;
            [nav popToRootViewControllerAnimated:YES];
            UserLoadViewController *uvc=[[UserLoadViewController alloc]init];
            [nav pushViewController:uvc animated:YES];
            //[[WGPublicData sharedInstance].currentViewController.navigationController popToRootViewControllerAnimated:YES];
            
        }
        else
        {
            UIViewController *result = nil;
            UIView *frontView = [PublicManager sharedInstance].currentViewController.view;
            UIView *parentV=[frontView superview];
            
            id nextResponder = [parentV nextResponder];
            
            if ([nextResponder isKindOfClass:[UIViewController class]])
            {
                result = nextResponder;
                
                if ([result isKindOfClass:[UserLoadViewController class]]) {
                    return;
                }
                
                UINavigationController *nav=result.navigationController;
                /*
                 [result.navigationController popToRootViewControllerAnimated:YES];
                 UIWindow *window=[UIApplication sharedApplication].keyWindow;
                 WGMainTabBarController *tBC = (WGMainTabBarController *)window.rootViewController;
                 // self.window.rootViewController = tBC;
                 // tBC.selectedIndex = 0;
                 [tBC.myView clickBtnWithIndex:0];
                 */
    /*
                UserLoadViewController *uvc=[[UserLoadViewController alloc]init];
                [nav pushViewController:uvc animated:YES];
            }
        }}
*/
}

/**永远别忘记设置代理*/
- (void)tabBar:(CustomTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    NSLog(@"selectedFrom%dto%d",from,to);
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mask 横竖屏设置
#pragma waring shouldAutorotateToInterfaceOrientation 在ios6中已经被废弃了
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    //不支持横屏
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// 一开始的屏幕旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item
{
    if(item.tag==100)
    {
//        [PublicManager sharedInstance].myRedPoint.hidden = YES;
//        [[SharedUserDefault sharedInstance] setMyRedPointFlag:NO];
    }
    
}

- (void)addMyRedPoint
{
//    [PublicManager sharedInstance].myRedPoint = [[UILabel alloc] init];
//    [PublicManager sharedInstance].myRedPoint.backgroundColor = [UIColor redColor];
//    [[PublicManager sharedInstance].myRedPoint.layer setCornerRadius:6.0f];
//    [[[PublicManager sharedInstance].myRedPoint layer] setMasksToBounds:YES];
//    [[PublicManager sharedInstance].myRedPoint setText:@"10"];
//    [[PublicManager sharedInstance].myRedPoint setTextColor:[UIColor whiteColor]];
//    [[PublicManager sharedInstance].myRedPoint setFont:[UIFont systemFontOfSize:10]];
//    [[PublicManager sharedInstance].myRedPoint setTextAlignment:NSTextAlignmentCenter];
//
//    [PublicManager sharedInstance].myRedPoint.tag = 1;
    CGRect tabFrame = self.tabBar.frame;
    CGFloat x;
    if(ScreenWidth==320)
    {
        x = ceilf(0.79 * tabFrame.size.width);
    }
    else if (ScreenWidth==375)
    {
        x = ceilf(0.78 * tabFrame.size.width);
    }
    else
    {
        x = ceilf(0.77 * tabFrame.size.width);
    }
    CGFloat y = ceilf(0.15 * tabFrame.size.height);

    [self updateMyRedPoint];
}

- (void)updateMyRedPoint
{
    
    
    NSMutableArray *ret = nil;
    /*
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    
    // NSDictionary *dic=[[[EMClient sharedClient] chatManager] loginInfo];
    NSArray* sorte = [conversations sortedArrayUsingComparator:
                      ^(EMConversation *obj1, EMConversation* obj2){
                          EMMessage *message1 = [obj1 latestMessage];
                          EMMessage *message2 = [obj2 latestMessage];
                          if(message1.timestamp > message2.timestamp) {
                              return(NSComparisonResult)NSOrderedAscending;
                          }else {
                              return(NSComparisonResult)NSOrderedDescending;
                          }
                      }];
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in ret) {
        unreadCount += conversation.unreadMessagesCount;
        NSLog(@"HXunreadCount%d",unreadCount);
    }
    
    
    NSInteger jiedangCount = [[[WGJumpUrlHandle getInstance] jieDangMessageCount] integerValue];
    
    NSInteger tongzhiCount = [[[WGJumpUrlHandle getInstance] tongZhiMessageCount] integerValue];
    
    unreadCount += jiedangCount + tongzhiCount;
    WGTabbarItemBT *centerBT=[self.myView viewWithTag:100+2];
    centerBT.messageCountLB.text=[NSString stringWithFormat:@"%d",unreadCount];
    if (unreadCount>999) {
        centerBT.messageCountLB.text=[NSString stringWithFormat:@"..."];
    }
    [centerBT.messageCountLB sizeToFit];
    centerBT.messageCountLB.width+=10;
    if (unreadCount>0)
        centerBT.messageCountLB.hidden=NO;
    else
        centerBT.messageCountLB.hidden=YES;
    */
    /*
     if (jiedangCount>0) {
     WGTabbarItemBT *centerBT=[self.myView viewWithTag:100+3];
     centerBT.messageCountLB.text=[NSString stringWithFormat:@"%d",jiedangCount];
     if (jiedangCount>999) {
     centerBT.messageCountLB.text=[NSString stringWithFormat:@"..."];
     }
     [centerBT.messageCountLB sizeToFit];
     centerBT.messageCountLB.width+=10;
     centerBT.messageCountLB.hidden=NO;
     }
     if (tongzhiCount>0) {
     WGTabbarItemBT *chatBT=[self.myView viewWithTag:100+2];
     chatBT.messageCountLB.text=[NSString stringWithFormat:@"%d",tongzhiCount];
     if (tongzhiCount>999) {
     chatBT.messageCountLB.text=[NSString stringWithFormat:@"..."];
     }
     [chatBT.messageCountLB sizeToFit];
     chatBT.messageCountLB.width+=10;
     chatBT.messageCountLB.hidden=NO;
     }
     */
    /*
     if(unreadCount <= 0)
     {
     [[PublicManager sharedInstance].myRedPoint setHidden:YES];
     }
     else
     {
     NSString *text = [NSString stringWithFormat:@"%ld",(long)unreadCount];
     CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:10]];
     if(size.width < 13)
     {
     size.width = 13;
     }
     CGRect rect = [PublicManager sharedInstance].myRedPoint.frame;
     [PublicManager sharedInstance].myRedPoint.frame = CGRectMake(rect.origin.x - (size.width -13) / 2, rect.origin.y, size.width, 13);
     [[PublicManager sharedInstance].myRedPoint setText:text];
     [[PublicManager sharedInstance].myRedPoint setHidden:NO];
     }
     */
}
-(void)addDynamic
{
    [WGPublicData sharedInstance].BgView=[[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/2-(ScreenWidth/5)/2), 0, (ScreenWidth/5), 49)];
    [self.tabBar addSubview:[WGPublicData sharedInstance].BgView];
    [WGPublicData sharedInstance].dynamicBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [WGPublicData sharedInstance].dynamicBtn.frame=CGRectMake(((ScreenWidth/5)-50)/2, 2, 45, 45);
//    [WGPublicData sharedInstance].dynamicBtn.layer.borderWidth=2.0;
//    [WGPublicData sharedInstance].dynamicBtn.layer.borderColor=[RGB(255, 0, 0) CGColor];
//    [WGPublicData sharedInstance].dynamicBtn.layer.cornerRadius=25;
    [WGPublicData sharedInstance].dynamicBtn.clipsToBounds=YES;
    [[WGPublicData sharedInstance].dynamicBtn setImage:[UIImage imageNamed:@"circleIcon"] forState:UIControlStateNormal];//PublishAny_icon
    [[WGPublicData sharedInstance].dynamicBtn addTarget:self action:@selector(setView) forControlEvents:UIControlEventTouchUpInside];
    [[WGPublicData sharedInstance].BgView addSubview:[WGPublicData sharedInstance].dynamicBtn];
}
-(void)setView
{
    //中间扫码器
   // CoderReader *viewController = [[CoderReader alloc] init];
   // viewController.hidesBottomBarWhenPushed=YES;
   // [ [WGPublicData sharedInstance].currentViewController.navigationController pushViewController:viewController animated:YES];
    
    
    //显示极简注册页面的地址二维码
    /*
    baseWkWebVC * codeVC=[[baseWkWebVC alloc]init];
    [codeVC setUrl:[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/#/myQrCode"]];
    codeVC.showClose=YES;
  //  [ [WGPublicData sharedInstance].currentViewController.navigationController pushViewController:codeVC animated:YES];
    [ [WGPublicData sharedInstance].currentViewController presentViewController:codeVC animated:YES completion:nil];
     
     */
      LoginViewController *loginController = [[LoginViewController alloc]init];
      loginController.hidesBottomBarWhenPushed=YES;
   //   [ [WGPublicData sharedInstance].currentViewController presentViewController:loginController animated:YES completion:nil];
     [ [WGPublicData sharedInstance].currentViewController.navigationController pushViewController:loginController animated:YES ];
    return;
    
    //类似新浪 弹出操作浮层
     [WGPublicData sharedInstance].dynamicBtn.hidden=YES;
     bgView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
     bgView1.userInteractionEnabled=YES;
     bgView1.backgroundColor=[UIColor clearColor];
     [self.view addSubview:bgView1];
     
     bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
     
     bgView.userInteractionEnabled=YES;
     bgView.backgroundColor=[UIColor blackColor];
     bgView.alpha=0.8;
     [bgView1 addSubview:bgView];
     UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleHideView)];
     [bgView addGestureRecognizer:tap];
     
     
     UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
     cancelBtn.frame=CGRectMake((ScreenWidth/2)-60/2, ScreenHeight-60+5, 60, 60);
     [cancelBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];// CancelPublish
     [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
     [bgView addSubview:cancelBtn];
     
     for(int i=0;i<2;i++)
     {
     double w=100;
     double x=(ScreenWidth-200)/3+i*(w+(ScreenWidth-200)/3);
     UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
     button.frame=CGRectMake(x, ScreenHeight-250, w, w);
     button.tag=i+100;
     [button addTarget:self action:@selector(SubmitDynamic:) forControlEvents:UIControlEventTouchUpInside];
     [button setBackgroundImage:[UIImage imageNamed:self.iconArray[i]] forState:UIControlStateNormal];
     [bgView1 addSubview:button];
     
     UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(x, ScreenHeight-180, w, w)];
     titlelabel.text=self.titleArray[i];
     titlelabel.font=[UIFont systemFontOfSize:16];
     titlelabel.textAlignment=NSTextAlignmentCenter;
     titlelabel.textColor=[UIColor whiteColor];
     [bgView addSubview:titlelabel];
     }
    
    UIViewController *currentViewController = [[self childViewControllers] objectAtIndex:[self selectedIndex]];
    currentViewController = [[currentViewController childViewControllers] objectAtIndex:0];
//    if([SharedUserDefault sharedInstance].isLogin)
//    {
//
//      //  DynamicViewController *dynamic=[[DynamicViewController alloc]init];
//      //  [currentViewController.navigationController pushViewController:dynamic animated:YES];
//
//    }
//    else
//    {
//        UserLoadViewController *uvc=[[UserLoadViewController alloc]init];
//        [currentViewController.navigationController pushViewController:uvc animated:YES];
//    }
}
-(void)deleHideView
{
    bgView.hidden=YES;
    bgView1.hidden=YES;
    [WGPublicData sharedInstance].dynamicBtn.hidden=NO;
}
-(void)cancelBtn
{
    bgView.hidden=YES;
    bgView1.hidden=YES;
    [WGPublicData sharedInstance].dynamicBtn.hidden=NO;
}
-(void)SubmitDynamic:(UIButton *)button
{
    [self cancelBtn];
    UIViewController *currentViewController = [[self childViewControllers] objectAtIndex:[self selectedIndex]];
    currentViewController = [[currentViewController childViewControllers] objectAtIndex:0];
//    if([SharedUserDefault sharedInstance].isLogin)
//    {
//        if(button.tag==100)
//        {
//            //            WGActivityViewController *activity=[[WGActivityViewController alloc]init];
//            //            activity.mainType=WGSelectPlaceYES;
//            //            [currentViewController.navigationController pushViewController:activity animated:YES];
//        }
//        else
//        {
//          //  DynamicViewController *dynamic=[[DynamicViewController alloc]init];
//          //  [currentViewController.navigationController pushViewController:dynamic animated:YES];
//        }
//    }
//    else
//    {
//        UserLoadViewController *uvc=[[UserLoadViewController alloc]init];
//        [currentViewController.navigationController pushViewController:uvc animated:YES];
//    }
}

@end
