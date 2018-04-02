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

@interface HomeWKWebVC ()

@end

@implementation HomeWKWebVC

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
    [self.view addSubview:clearBT];
    [clearBT addTarget:self action:@selector(clearJsFunction) forControlEvents:UIControlEventTouchUpInside];
}
//扫一扫
-(void)showCodeReader
{
   // [self  apipayWithOrderData:@""];
    [[AlipaySDK defaultService] payOrder:@"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2018032102418344&biz_content=%7B%22body%22%3A%22%E6%B5%8B%E8%AF%95%E6%94%AF%E4%BB%98%E5%AE%9D%22%2C%22out_trade_no%22%3A%22123458%22%2C%22passback_params%22%3A%22test+notify%22%2C%22subject%22%3A%22tititi%22%2C%22timeout_express%22%3A%2215m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fgongrong.ngrok.xiaomiqiu.cn%2Fpay%2Fapi%2Falipay%2Fnotify&sign=lhXLO5UtTIqAj9EDWjgJQmhgjC3paQTdsH2hmkciiWT6q5tUawPY4XmxHJBYpL0W5f%2FLfEmYx7ukL3UY3g1cq2ESIXR00fpPAMp9wGvXEJpEJYIHqMr4loh6aTAYAm9E%2FD13zC51lkyKnExuO2G4thEoCvhplvhRRatGtGOmBa4FxPRNQLzuDOxn%2Befs2TwxwVh%2FJESzs%2FNmMmR50AyxMQexzrLTYSM8QjLmi%2BTHKdu2OgzrZphkPl2xbgrvPcb1RUM6dXtE42mXnVbX8e5CJHEbnnovoWIAjVaCb9QdqG4XwwEOxVJt%2Bd7C5DwzW0W8UHoV3bTijJZBB4VVUKizEA%3D%3D&sign_type=RSA2&timestamp=2018-04-02+18%3A46%3A28&version=1.0" fromScheme:@"AliPayGongrongScheme" callback:^(NSDictionary *resultDic) {
        LRLog(@"reslut = %@",resultDic);
        // [self getAliPayBackData:resultDic];
    }];
    return;
    
    
    CoderReader *viewController = [[CoderReader alloc] init];
    
    viewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
    
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
#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //   NSLog(@"%s",__FUNCTION__);
    [SVProgressHUD dismiss];
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
