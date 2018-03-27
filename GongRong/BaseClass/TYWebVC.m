//
//  TYWebVC.m
//  TuyouTravel
//
//  Created by 王旭 on 16/3/24.
//  Copyright © 2016年 TuyouTravel. All rights reserved.
//

#import "TYWebVC.h"

@interface TYWebVC ()<NSURLConnectionDataDelegate>
//@property(nonatomic,strong)NSURL *URL;
@property(nonatomic,strong)NSMutableData *dataM;
@end

@implementation TYWebVC

-(id)init
{
    self=[super init];
    if (self) {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        self.webView.delegate = self;
        self.URL=[[NSURL alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.title = @"正在载入...";
    
    [self createNavigation];
    
    
    self.webView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-40-64
                                    );
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = kAppColor8;
    self.webView.opaque = NO;
    [self.view setUserInteractionEnabled:YES];
    [self.webView setUserInteractionEnabled:YES];
    
    
    self.webView.scalesPageToFit=YES;
    self.webView.multipleTouchEnabled=YES;
    
    
}
-(void)createNavigation
{
    self.viewNaviBar.cnbvDelegate=self;
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle];
    if (self.titleStr) {
       [self.viewNaviBar setTitle:self.titleStr];
    }
    
    [self.viewNaviBar.m_btnLeft setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    self.viewNaviBar.m_btnLeft.frame=self.viewNaviBar.m_btnBack.frame;
    
    self.viewNaviBar.m_btnBack.hidden=YES;
    self.viewNaviBar.m_btnLeft.hidden=NO;
    [self.viewNaviBar.m_btnLeft addTarget:self action:@selector(newbtnBack:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)newbtnBack:(id)sender
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)continueCheck:(UITapGestureRecognizer *)sender
{
    NSLog(@"+++++++++++++++");
}

- (void)dealloc
{
    self.webView.delegate = nil;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // self.webView.frame = CGRectMake(0, 64, kDeviceW, kDeviceH-64-40);
    
    // self.BT.frame=Rect(0, ScreenHeight-40-64, ScreenWidth, 40);
   // [self.view bringSubviewToFront:self.BT];
    
    [self.webView setUserInteractionEnabled:YES];
   // NSLog(@"++++++----->%@",self.URL.absoluteString);
}

-(void)setUrl:(NSString*)urlString
{
   // if(![[urlString lowercaseString] hasPrefix:@"http"]){
     //   urlString=[NSString stringWithFormat:@"http://%@",urlString];
   // }
     urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
     
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:self.URL];
    request.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];
    
    
  //  NSURLRequest *request000 = [NSURLRequest requestWithURL:self.URL];
    //发送请求
  //  [NSURLConnection connectionWithRequest:request000 delegate:self];
    
}

#pragma mark - UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString* scheme = [request.URL scheme];
    NSString* path = [[request.URL path] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //    [self showEmbedLoadingView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    /*
    [webView stringByEvaluatingJavaScriptFromString:
     @"javascript:var imgs = document.getElementsByTagName('img');"
     "for(var i = 0; i<imgs.length; i++){"
     "imgs[i].style.width = '100%';"
     "imgs[i].style.height = 'auto';}"];
*/
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //  [self hideEmbedLoadingView];
  //  self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //   [self.naviBar setTitle:self.title];
    if (!self.titleStr) {
        [self.viewNaviBar setTitle:[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // [self hideEmbedLoadingView];
   // [self showToast:NO_NETWORK_TEXT];
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
#pragma mark urlConect 
#pragma mark - NSURLSessionDataDelegate代理方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    NSLog(@"challenge = %@",challenge.protectionSpace.serverTrust);
    //判断是否是信任服务器证书
    if (challenge.protectionSpace.authenticationMethod ==NSURLAuthenticationMethodServerTrust)
    {
        //创建一个凭据对象
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //告诉服务器客户端信任证书
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    }
}

/**
 *  接收到服务器返回的数据时调用
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收到的数据%zd",data.length);
    [self.dataM appendData:data];
}
/**
 *  请求完毕
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *html = [[NSString alloc]initWithData:self.dataM encoding:NSUTF8StringEncoding];
    
    NSLog(@"请求完毕");
    [self.webView loadHTMLString:html baseURL:self.URL];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (NSMutableData *)dataM
{
    if (_dataM == nil)
    {
        _dataM = [[NSMutableData alloc]init];
    }
    return _dataM;
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
