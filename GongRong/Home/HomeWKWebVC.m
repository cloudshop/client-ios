//
//  HomeWKWebVC.m
//  GongRongPoints
//
//  Created by 王旭 on 2018/3/24.
//

#import "HomeWKWebVC.h"
#import "CoderReader.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"
#import "CommonDef.h"
#import "SWGVerifyResourceApi.h"
#import "SWGProfileInfoResourceApi.h"

@interface HomeWKWebVC ()

@end

@implementation HomeWKWebVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"+++++>%@",self.navigationController.viewControllers);
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
   // [self.viewNaviBar.m_btnLeft setImage:[UIImage imageNamed:@"signin"] forState:UIControlStateNormal];
    [self.viewNaviBar setNavBarMode:NavBarTypeThreeBtn];
    [self.viewNaviBar.m_btnLeft setTitle:@"呼和浩特" forState:UIControlStateNormal];
    [self.viewNaviBar.m_btnLeft addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    self.viewNaviBar.m_btnLeft.width+=6;
    [self.viewNaviBar.m_btnLeft sizeToFit];
    self.viewNaviBar.m_btnLeft.hidden=NO;
    [self.viewNaviBar.m_btnRight setImage:[UIImage imageNamed:@"messageIMG"] forState:UIControlStateNormal];
    [self.viewNaviBar.m_btnRight addTarget:self action:@selector(gotoSystemMessageCenter) forControlEvents:UIControlEventTouchUpInside];
    self.viewNaviBar.m_btnRight.hidden=NO;
    self.viewNaviBar.m_btnRightSub.hidden=NO;
    [self.viewNaviBar.m_btnRightSub setImage:[UIImage imageNamed:@"coderReader"] forState:UIControlStateNormal];
    [self.viewNaviBar.m_btnRightSub addTarget:self action:@selector(showCodeReader) forControlEvents:UIControlEventTouchUpInside];
    self.viewNaviBar.backgroundColor=[UIColor clearColor];//RGB(240, 240, 240);
  
    [self addSearch];
   // self.webView.frame=Rect(0, 0, ScreenWidth, ScreenHeight-TabBarHeight);
    self.viewNaviBar.hidden=YES;
    GDMapManager *manager=[GDMapManager shareInstance];
//    [manager getLocation];
 //    NSString *ytttt=[[GDMapManager shareInstance] getLoactionWithCityName:@""];
//    NSLog(@"城市：%@ 经度：%@纬度：%@",manager.currentCity,manager.strlatitude,manager.strlongitude);
}
-(void)getSMS
{
//    SWGProfileinforesourceApi *apiInstance = [[SWGProfileinforesourceApi alloc] init];
//    
//    // getActiveProfiles
//    [apiInstance getActiveProfilesUsingGETWithCompletionHandler:
//     ^(SWGProfileInfoVM* output, NSError* error) {
//         if (output) {
//             NSLog(@"%@", output);
//         }
//         if (error) {
//             NSLog(@"Error: %@", error);
//         }
//     }];

    
    
    SWGVerifyresourceApi *api=[[SWGVerifyresourceApi alloc]init];
    [api smsCodeUsingGETWithPhone:@"13439178769" completionHandler:^(SWGResponseEntity *output, NSError *error) {
        NSLog(@"output%@",output);
        NSLog(@"error%@",error);
    }];
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
    self.viewNaviBar.m_btnMidSub.frame=CGRectMake(self.viewNaviBar.m_btnLeft.right+20, self.viewNaviBar.m_labelTitle.top, (ScreenWidth -self.viewNaviBar.m_btnLeft.right-30-(ScreenWidth-self.viewNaviBar.m_btnRightSub.left)), 27);
    self.viewNaviBar.m_btnMidSub.centerY=self.viewNaviBar.m_btnLeft.centerY;
    
    UIButton *clearBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [clearBT setTitle:@"清除" forState:UIControlStateNormal];
    clearBT.backgroundColor=[UIColor blueColor];
    
    clearBT.frame=CGRectMake(0, ScreenHeight-140, ScreenWidth, 40);
 //   [self.view addSubview:clearBT];
    [clearBT addTarget:self action:@selector(clearJsFunction) forControlEvents:UIControlEventTouchUpInside];
}
//扫一扫
-(void)showCodeReader
{
    
   // [self  apipayWithOrderData:@""];
    //{func：pay payType:WX(Ali) orderStr: XXXXX}
        GDMapManager *manager=[GDMapManager shareInstance];
        [manager getLocation];
        NSLog(@"城市：%@ 经度：%@纬度：%@",manager.currentCity,manager.strlatitude,manager.strlongitude);
    
    
   // NSString *jsStr = @"messageSink(erybdsli)";
    
   NSString *jsStr = [NSString stringWithFormat:@"GeographicalLocation('%@','%@')",manager.strlongitude,manager.strlatitude];
    NSLog(@"%@",jsStr);
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable d, NSError * _Nullable error) {
        NSLog(@"%@",d);
        NSLog(@"%@",error);
    }];
    NSLog(@"----->%@",self.URL);
    return;
    
    /*
    
    [[AlipaySDK defaultService] payOrder:@"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2018032102418344&biz_content=%7B%22body%22%3A%22%E8%B4%A1%E8%9E%8D%E7%A7%AF%E5%88%86%E5%95%86%E5%9F%8E%E5%85%85%E5%80%BC%22%2C%22out_trade_no%22%3A%221201804141271398%22%2C%22passback_params%22%3A%22deposit%22%2C%22subject%22%3A%22%E5%85%85%E5%80%BC%E4%BD%99%E9%A2%9D%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fhttp%3A%2F%2Fcloud.eyun.online%3A9080%2Fpay%2Fapi%2Falipay%2Fapp%2Fnotify&sign=vgOWFpJs8FcR0%2FjVq5OBZSrVuOS7NPjX9%2Bb%2BUAghCshVPxOORry44awXX9M7vgyqWEs%2FiikjZtbOE9tMO4DciyfZr6XQuzmmIWekJ53j1lTIZC5i81b28r%2FR1oZH%2BX7ApnnuaLS8RN8rvnKDTgJHxCeTc6BE8R%2FyS%2B04xvy6QlLfbUoaPuWMRdShKfgRgyV2BW4%2BE9mXaNMizI8kEcm0wQfNVgKYMlUM1R9dB64ZZ2h%2FGJAPIYXB8NdzfuONc6Zt6zE0pGnx7JzZiEOljWA9u5ajdeAzbYE8bvXKeAwSunR2EYQH%2BGRqCXj3mK6Ta9C%2Fe38aJVwUWPU%2BQk%2FlRGPUaw%3D%3D&sign_type=RSA2&timestamp=2018-04-14+12%3A27%3A40&version=1.0" fromScheme:@"AliPayGongrongScheme" callback:^(NSDictionary *resultDic) {
        LRLog(@"reslut = %@",resultDic);
        // [self getAliPayBackData:resultDic];
    }];
    return;
    
    /*
    NSString *JSStr=@"window.webkit.messageHandlers.GongrongAppModel.postMessage(‘addPara()’})";
    [self.webView evaluateJavaScript:JSStr completionHandler:^(id  result,NSError *error){
        NSLog(@"%@",error);
        if (!error) {
            
        }
    }];
    return;
    */
    [self showToast:@"thgvfdsa"];
    return;
    CoderReader *viewController = [[CoderReader alloc] init];
    
    viewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}
-(void)gotoSystemMessageCenter
{
    baseWkWebVC *VC=[[baseWkWebVC alloc]init];
    [VC setUrl:@"http://192.168.1.109:8888/#/News"];
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
}
#pragma mark 导航栏按钮事件
-(void)showLeftMenu
{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    [dic setObject:@"admin" forKey:@"username"];
    [dic setObject:@"admin" forKey:@"password"];
    [request initRequestJsonComm:dic withURL:USER_LOGIN operationTag:USERLOGIN];
    [SVProgressHUD show];
    
}
-(void)httpRequestSuccessComm:(NSInteger)tagId withInParams:(id)inParam
{
    NSLog(@"%@",inParam);
}
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *)error
{
    
}
-(void)signIn
{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
    [request initRequestComm:dic withURL:Push_Sign operationTag:PushSign];
    [SVProgressHUD show];
}
-(void)setConfiguration
{
//    self.mainTableView.frame=Rect(0, self.viewNaviBar.bottom, ScreenWidth, self.view.height-TabBarHeight-self.viewNaviBar.height);
//    self.mainTableView.backgroundColor=kAppColor7;
    NSLog(@"viewH:-->%f  TabBarHeight--->%f   self.viewNaviBar.height--->%f ",self.view.height,TabBarHeight,self.viewNaviBar.height);
}
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    //  NSLog(@"%s",__FUNCTION__);
   // [self showCodeReader];
}
#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    // NSLog(@"%s",__FUNCTION__);
   
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //   NSLog(@"%s",__FUNCTION__);
    
    [SVProgressHUD dismiss];
     [self showCodeReader];
  //覆盖父类方法  啥都不干
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
