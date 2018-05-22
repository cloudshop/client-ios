//
//  WebControlManager.m
//  GongRongPoints
//
//  Created by 王旭 on 2018/4/11.
//

#import "WebControlManager.h"
#import "GDMapManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>
#import "SharedUserDefault.h"
#import "CoderReader.h"
#import "JGManager.h"
#import "UserLoadViewController.h"

@implementation WebControlManager

+(instancetype)shareInstance
{
    static WebControlManager * manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[WebControlManager alloc]init];
    });
    return manager;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayCallBack:) name:@"kAliPayCallBack" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayCallBack:) name:@"kWechatPayCallBack" object:nil];
        
    }
     return self;
}
-(void)handelMessageWithController:(baseWkWebVC *)webVC AndMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:JSModel]) {
        NSDictionary *dic=(NSDictionary *)message.body;
        if (![dic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if ([dic[@"func"] isEqualToString:JSFuncPayTag]) {
            [self payOperation:dic];
        }
        else if ([dic[@"func"] isEqualToString:JSFuncOpenTag])
        {
            [self PushNewViewControllerWithURLDic:dic AndCurrentVC:webVC];
        }
         else if ([dic[@"func"] isEqualToString:JSFuncCloseTag])
         {
             NSDictionary *paramDic=dic[@"param"];
             [self closeCurrentPage:webVC andDic:paramDic];
            
         }
         else if ([dic[@"func"] isEqualToString:JSFuncShareTag])
         {
             NSDictionary *paramDic=dic[@"param"];
            // [self closeCurrentPage:webVC andDic:paramDic];
             [self shareOperation:paramDic];
             
         }
         else if ([dic[@"func"] isEqualToString:JSFuncLogisticsTag])
         {
             [self checkLogisticsWithDic:dic[@"param"] AndCurrentVC:webVC];
         }
         else if ([dic[@"func"] isEqualToString:JSFuncsetNewCity])
         {
             [self selectNewCityWithDic:dic[@"param"] AndCurrentVC:webVC];
         }
        else if ([dic[@"func"] isEqualToString:JSFuncScanTag])
        {
            CoderReader *viewController = [[CoderReader alloc] init];
            
             viewController.hidesBottomBarWhenPushed=YES;
            [webVC.navigationController pushViewController:viewController animated:YES];
        }
         else if([dic[@"func"] isEqualToString:@"setAccessToken"])
        {
            [self setAccessToken:dic[@"param"]];
        }
        else if([dic[@"func"] isEqualToString:@"requestToken"])
        {
            [self postToken:dic[@"param"] AndWebView:webVC];
        }
    }
    
}
#pragma mark 处理各种打开新页面
-(void)PushNewViewControllerWithURLDic:(NSDictionary *)urlDic AndCurrentVC:(baseWkWebVC *)currentVC
{
    NSDictionary *dic=urlDic[@"param"];
    if (dic&&dic.allKeys.count>0) {
        NSString *urlStr=dic[@"URL"];
        BOOL showClose=dic[@"showClose"];
        NSMutableDictionary *publicParamDic=[ConUtils formatParamWithParamStr:urlStr];//拆分参数
//        NSString *allTokens = dic[@"tokenStr"];
//        if (allTokens&&allTokens.length>5) {
//            [[SharedUserDefault sharedInstance] setUserToken:allTokens];
//        }
         NSRange range5 =[urlStr rangeOfString:@"login"];
        if (range5.location!=NSNotFound) {
            [[SharedUserDefault sharedInstance] removeUserToken];
//            UserLoadViewController *login=[[UserLoadViewController alloc]init];
//            [currentVC.navigationController pushViewController:login animated:YES];
//            return;
        }
        
        baseWkWebVC *vc=[[baseWkWebVC alloc]init];
        vc.webDelegate=currentVC;
        if (showClose) {
            vc.showClose=YES;
        }
        if(![[urlStr lowercaseString] hasPrefix:@"http"]){
            urlStr=[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,urlStr];
        }
         [vc setUrl:urlStr];
        if (publicParamDic.allKeys.count>0) {
            vc.parameDic=[[NSMutableDictionary alloc] initWithDictionary:publicParamDic];
        }
        if ( currentVC.navigationController.viewControllers.count==1) {
            currentVC.hidesBottomBarWhenPushed=YES;
        }
        [currentVC.navigationController pushViewController:vc animated:YES];
    }
}
#pragma Mark 处理关闭页面 和各种后续操作
-(void)closeCurrentPage:(baseWkWebVC *)webVC andDic:(NSDictionary *)paramDic
{
   
    if (!paramDic||paramDic.allKeys.count==0) {
        [webVC.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        BOOL backToHome =paramDic[@"backToHome"];
        BOOL refreshAll= paramDic[JSRefreshAllTag];
        int finallyIndex =[paramDic[@"finallyIndex"] intValue];
        BOOL refreshParent = paramDic[@"refreshParent"];
        NSString *allTokens = paramDic[@"tokenStr"];
        BOOL removeToken= paramDic[@"removeToken"];
        if (allTokens&&allTokens.length>5) {
             [[SharedUserDefault sharedInstance] setUserToken:allTokens];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                     message:[NSString stringWithFormat:@"初始化成功请重启应用！"]
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  //completionHandler();
                                                                  exit(0);
                                                              }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction *action) {
                                                                  //completionHandler();
                                                                  //[self reloadWebView];
                                                              }]];
            [webVC presentViewController:alertController animated:YES completion:^{}];
        }
        
        if (backToHome) {
            [webVC.navigationController popToRootViewControllerAnimated:YES];
            
          //  [UIApplication sharedApplication].keyWindow.rootViewController=[WGPublicData sharedInstance].roottabBarVC;
          //  [WGPublicData sharedInstance].roottabBarVC.tabBar.hidden=NO;
            [[WGPublicData sharedInstance].roottabBarVC.myView clickBtnWithIndex:0];
        }
        if (finallyIndex>0) {
            [webVC.navigationController popToRootViewControllerAnimated:YES];
            // [UIApplication sharedApplication].keyWindow.rootViewController=[WGPublicData sharedInstance].roottabBarVC;
            //  [WGPublicData sharedInstance].roottabBarVC.tabBar.hidden=NO;
            [[WGPublicData sharedInstance].roottabBarVC.myView clickBtnWithIndex:finallyIndex-1];
        }
        if (refreshAll) {
            [webVC.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:JSRefreshAllTag object:nil];
        }
        if (removeToken) {
            [[SharedUserDefault sharedInstance] removeUserToken];
        }
        if (refreshParent) {
            if (webVC.webDelegate&&[webVC respondsToSelector:@selector(backAndRefreshOld)]) {
                  [webVC.webDelegate backAndRefreshOld];
                  [webVC.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        //                 else
        //                 {
        //                     [webVC.navigationController popViewControllerAnimated:YES];
        //                 }
        
        
    }
    
}
#pragma mark 支付操作
-(void)payOperation:(NSDictionary *)payDic
{
    NSDictionary *dic=[NSDictionary dictionaryWithDictionary:payDic];
    NSDictionary *paramDic=dic[@"param"];
    if (!paramDic||paramDic.allKeys.count<1) {
        return;
    }
    NSLog(@"%@",paramDic[JSPayType]);
    if ([paramDic[JSPayType] isEqualToString:JSPay_Ali]) {
        if(!paramDic[@"orderStr"])
        {
            return;
        }
        [[AlipaySDK defaultService] payOrder:paramDic[@"orderStr"] fromScheme:@"AliPayGongrongScheme" callback:^(NSDictionary *resultDic) {
            LRLog(@"reslut = %@",resultDic);
            // [self getAliPayBackData:resultDic];
        }];
    }
    else if([paramDic[JSPayType] isEqualToString:JSPay_Wechat])
    {
        NSLog(@"%@",dic[JSPayType]);
        if(!paramDic[@"orderStr"])
        {
            return;
        }
        NSString *orderStr=paramDic[@"orderStr"];
        NSDictionary *dic =[orderStr mj_JSONObject];
        
        // 发起微信支付，设置参数
        PayReq *request = [[PayReq alloc] init];
        request.openID = [dic objectForKey:@"appid"];
        request.partnerId = [dic objectForKey:@"partnerid"];
        request.prepayId= [dic objectForKey:@"prepayid"];
        //   8ced9a149b6c5b79e2bcb682092256e2
        request.package = [dic objectForKey:@"package"];
        request.nonceStr= [dic objectForKey:@"noncestr"];
        
       
        request.timeStamp=[[dic objectForKey:@"timestamp"] intValue];//timeStamp;//[@"1526286100364" intValue];
        request.sign = [dic objectForKey:@"sign"];
        
        // 调用微信
        [WXApi sendReq:request];
    }
}
#pragma mark 查看物流
-(void)checkLogisticsWithDic:(NSDictionary *)paramDic AndCurrentVC:(baseWkWebVC *)currentVC
{
    NSLog(@"%@",paramDic);
    if (paramDic&&paramDic.allKeys.count>0) {
   //NSString *urlStr= [NSString stringWithFormat:@"https://m.kuaidi100.com/index_all.html?type=%@&postid=%@",@"zhongtong",@"488211056017"];
    NSString *urlStr= [NSString stringWithFormat:@"https://m.kuaidi100.com/index_all.html?type=%@&postid=%@",paramDic[@"LogisticsCode"],paramDic[@"LogisticsNumber"]];
     baseWkWebVC *vc=[[baseWkWebVC alloc]init];
     vc.webDelegate=currentVC;
     vc.showClose=YES;
     [vc setUrl:urlStr];
   
    if ( currentVC.navigationController.viewControllers.count==1) {
        currentVC.hidesBottomBarWhenPushed=YES;
    }
    [currentVC.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark 分享
-(void)shareOperation:(NSDictionary *)shareDic
{
    NSDictionary *paramDic=[NSDictionary dictionaryWithDictionary:shareDic];
    
    if (!paramDic||paramDic.allKeys.count<1) {
        return;
    }
    JSHAREPlatform platformType;
    if ([paramDic[@"platformType"] isEqualToString:@"WechatSession"]) {//微信会话好友
        platformType=JSHAREPlatformWechatSession;
    }
    else if ([paramDic[@"platformType"] isEqualToString:@"TimeLine"])//微信朋友圈
    {
        platformType=JSHAREPlatformWechatTimeLine;
    }
    else if ([paramDic[@"platformType"] isEqualToString:@"QQ"])//QQ好友
    {
        platformType=JSHAREPlatformQzone;
    }
    else if ([paramDic[@"platformType"] isEqualToString:@"SinaWeibo"])//新浪微博
    {
        platformType=JSHAREPlatformSinaWeibo;
    }else{platformType = JSHAREPlatformWechatSession;}
    if ([paramDic[@"shareType"] isEqualToString:@"URL"]) {
        if(!paramDic[@"orderStr"])
        {
            return;
        }
    }
    else
    {
       // NSLog(@"%@",paramDic[JSPayType]);
    }
    JSHAREMessage *message = [JSHAREMessage message];
    message.text = paramDic[@"content"];
    message.title=paramDic[@"title"];
    message.platform = platformType;
    message.mediaType = JSHARELink;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        NSLog(@"分享回调");
    }];
}
#pragma mark 城市选择
-(void)selectNewCityWithDic:(NSDictionary *)paramDic AndCurrentVC:(baseWkWebVC *)currentVC
{
    if (!paramDic||paramDic.allKeys.count<1) {
        return;
    }
    
    NSString *finallyStr=[NSString stringWithFormat:@"%@%@%@",paramDic[@"province"],paramDic[@"city"],paramDic[@"county"]];
    
    GDMapManager *manager=[GDMapManager shareInstance];
    manager.delegate=currentVC;
    
    [manager getLoactionWithCityName:finallyStr];
    
}
-(void)evaluateJavaScript:(NSString *)operationStr
{
    
}


-(void)setAccessToken:(NSString *)AccessToken
{
    
    //    NSString *JSStr=[NSString stringWithFormat:@"eeToken('%@','%@')",@"234",@"123"
    //                     ];
    //    [self.webView evaluateJavaScript:JSStr completionHandler:^(id  result,NSError *error){
    //        NSLog(@"%@",error);
    //        if (!error) {
    //
    //        }
    //    }];
    //    return;
    
    NSDictionary *dic=[AccessToken mj_JSONObject];
    [[SharedUserDefault sharedInstance] setUserToken:dic[@"accessToken"]];
    //    NSMutableDictionary *requestdic=[[NSMutableDictionary alloc]init];
    //    [requestdic setObject:dic[@"username"]?dic[@"username"]:@"" forKey:@"username"];
    //    [requestdic setObject:dic[@"password"]?dic[@"password"]:@"" forKey:@"password"];
    //    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    //    [request initRequestJsonComm:requestdic withURL:USER_LOGIN operationTag:USERLOGIN];
    //    [SVProgressHUD show];
    
    
    
    //    NSMutableDictionary *requestdic=[[NSMutableDictionary alloc]init];
    //
    //    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    //  //  [request initRequestJsonComm:requestdic withURL:@"order/api/pro-order-items" operationTag:USERLOGIN];
    //    [request initGetRequestComm:request withURL:@"order/api/pro-order-items"  operationTag:USERLOGIN];
    //    [SVProgressHUD show];
    
    
}
-(void)postToken:(NSString *)param AndWebView:(baseWkWebVC *)webV
{
    
    NSDictionary *dic=[param mj_JSONObject];
    NSString *callBackStr=dic[@"callBack"];
    NSString *JSStr=[NSString stringWithFormat:@"%@('%@')",callBackStr,[[SharedUserDefault sharedInstance]getUserToken]
                     ];
    [webV.webView evaluateJavaScript:JSStr completionHandler:^(id  result,NSError *error){
        NSLog(@"%@",error);
        if (!error) {
        }
    }];
    return;
}
#pragma mark 支付宝支付结果处理
- (void)aliPayCallBack:(NSNotification*)notification {
    NSDictionary *result = notification.object;
    NSLog(@"result = %@", result);
    [self getAliPayBackData:result];
}
- (void)getAliPayBackData:(NSDictionary *)result {
    NSString *resultStr = result[@"result"];
    NSUInteger resultStatus = [result[@"resultStatus"] integerValue];
    NSString *statusStr=@"unknown";
    baseWkWebVC *webVC=[WGPublicData sharedInstance].currentViewController;
    NSString *JSStr;
    if (resultStatus != 9000) {
        if (resultStatus == 8000) {
          //  [MBProgressHUD showTextOnly:self.superView message:@"正在处理中"];
            statusStr=@"unknown";
        } else if (resultStatus == 4000) {
          //  [MBProgressHUD showTextOnly:self.superView message:@"订单支付失败"];
            statusStr=@"failed";
        } else if (resultStatus == 6001) {
          //  [MBProgressHUD showTextOnly:self.superView message:@"您已中途取消支付"];
            statusStr=@"cancel";
        } else if (resultStatus == 6002) {
          //  [MBProgressHUD showTextOnly:self.superView message:@"您的网络连接出错"];
            statusStr=@"unknown";
        } else {
         //   [MBProgressHUD showTextOnly:self.superView message:@"支付失败"];
            statusStr=@"failed";
        }
      //  return;
    }
    else
    {
        statusStr=@"success";
    }
    JSStr=[NSString stringWithFormat:@"payStatus('%@')",statusStr];
    [webVC.webView evaluateJavaScript:JSStr completionHandler:^(id _Nullable d, NSError * _Nullable error) {
        NSLog(@"%@",d);
        NSLog(@"%@",error);
    }];
   
}
#pragma mark 微信支付结果处理
-(void)weChatPayCallBack:(NSNotification*)notification {
    NSString *result = notification.object;
    NSLog(@"result = %@", result);
     baseWkWebVC *webVC=[WGPublicData sharedInstance].currentViewController;
    NSString * JSStr=[NSString stringWithFormat:@"payStatus('%@')",result];
    [webVC.webView evaluateJavaScript:JSStr completionHandler:^(id _Nullable d, NSError * _Nullable error) {
        NSLog(@"%@",d);
        NSLog(@"%@",error);
    }];
}
/*
 // JS端要
 {
 func：pay
 param:{
 payType:WX(Ali)
 orderStr: XXXXX
 }
 }
 {
 func：login
 param:{
 username:18511895945
 password: 123456
 }
 }
 func：regist
 param:{
 username:18511895945
 password: 123456
 verifyCode：123321
 }
 }
 
 {
 func:openURL;
 param:{
 URL:http://www.baidu.com;
 }
 }
 {
 func:closeCurrent;
 param:{
 }
 }
 {
 func:requestLocationInfo;
 param:{
 }
 }
 */
@end
