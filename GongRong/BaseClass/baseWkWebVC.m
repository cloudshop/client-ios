//
//  baseWkWebVC.m
//  TuyouTravel
//
//  Created by 王旭 on 16/9/20.
//  Copyright © 2016年 TuYouTravel. All rights reserved.
//

#import "baseWkWebVC.h"
#import "UserLoadViewController.h"
#import "WebControlManager.h"
#import "SharedUserDefault.h"

@interface baseWkWebVC ()


@property (nonatomic,strong)NSArray *testArr;//测试url
@property (nonatomic,assign)int currentCount;//定时器计数
@property (nonatomic,strong)NSTimer *timer;


//几个显示的LB
@property (nonatomic,strong)UILabel *firstNBLB;
@property (nonatomic,strong)UILabel *operationLB;
@property (nonatomic,strong)UILabel *secondNBLB;
@property (nonatomic,strong)UILabel *resultLB;


@end

#define kAlertOnlyRefresh 1990
#define kAlertBackAndRefresh 1991

@implementation baseWkWebVC

-(id)init
{
    self=[super init];
    if (self) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 设置偏好设置
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        // web内容处理池
        config.processPool = [[WKProcessPool alloc] init];
        
        // 通过JS与webview内容交互
        config.userContentController = [[WKUserContentController alloc] init];
        // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
        // 我们可以在WKScriptMessageHandler代理中接收到
        [config.userContentController addScriptMessageHandler:self name:@"GongrongAppModel"];
        

        self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate=self;
       [self.webView setHackishlyHidesInputAccessoryView:YES];
        self.URL=[[NSURL alloc]init];
      
    }
    return self;
}
- ( WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog(@"%s---%@----self%@",__FUNCTION__,self.URL,self);
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    if (self.urlsArr.count<1) {
//         [self openRequest];
//    }
    if ( self.navigationController.viewControllers.count==1) {
        self.tabBarController.tabBar.hidden=NO;
    }
    else
    {
        self.tabBarController.tabBar.hidden=YES;
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ( self.navigationController.viewControllers.count==1) {
        self.tabBarController.tabBar.hidden=NO;
    }
    else
    {
        self.tabBarController.tabBar.hidden=YES;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //  self.title = @"正在载入...";
    
    [self createNavigation];
    
  //  [self setUI];
    self.webView.frame = CGRectMake(0, /*ViewCtrlTopBarHeight*/0, ScreenWidth, ScreenHeight-ViewCtrlTopBarHeight);
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = kAppColor8;
    self.webView.opaque = NO;
    [self.view setUserInteractionEnabled:YES];
    [self.webView setUserInteractionEnabled:YES];
    if(self.showClose)
    {
        UIButton *closeBT=[UIButton buttonWithType:UIButtonTypeCustom];
        closeBT.frame=Rect(10, StatusBarHeight+20, 25, 25);
        closeBT.backgroundColor=[UIColor clearColor];
        [closeBT setImage:[UIImage imageNamed:@"clearPhoneNBIMG"] forState:UIControlStateNormal];
        [self.view addSubview:closeBT];
        [closeBT addTarget:self action:@selector(closeCurrent) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.urlsArr=[[NSMutableArray alloc]init];
    
    //键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadWebView) name:JSRefreshAllTag object:nil];
  //  [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    
    
//     //以下为测试代码
//     self.testArr=[NSArray arrayWithObjects:@"http://www.sina.cn",@"http://www.baidu.com",@"http://www.apple.com",@"http://www.imooc.com",nil];
//     self.timer=[NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(loadNewUrl) userInfo:nil repeats:YES];
//
//     self.currentCount=0;
//
//     [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    id oldName = [change objectForKey:NSKeyValueChangeOldKey];
    NSLog(@"oldName----------%@",oldName);
    id newName = [change objectForKey:NSKeyValueChangeNewKey];
    NSLog(@"newName-----------%@",newName);
  //  [self.webView stopLoading];
    //当界面要消失的时候,移除kvo
    //    [object removeObserver:self forKeyPath:@"name"];
}
-(void)closeCurrent
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backAndRefreshOld
{
    [self reloadWebView];
}
-(void)loadNewUrl
{
    if (self.currentCount==3) {
        [self.timer invalidate];
        return;
    }
    self.currentCount++;
    [self setUrl:[self.testArr objectAtIndex:self.currentCount]];
}
-(void)createNavigation
{
   
    self.viewNaviBar.cnbvDelegate=self;
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle];
    if (self.titleStr) {
        [self.viewNaviBar setTitle:self.titleStr];
    }
    
    [self.viewNaviBar.m_btnLeft setImage:[UIImage imageNamed:@"back_new"] forState:UIControlStateNormal];
    self.viewNaviBar.m_btnLeft.frame=self.viewNaviBar.m_btnBack.frame;
    
    self.viewNaviBar.m_btnBack.hidden=YES;
    self.viewNaviBar.m_btnLeft.hidden=NO;
    [self.viewNaviBar.m_btnLeft addTarget:self action:@selector(newbtnBack:) forControlEvents:UIControlEventTouchUpInside];
   
    self.viewNaviBar.hidden=YES;
    
   
    return;
}



- (void)dealloc
{
    self.webView.navigationDelegate = nil;
}
#pragma mark 获取位置信息
-(NSMutableDictionary *)getLocation
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    GDMapManager *manager=[GDMapManager shareInstance];
    [manager getLocation];
    if (manager.strlongitude.length>0) {
    [dic setObject:manager.strlatitude forKey:@"latitude"];
    [dic setObject:manager.strlongitude forKey:@"longitude"];
    [dic setObject:manager.currentCity forKey:@"currentCity"];
    }
    return dic;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // self.webView.frame = CGRectMake(0, 64, kDeviceW, kDeviceH-64-40);
    
    // self.BT.frame=Rect(0, ScreenHeight-40-64, ScreenWidth, 40);
    // [self.view bringSubviewToFront:self.BT];
    
    [self.webView setUserInteractionEnabled:YES];
    self.urlsArr=[[NSMutableArray alloc]init];
    // NSLog(@"++++++----->%@",self.URL.absoluteString);
}

-(void)setUrl:(NSString*)urlString
{
    if(![[urlString lowercaseString] hasPrefix:@"http"]){
        urlString=[NSString stringWithFormat:@"http://%@",urlString];
    }
   // urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.URL=[NSURL URLWithString:urlString];
    [self openRequest];
}


-(void)reloadWebView
{
    if(self.webView.isLoading){
        [self.webView stopLoading];
    }
    [self openRequest];
}

-(void)openRequest{
    
    if (![ConUtils checkUserNetwork]) {
        [self showToast:NO_NETWORK_TEXT];
        return;
    } ;
    [SVProgressHUD show];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:self.URL];
    request.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     [self.webView loadRequest:request];
   // });
    // [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

#pragma mark - WKNavigationDelegate 页面跳转
#pragma mark 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%s---%@----self%@",__FUNCTION__,self.URL,self);
    /**
     *typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
     WKNavigationActionPolicyCancel, // 取消
     WKNavigationActionPolicyAllow,  // 继续
     }
     */
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark 身份验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
   // NSLog(@"%s",__FUNCTION__);
    // 不要证书验证
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"%s",__FUNCTION__);
  
    /*
    static BOOL isRequestWeb = YES;
    if (isRequestWeb) {
        NSHTTPURLResponse *response = nil;
        NSURLRequest *request=webView.
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        if (response.statusCode == 404) {
            // code for 404
            [self showToast:@"页面暂时走丢了"];
            return NO;
        } else if (response.statusCode == 403) {
            // code for 403
            [self showToast:@"页面暂时走丢了"];
            return NO;
        }
        else if (response.statusCode == 500) {
            // code for 403
            [self showToast:@"页面暂时走丢了"];
            return NO;
        }
        
        //[webView loadData:data MIMEType:@"text/html" textEncodingName:nil baseURL:[request URL]];
        
        isRequestWeb = NO;
        // return YES;
    }
    */
    self.backLocation=nil;
    self.immediately=NO;
    self.backRefresh=NO;
    self.needLogin=NO;
    
    NSString *paramStr = [webView.URL query];
    NSString *URLAbsoluteString=[webView.URL absoluteString];
    
    if ([URLAbsoluteString isEqualToString:@"about:blank"]) {
        
       decisionHandler(WKNavigationResponsePolicyCancel);
        return;
    }
    if (!paramStr) {
        [self.urlsArr addObject:URLAbsoluteString];
       decisionHandler(WKNavigationResponsePolicyAllow);
        return;
        
    }
    
  
    /*----- 下面要做一些公共标准的处理     -------*/
    /*
    NSMutableArray *publicParamArr=[ConUtils formatParamWithParamStr:paramStr];//拆分参数
    NSMutableArray *afterFillArr=[ConUtils setParamValueWithParamStr:publicParamArr];//填充本地参数
    BOOL openNew=NO;
    //标记参数赋值处理后决定页面规则
    for (int i=0;i<afterFillArr.count ; i++) {
        /*
        NSDictionary *dic=afterFillArr[i];
        if ([dic[@"key"] isEqualToString:webParaImmediately]) {
            self.immediately=[dic[@"value"] isEqualToString:@"true"]?YES:NO;
        }
        if ([dic[@"key"] isEqualToString:webParaBackLocation]) {
            self.backLocation=dic[@"value"];
        }
        if ([dic[@"key"] isEqualToString:webParaOpenNew]) {
            openNew= [dic[@"value"] isEqualToString:@"true"]?YES:NO;
        }
        if ([dic[@"key"] isEqualToString:webParaBackRefresh]) {
            self.backRefresh=[dic[@"value"] isEqualToString:@"true"]?YES:NO;
        }
        if ([dic[@"key"] isEqualToString:webParaMemberId]) {//判断是不是要登录
            NSString *memberId=dic[@"value"];
            if (memberId&&([memberId intValue]>0)) {
                self.needLogin=NO;
            }
            else{
                self.needLogin=YES;
            }
            self.backRefresh=[dic[@"value"] isEqualToString:@"true"]?YES:NO;
        }
     
    }
     */
    if (self.needLogin) {
        
        UserLoadViewController *loginController = [[UserLoadViewController alloc] init];
        loginController.loginTag = YES;
        [self.navigationController pushViewController:loginController animated:YES];
       decisionHandler(WKNavigationResponsePolicyCancel);
        
    }
    /*
    if(openNew)
    {
        baseWkWebVC  *placeDetailWebViewVC=[[baseWkWebVC alloc]init];
        placeDetailWebViewVC.hidesBottomBarWhenPushed=YES;
        
        NSMutableArray *paramArr=[ConUtils formatParamWithParamStr:paramStr];
        NSMutableArray *fullArr=[ConUtils setParamValueWithParamStr:paramArr];
        
        NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@://%@:%@%@",webView.URL.scheme,webView.URL.host,webView.URL.port,webView.URL.path];
        
        [urlStr appendFormat:@"?%@",[ConUtils formatUrlParamWithParamArr:fullArr]];
        
        
        [placeDetailWebViewVC setUrl:urlStr];
        
        //[placeDetailWebViewVC setUrl:URLAbsoluteString];
        
        [self.navigationController pushViewController:placeDetailWebViewVC animated:YES];
        
       decisionHandler(WKNavigationResponsePolicyCancel);
    }
     */
    if (!self.immediately) {
        [self.urlsArr addObject:URLAbsoluteString];
        //允许加载当前
       decisionHandler(WKNavigationResponsePolicyAllow);
    }
    else
    {
        if ([self.backLocation isEqualToString:@"closeCurrent"]) {
            [self.navigationController popViewControllerAnimated:YES];
            decisionHandler(WKNavigationResponsePolicyCancel);
        }
        
        BOOL location=NO;
        for (int i=0; i<self.urlsArr.count; i++) {
            NSString *str=self.urlsArr[i];
            NSRange range=[self.backLocation rangeOfString:str];
            
            if (range.location!=NSNotFound) {
                location=YES;
                [self goBackUrl:self.backLocation andNeedRefresh:YES];
                decisionHandler(WKNavigationResponsePolicyCancel);
            }
            
        }
        [self.urlsArr addObject:URLAbsoluteString];
        //没有发现过往加载过某个URL 允许加载
       decisionHandler(WKNavigationResponsePolicyAllow);
        
        
    }

    
   // decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark WKNavigation导航错误
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
  //  NSLog(@"%s",__FUNCTION__);
}

#pragma mark WKWebView终止
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
   // NSLog(@"%s",__FUNCTION__);
}

#pragma mark - WKNavigationDelegate 页面加载
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
  //  NSLog(@"%s",__FUNCTION__);
}

#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
   // NSLog(@"%s",__FUNCTION__);
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
 //   NSLog(@"%s",__FUNCTION__);
    [SVProgressHUD dismiss];
    if (webView.title.length > 0) {
        //self.viewNaviBar. = webView.title;
        if (!self.titleStr) {
             [self.viewNaviBar setTitle:self.webView.title ];
        }
    }
    if(self.parameDic&&self.parameDic.allKeys.count>0)
    {
        NSString *paramStr=[self.parameDic JSONString];
        NSString *finallyStr=[NSString stringWithFormat:@"GetParams('%@')",paramStr];
        //@"GetParams({'key':'ProductId','value':'32'})"
            [webView evaluateJavaScript:finallyStr completionHandler:^(id  result,NSError *error){
                NSLog(@"error%@",error);
                NSLog(@"result%@",result);
                if (!error) {
        
                }
            }];
    }
//    [webView evaluateJavaScript:@"addParam('1')" completionHandler:^(id  result,NSError *error){
//        NSLog(@"error%@",error);
//        NSLog(@"result%@",result);
//        if (!error) {
//
//        }
//    }];
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
   // NSLog(@"%s",__FUNCTION__);
   // NSLog(@"%@", error.localizedDescription);
    [SVProgressHUD dismiss];
    if (error.code==-1009) {
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"提示" message: [NSString stringWithFormat:@"%@稍后回来刷新",NO_NETWORK_TEXT] delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
       
        alt.tag=kAlertOnlyRefresh;
        [alt show];
    }
   else if (error.code!=102) {
        
        [self.webView stopLoading];
        [self showToast:@"页面暂时走丢了"];
    
    
        if (self.navigationController.viewControllers.count==1) {
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败了,刷新试试" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
            
             alt.tag=kAlertOnlyRefresh;
          //  [alt show];
           
        }
        else
        {
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败了,刷新试试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的",nil];
            alt.tag=kAlertBackAndRefresh;
          //  [alt show];

        }
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==kAlertOnlyRefresh) {
        [self reloadWebView];
    }
    else
    {
        if (buttonIndex==1) {
            [self reloadWebView];
        }
    }
}

#pragma mark WKScriptMessageHandler

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    NSLog(@"JS 调用了 %@ 方法，传回参数 %@",message.name,message.body);
    [[WebControlManager shareInstance] handelMessageWithController:self AndMessage:message];
}

# pragma mark HttpRequestCommDelegate
//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(NSInteger) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    BaseResponse *resp=[[BaseResponse alloc]init];
    [resp setHeadData:inParam];
    switch (tagId) {
            
        case USERSMSCODE:
        {
            if (inParam == nil)
            {
                //数据库返回内容为空时
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                
                
                if (resp.code == 0)
                {
                    //验证码下发成功
                    [self showToast:@"验证码下发成功"];
                    // [verifyResponse setResultData:inParam];
                }else
                {
                    //验证码下发失败
                    [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
                  
                }
                
            }
        }
            break;
        case USERLOGIN:
        {
            if(resp.code==0)
            {
                
                [self showToast:@"注册成功，请登录!"];
               // [self.navigationController popViewControllerAnimated:YES ];
                NSString *JSStr=[NSString stringWithFormat:@"mobileSetToken('%@','%@')",inParam[@"access_token"],inParam[@"refresh_token"]];
               // NSString *JSStr=[NSString stringWithFormat:@"mobileSetToken('%@','%@')",@"inParam[access_token]",@"inParamrefresh_token"];
                [[SharedUserDefault sharedInstance]setUserToken:inParam[@"access_token"]];
                
                [self.webView evaluateJavaScript:JSStr completionHandler:^(id  result,NSError *error){
                    NSLog(@"%@",error);
                    if (!error) {
                        
                    }
                }];
            }
            else{
                
            }
        }break;
            
        case USERREGISTER:
        {
          
            if(resp.code==0)
            {
               
                [self showToast:@"注册成功，请登录!"];
                [self.navigationController popViewControllerAnimated:YES ];
                
            }
            else{
              
                NSString *returnMsg = [[inParam objectForKey:@"result"] objectForKey:@"msg"];
                if (returnMsg == nil || [returnMsg isEqualToString:@""])
                {
                    [self showToast:@"亲!你的网络不太好哦,重新试试"];
                }
                else
                {
                    [self showToast:returnMsg];
                }
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *)error
{
    [SVProgressHUD dismiss];
    [self showToast:@"请求失败，请稍后再试"];
}
-(void)OCCallJS
{
    [self.webView evaluateJavaScript:@"clearAllData()" completionHandler:^(id  result,NSError *error){
        NSLog(@"%@",error);
        if (!error) {
          
        }
    }];
}
- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler
{
    NSLog(@"JSmessage--->%@",javaScriptString);
}

#pragma mark WkUIDelegate


/// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}
/// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}
/// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
     NSLog(@"%s",__FUNCTION__);
    completionHandler(@"Client Not handler");
}


-(NSDictionary*)paramsFromQueryString:(NSString*)query
{
    query = [query stringByReplacingOccurrencesOfString:@"?" withString:@""];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    NSArray *array=[query componentsSeparatedByString:@"&"];
    
    for (NSString* param in array) {
        NSArray* arrParam = [param componentsSeparatedByString:@"="];
        if (arrParam.count > 1) {
            [dict setObject:arrParam[1] forKey:arrParam[0]];
        }
    }
    
    return dict;
}
-(void)goBackUrl:(NSString *)targetUrl andNeedRefresh:(BOOL)needRefresh
{
    
    for (int i=self.urlsArr.count-1; i>-1; i--) {
        NSString *str=self.urlsArr[i];
        
        NSURL *url=[NSURL URLWithString:str];
        NSString *urlPath=url.path;
        
        NSRange range=[urlPath rangeOfString:targetUrl];
        
        if (range.location!=NSNotFound) {
            //[self.webView reload];
            NSMutableArray *newArr=[[NSMutableArray alloc]init];
            //发现了吻合的url 除了要停止回退以外 要把urlsArr重新设置一遍 防止数据混乱
            for (int j=0; j<self.urlsArr.count; j++) {
                NSString *str=self.urlsArr[j];
                [newArr addObject:str];
                NSRange range=[str rangeOfString:targetUrl];
                if (range.location!=NSNotFound) {
                    break;
                }
            }
            self.urlsArr=nil;
            self.urlsArr=[[NSMutableArray alloc]initWithArray:newArr];
            return;
        }
        
        [self.webView goBack];
    }
    
    
}
- (void)newbtnBack:(id)sender
{
    
    if([self.webView canGoBack])
    {
        if (!self.backLocation)
        {
            [self.webView goBack];
            
        }
        else
        {
            if( [self.backLocation isEqualToString:@"closeCurrent"])
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self goBackUrl:self.backLocation andNeedRefresh:self.backRefresh];
            }
        }
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (void)keyboardWillShow:(NSNotification*)notification //键盘出现
{
   NSDictionary* info = [notification userInfo];
    NSLog(@"keyboardWillShow%@",info);
    
}

- (void)keyboardWillHide:(NSNotification*)notification //键盘下落
{
   NSDictionary* info = [notification userInfo];
     NSLog(@"keyboardWillHide%@",info);
}
/*
#pragma mark - 状态栏与横屏设置
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

//允许横屏旋转
- (BOOL)shouldAutorotate{
    return YES;
}

//支持左右旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    // return UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
    return UIInterfaceOrientationMaskLandscapeRight;
}

//默认为右旋转
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}
 */
@end
