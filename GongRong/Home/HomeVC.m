//
//  HomeVC.m
//  GongRong
//
//  Created by 王旭 on 2018/1/12.
//

#import "HomeVC.h"
#import "CoderReader.h"
#import "SharedUserDefault.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JGManager.h"
#import <WechatOpenSDK/WXApi.h>
#import "WechatSignAdaptor.h"
@interface HomeVC ()<HttpRequestCommDelegate>

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.viewNaviBar setNavBarMode:NavBarTypeThreeBtn];
    // self.viewNaviBar.backgroundColor=kAppColor1;
   
    [self.viewNaviBar.m_btnLeft setImage:[UIImage imageNamed:@"signin"] forState:UIControlStateNormal];
    [self.viewNaviBar.m_btnLeft addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    self.viewNaviBar.m_btnLeft.hidden=NO;
    [self.viewNaviBar.m_btnRight setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [self.viewNaviBar.m_btnRight addTarget:self action:@selector(gotoSystemMessageCenter) forControlEvents:UIControlEventTouchUpInside];
    self.viewNaviBar.m_btnRightSub.hidden=NO;
    [self.viewNaviBar.m_btnRightSub setImage:[UIImage imageNamed:@"coderReader"] forState:UIControlStateNormal];
    [self.viewNaviBar.m_btnRightSub addTarget:self action:@selector(showCodeReader) forControlEvents:UIControlEventTouchUpInside];
    [self.viewNaviBar setGradientClolr:RGB(100, 100, 100)];
    [self addSearch];
    [self setConfiguration];
    NSString * strrrr=@"gfd";
    NSString * AliPayScheme=@"rgbvfedcs";
    
    GDMapManager *manager=[GDMapManager shareInstance];
    [manager getLocation];
    NSString *dodo= [manager getLoactionWithCityName:@""];
    NSLog(@"城市：%@ 经度：%@纬度：%@",manager.currentCity,manager.strlatitude,manager.strlongitude);
   
//    [[AlipaySDK defaultService] payOrder:strrrr fromScheme:AliPayScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut = %@",resultDic);
//        [self getAliPayBackData:resultDic];
//    }];
//    dispatch_queue_t que=dispatch_queue_create("uiuiui", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程");
        });
    });
    dispatch_queue_t ioio=dispatch_queue_create("biaoji", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t oioi=dispatch_queue_create("biaojiji", DISPATCH_QUEUE_SERIAL);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
}
-(void)getAliPayBackData:(NSDictionary *)dic
{
    
}

-(void)addSearch
{
    // 搜索按钮//、、UIButton* btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (ScreenWidth -self.viewNaviBar.m_btnLeft.right-(ScreenWidth-self.viewNaviBar.m_btnRight.left)), 27)];
    UIButton* btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
    
    [btnSearch addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    btnSearch.backgroundColor = [UIColor whiteColor];
    btnSearch.layer.cornerRadius = 2;
    btnSearch.layer.masksToBounds = YES;
    btnSearch.layer.borderWidth=0.5;
    btnSearch.layer.borderColor=[kAppColor6 CGColor];
    UIImageView* imgSearchIcon = [self.view newImageView];
    [btnSearch addSubview:imgSearchIcon];
    imgSearchIcon.image = [UIImage imageNamed:@"iconSearch"];
    [imgSearchIcon useImageSize];
    imgSearchIcon.centerY = btnSearch.height/2;
    imgSearchIcon.left = 10;
    UILabel* labelText = [self.view newLabel];
    [btnSearch addSubview:labelText];
    labelText.font = kAppFont5;
    labelText.textColor = kAppColor9;
    labelText.text = @"请输入要搜索的关键字";
    [labelText sizeToFit];
    labelText.left = imgSearchIcon.right+4;
    labelText.centerY = imgSearchIcon.centerY;
    
    [self.viewNaviBar setMidBtn:btnSearch];
    self.viewNaviBar.m_btnMidSub.frame=CGRectMake(self.viewNaviBar.m_btnLeft.right+15, self.viewNaviBar.m_labelTitle.top, (ScreenWidth -self.viewNaviBar.m_btnLeft.right-30-(ScreenWidth-self.viewNaviBar.m_btnRightSub.left)), 27);
    
}
- (void)searchAction
{
    /*
    WGSearchPersonAndPlaceViewController *wvc=[[WGSearchPersonAndPlaceViewController alloc]init];
    wvc.mainType=0;
    wvc.searchTitle=@"请输入要搜索的关键字";
    wvc.searchBCOnly=YES;
    wvc.ZYsearchType=searchCourse;
    
    [self.navigationController pushViewController:wvc animated:YES];
     */
    /*
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
   
   // [request initRequestJsonComm:dic withURL:Wallets_User operationTag:WalletsUser];
    [request initGetRequestComm:dic withURL:Wallets_User operationTag:WalletsUser];
    [SVProgressHUD show];
     */
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"payType"];
    [dic setObject:@"0.01" forKey:@"payment"];
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    
     [request initRequestJsonComm:dic withURL:Oreder_deposit operationTag:Orederdeposit];
   // [request initGetRequestComm:dic withURL:Wallets_User operationTag:WalletsUser];
    [SVProgressHUD show];
}
-(void)setConfiguration
{
    self.mainTableView.frame=Rect(0, self.viewNaviBar.bottom, ScreenWidth, self.view.height-TabBarHeight-self.viewNaviBar.height);
    self.mainTableView.backgroundColor=kAppColor7;
    NSLog(@"viewH:-->%f  TabBarHeight--->%f   self.viewNaviBar.height--->%f ",self.view.height,TabBarHeight,self.viewNaviBar.height);
}
//扫一扫
-(void)showCodeReader
{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    [dic setObject:@"admin" forKey:@"username"];
    [dic setObject:@"admin" forKey:@"password"];
    [request initRequestJsonComm:dic withURL:USER_LOGIN operationTag:USERLOGIN];
    [SVProgressHUD show];
    return;
    
    CoderReader *viewController = [[CoderReader alloc] init];
    viewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}
#pragma mark 请求
-(void)requestData
{
    HttpBaseRequest *req=[[HttpBaseRequest alloc]initWithDelegate:self];
    
    
}
-(void)httpRequestSuccessComm:(NSInteger)tagId withInParams:(id)inParam
{
    [SVProgressHUD dismiss];
    BaseResponse *res=[[BaseResponse alloc]init];
    [res setHeadData:inParam];
    switch (tagId) {
            
        case USERLOGIN:{
          
            if (res.code == 0) {
                
                // if(loginResponse.userElement)
                {
                    [self showToast:@"登录成功"];
                   
                   NSString *token=[inParam objectForKey:@"access_token"];
                    [[SharedUserDefault sharedInstance] setUserToken:token];
                    [[SharedUserDefault sharedInstance] setLoginState:@"Y"];
                  //  [self.navigationController popToRootViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                }
            }else{
               
                NSString *returnMsg = [[inParam objectForKey:@"result"] objectForKey:@"msg"];
                if (returnMsg == nil || [returnMsg isEqualToString:@""])
                {
                    [self showToast:@"网络异常，请稍后再试"];
                }
                else
                {
                    [self showToast:returnMsg];
                }
            }
            
        }
            break;
          case GetCitysList:
        {
            NSLog(@"%@",inParam);
            
        }break;
        default:
            break;
    }
}
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *)error
{
    [self  endAllRefresh];
}
#pragma mark 下拉 上拉
-(void)beginToReloadDataForHeader
{
    
}
-(void)beginToReloadDataForFooter
{
    
}
#pragma mark 导航栏按钮事件
-(void)showLeftMenu
{
    
    
   
}

-(void)signIn
{
   
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    [request initRequestComm:dic withURL:Push_Sign operationTag:PushSign];
    [SVProgressHUD show];
}

-(void)gotoSystemMessageCenter
{
    /*
    JSHAREMessage *message = [JSHAREMessage message];
    message.text = @"vrfds";
    message.title=@"title";
    message.platform = JSHAREPlatformWechatSession;
    message.mediaType = JSHARELink;
    message.url=@"http://www.baidu.com";
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        NSLog(@"分享回调");
    }];
    return;
     */
//    [self showToast:@"哈哈哈哈"];
//    return ;
    /*
    [WXApi registerApp:@"wx951d7848326848f0"];
 //  NSString *wxverson= [WXApi getApiVersion];
    // 发起微信支付，设置参数
    PayReq *request = [[PayReq alloc] init];
    request.openID = @"wx951d7848326848f0";//[dic objectForKey:@"wx951d7848326848f0"];
    request.partnerId =@"1490382052";// [dic objectForKey:@"1490382052"];
    request.prepayId=@"wx21180844339240e20e09d1f21319234061";// [dic objectForKey:@"wx21180844339240e20e09d1f21319234061"];
    request.package = @"Sign=WXPay";
    request.nonceStr= @"2mk8n04btDCeHtJ6";//[dic objectForKey:WXNONCESTR];
    
    // 将当前时间转化成时间戳
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    UInt32 timeStamp =[timeSp intValue];
    request.timeStamp= timeStamp;
    
    
    // 签名加密
    WechatSignAdaptor *md5 = [[WechatSignAdaptor alloc] init];

    request.sign=[md5 createMD5SingForPay:request.openID
                                partnerid:request.partnerId
                                 prepayid:request.prepayId
                                  package:request.package
                                 noncestr:request.nonceStr
                                timestamp:request.timeStamp];
     
    //request.sign = @"1C622C4811D616AC6485B2CE2F95A7D3";
    
    // 调用微信
    [WXApi sendReq:request];
     */
    /*
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    // [request initRequestComm:dic withURL:Get_CitysList operationTag:GetCitysList];
    [request initGetRequestComm:dic withURL:Get_CitysList operationTag:GetCitysList];
    [SVProgressHUD show];
    */
    
    /*
     NSMutableDictionary *apsDi=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"test",@"alert",@"2",@"badge",@"default",@"sound", nil];
     NSMutableDictionary *pushDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"idStr",@"PDF",@"notifyFileType",@"http://wiz-image-bucket.oss-cn-beijing.aliyuncs.com/null/话术.pdf",@"notifyUrl",@"KS",@"type", apsDi,@"aps",nil];
     
     [[ZYMessageTipsViewManager sharedManager] showNotification:pushDic completionBlock:^{
     NSString *url = pushDic[@"notifyUrl"];
     // [weakself jumpToWebViewWithUrl:url];
     }];
     return;
     */
//   [self.navigationController pushViewController:messageVC animated:YES];
    
    
    [[AlipaySDK defaultService] payOrder:@"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2018032102418344&biz_content=%7B%22body%22%3A%22%E8%B4%A1%E8%9E%8D%E7%A7%AF%E5%88%86%E5%95%86%E5%9F%8E%22%2C%22out_trade_no%22%3A%2212018050717547179%22%2C%22passback_params%22%3A%22product%22%2C%22subject%22%3A%22%E6%94%AF%E4%BB%98%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%22345.00%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fhttp%3A%2F%2Fcloud.eyun.online%3A9080%2Fpay%2Fapi%2Falipay%2Fapp%2Fnotify&sign=k0FYbMstiH8c7DhIj%2BpgMLOghF9uIvlnIub9w9Nfu9IG1dSRuMYiA0LTB%2Bn9dvnjkKMarTF%2BO2W0gDVAuWGhbKQ%2BRuMGl5FRzAXr8E0ww%2BIPlAyqXbqQXN%2BySbBIAUMjegtrM8ffUta%2Fj4UiGjQOGV1BNuTL9GrLS5xAfEpDT%2F4g6GzwtyTMmvC0nYp4dQtZwHzFf%2Bjsudyg%2FUK1J2FP2mfqTZBsh2PQxjdZaMoIzkqZ%2BQuFqrIiKTaAZsnrpxGdlZeM5q53wv2RWlvvXapSstSg4oLW9YqOMMO4Z9oFoKGkIUZGcTXvwGFtv3c0q5OEO8tb2eRbfp1uI0DD375O7A%3D%3D&sign_type=RSA2&timestamp=2018-05-07+17%3A21%3A54&version=1.0" fromScheme:@"AliPayGongrongScheme" callback:^(NSDictionary *resultDic) {
        LRLog(@"reslut = %@",resultDic);
        // [self getAliPayBackData:resultDic];
    }];
    
    /*
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
   // [request initRequestComm:dic withURL:Get_CitysList operationTag:GetCitysList];
    [request initGetRequestComm:dic withURL:Get_CitysList operationTag:GetCitysList];
    [SVProgressHUD show];
     */
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

@end
