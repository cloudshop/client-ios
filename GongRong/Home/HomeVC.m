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

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import "WechatSignAdaptor.h"
#import "XMLDictionary.h"
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
    [manager getLoactionWithCityName:@""];
    
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
    
//    [self jumpToWxPayWithPrice:@"0.01"];
//    return ;
    
    
    // 发起微信支付，设置参数
    PayReq *request = [[PayReq alloc] init];
    request.openID = @"wxf177c6755716fa32";//[dic objectForKey:@"wx951d7848326848f0"];
    request.partnerId =@"1500998061";// [dic objectForKey:@"1490382052"];
    request.prepayId=@"wx22185243435003023b6d8ce53703591150";// [dic objectForKey:@"wx21180844339240e20e09d1f21319234061"];
                    //   8ced9a149b6c5b79e2bcb682092256e2
    request.package = @"Sign=WXPay";
    request.nonceStr= @"kFZdvoXovuYRC6dr";//[dic objectForKey:WXNONCESTR];
    
    // 将当前时间转化成时间戳
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    UInt32 timeStamp =[timeSp intValue];
    request.timeStamp=[@"1526986363" intValue];//timeStamp;//[@"1526286100364" intValue];
    request.sign = @"E15BADAE90AD5223B7E5C09DDA60D2C1";
    
    // 签名加密
//    WechatSignAdaptor *md5 = [[WechatSignAdaptor alloc] init];

//    request.sign=[md5 createMD5SingForPay:request.openID
//                                partnerid:request.partnerId
//                                 prepayid:request.prepayId
//                                  package:request.package
//                                 noncestr:request.nonceStr
//                                timestamp:request.timeStamp];
//    request.sign = @"F39254AE36C85C52DB7930B5FB4C29BC";
    
    // 调用微信
    [WXApi sendReq:request];
    
    /*
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    // [request initRequestComm:dic withURL:Get_CitysList operationTag:GetCitysList];
    [request initGetRequestComm:dic withURL:Get_CitysList operationTag:GetCitysList];
    [SVProgressHUD show];
    */
    
    /*
     NSMutableDictionary *apsDi=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"test",@"alert",@"2",@"badge",@"default",@"sound", nil];
     NSMutableDictionary *pushDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"idStr",@"PDF",@"notifyFileType",@"http://wiz-image-bucket.oss-cn-beijing.aliyuncs.com/null/话术.pdf",@"notifyUrl",@"KS",@"type"/ apsDi,@"aps",nil];
     
     [[ZYMessageTipsViewManager sharedManager] showNotification:pushDic completionBlock:^{
     NSString *url = pushDic[@"notifyUrl"];
     // [weakself jumpToWebViewWithUrl:url];
     }];
     return;
     */
//   [self.navigationController pushViewController:messageVC animated:YES];
    
    /*
    [[AlipaySDK defaultService] payOrder:@"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2018032102418344&biz_content=%7B%22body%22%3A%22%E8%B4%A1%E8%9E%8D%E7%A7%AF%E5%88%86%E5%95%86%E5%9F%8E%22%2C%22out_trade_no%22%3A%2242018052218793556%22%2C%22passback_params%22%3A%22faceTrans%22%2C%22subject%22%3A%22%E6%94%AF%E4%BB%98%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fapp.grjf365.com%3A9080%2Fpay%2Fapi%2Falipay%2Fapp%2Fnotify&sign=h37GmrljjeAwfgJ5Ch7guHiSDiLcaFW1dV48R9RKRbMRnxiO%2FwPGtvZQ8sXDnAwdYh2YPCRdS1fbRT%2Fz183hG90%2FKGcEmsWkLO6VzHLpzI%2Botyt0hGPflO4L6equ6dHjqWJPrKU90M%2FOSS35yKy7JNidVU3m9WpJPYA7nOOEvp3TJNiOpCiq%2BuhxXKOIbyFHE6M6IawnRZ2MF9uYxybHqMZvq4HDD1ctUPwBQ41b9Ic0MpJoNBU7KYvFi4oB3lgBwvjjQLPBeisvmF6%2BQfmguC1P0BDsy5yCARVDloHNpFWrCIYRTsJS5k%2Bib6Ywo3otQcyGluh56FdJsLEkEkXi1w%3D%3D&sign_type=RSA2&timestamp=2018-05-22+18%3A07%3A34&version=1.0" fromScheme:@"AliPayGongrongScheme" callback:^(NSDictionary *resultDic) {
        LRLog(@"reslut = %@",resultDic);
        // [self getAliPayBackData:resultDic];
    }];
    */
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
- (void)jumpToWxPayWithPrice:(NSString *)price
{
    [self  requestData:price orderID:[NSString stringWithFormat:@"%ld",time(0)]];
}

- (void)requestData:(NSString *)price orderID:(NSString *)orderID{
    NSString *tradeType = @"APP";//交易类型
    NSNumber * num = [NSNumber numberWithFloat:[price floatValue]];
    int priceInt = num.doubleValue *100;
    NSString *totalFee  = [NSString stringWithFormat:@"%d",priceInt];                                        //交易价格1表示0.01元，10表示0.1元
    NSString *tradeNO   = [self generateTradeNO];                       //随机字符串变量 这里最好使用和安卓端一致的生成逻辑
    NSString *addressIP = [self fetchIPAddress];                        //设备IP地址,请再wifi环境下测试,否则获取的ip地址为error,正确格式应该是8.8.8.8
    NSString *orderNo   = orderID;   //随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
    NSString *notifyUrl = @"http://app.grjf365.com:9080";// 交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
    
    //获取SIGN签名
    WechatSignAdaptor *adaptor = [[WechatSignAdaptor alloc] initWithWechatAppId:@"wxf177c6755716fa32"
                                                                    wechatMCHId:@"1500998061"
                                                                        tradeNo:tradeNO
                                                               wechatPartnerKey:@"8ced9a149b6c5b79e2bcb682092256e2"
                                                                       payTitle:@"充值"
                                                                        orderNo:orderNo
                                                                       totalFee:totalFee
                                                                       deviceIp:addressIP
                                                                      notifyUrl:notifyUrl
                                                                      tradeType:tradeType];
    
    //转换成XML字符串,这里只是形似XML，实际并不是正确的XML格式，需要使用AF方法进行转义
    NSString *string = [[adaptor dic] XMLString];
    NSLog(@"string :%@",string);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    // 这里传入的XML字符串只是形似XML，但不是正确是XML格式，需要使用AF方法进行转义
    session.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [session.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [session.requestSerializer setValue:kUrlWechatPay forHTTPHeaderField:@"SOAPAction"];
    [session.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return string;
    }];
    
    [session POST:kUrlWechatPay
       parameters:/*string*/@{@"appid":@"wxf177c6755716fa32",
                              @"mch_id":@"1500998061",
                              @"nonce_str":notifyUrl,
                              @"sign":string,
                              @"body":@"充值",
                              @"total_fee":@"1",
                              @"spbill_create_ip":addressIP,
                              @"notify_url":notifyUrl,
                              @"trade_type":@"APP",
                              @"out_trade_no":orderNo}
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         //  输出XML数据
         NSString *responseString = [[NSString alloc] initWithData:responseObject
                                                          encoding:NSUTF8StringEncoding] ;
         //  将微信返回的xml数据解析转义成字典
         NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
         NSLog(@"dict:%@",dic);
         // 判断返回的许可
         if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]
             &&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
             // 发起微信支付，设置参数
             PayReq *request = [[PayReq alloc] init];
             request.openID = [dic objectForKey:WXAPPID];
             request.partnerId = [dic objectForKey:WXMCHID];
             request.prepayId= [dic objectForKey:WXPREPAYID];
             request.package = @"Sign=WXPay";
             request.nonceStr= [dic objectForKey:WXNONCESTR];
             
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
             
             
             // 调用微信
             [WXApi sendReq:request];
         }else{
             if ([dic objectForKey:@"err_code"]) {
                 NSString * str = [NSString stringWithFormat: @"获取订单失败:%@",[dic objectForKey:@"err_code_des"] ? : @""];
                 //                 [MBProgressHUD showTextOnly:APPLICATION_KEY_WINDOW message:str];
//                 UIAlertController * alr = [UIAlertController showAlertController:@"获取订单失败" message:str style:UIAlertControllerStyleAlert];
//                 [alr addAction:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction *al) {
//
//                 }];
//                 [alr presentViewController:[SettingObject topViewController]];
                 
             }else{
                 NSString * str = [NSString stringWithFormat: @"获取订单失败2:%@",responseString ? : @""];
                 NSLog(@"微信签名%@",str);
                 //[MBProgressHUD showTextOnly:APPLICATION_KEY_WINDOW message:str];
                 
//                 UIAlertController * alr = [UIAlertController showAlertController:@"获取订单失败" message:responseString style:UIAlertControllerStyleAlert];
//                 [alr addAction:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction *al) {
//
//                 }];
//                 [alr presentViewController:[SettingObject topViewController]];
             }
             
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // [MBProgressHUD showTextOnly:APPLICATION_KEY_WINDOW message:@"请求失败"];
         NSLog(@"请求失败");
     }];
}
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    //  srand函数是初始化随机数的种子，为接下来的rand函数调用做准备。
    //  time(0)函数返回某一特定时间的小数值。
    //  这条语句的意思就是初始化随机数种子，time函数是为了提高随机的质量（也就是减少重复）而使用的。
    
    //　srand(time(0)) 就是给这个算法一个启动种子，也就是算法的随机种子数，有这个数以后才可以产生随机数,用1970.1.1至今的秒数，初始化随机数种子。
    //　Srand是种下随机种子数，你每回种下的种子不一样，用Rand得到的随机数就不一样。为了每回种下一个不一样的种子，所以就选用Time(0)，Time(0)是得到当前时时间值（因为每时每刻时间是不一样的了）。
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
    srand(time(0));
#pragma clang diagnostic pop
    for (int i = 0; i < kNumber; i++) {
        
        unsigned index = rand() % [sourceStr length];
        
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

/**
 获取设备ip地址
 1.貌似该方法获取ip地址只能在wifi状态下进行
 */
- (NSString *)fetchIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    if (success == 0) {
        
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
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
