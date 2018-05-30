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
#import "SharedUserDefault.h"

@interface HomeWKWebVC ()
//@property (nonatomic,assign)BOOL didSelectCity;
@property (nonatomic,strong)NSString *jingStr;
@property (nonatomic,strong)NSString *weiStr;
@property (nonatomic,strong)NSString *cityStr;
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
   // [self testDB];
  //  [self addSearch];
   // self.webView.frame=Rect(0, 0, ScreenWidth, ScreenHeight-TabBarHeight);
#pragma mark 禁用原生导航
    self.viewNaviBar.hidden=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newCityLocation:) name:kNotification_didSelectCity object:nil];
}
-(void)testDB
{
    
    NSString *databaseName = @"file__0.localstorage";
    
    //Get Library path
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                NSUserDomainMask, YES);
    NSString *libraryDir = [libraryPaths objectAtIndex:0];
    
    NSString *databasePath = [libraryDir
                              stringByAppendingPathComponent:@"WebKit/LocalStorage/"];
    
    NSString *databaseFile = [databasePath
                              stringByAppendingPathComponent:databaseName];
    
    BOOL webkitDb;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    webkitDb = [fileManager fileExistsAtPath:databaseFile];
    
    if (webkitDb) {
//        MMWebKitLocalStorageController* wkc = [[MMWebKitLocalStorageController alloc] init];
//        [wkc updateUserFromLocalStorage:databaseFile];
        NSLog(@"webkitDb");
    }
    else
    {
        NSLog(@"");
    }
    
}
-(void)getSMS
{
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
    
    /*
    GDMapManager *manager=[GDMapManager shareInstance];
    [manager getLocation];
    NSLog(@"城市：%@ 经度：%@纬度：%@",manager.currentCity,manager.strlatitude,manager.strlongitude);
 
   NSString *jsStr = [NSString stringWithFormat:@"GeographicalLocation('%@','%@')",manager.strlongitude,manager.strlatitude];
    NSLog(@"%@",jsStr);
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable d, NSError * _Nullable error) {
        NSLog(@"%@",d);
        NSLog(@"%@",error);
    }];
    NSLog(@"----->%@",self.URL);
    return;
    */
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
#pragma mark 设置新城市后 查到经纬度后再返回给页面
-(void)newCityLocation:(NSNotification *)locationDic
{
    NSDictionary *dic=locationDic.object;
    
    if (!dic||![dic isKindOfClass:[NSDictionary class]]) {
        [self showToast:@"查询地区信息失败！稍后再试"];
        return;
    }
    
    self.jingStr=dic[@"longitude"];
    self.weiStr=dic[@"latitude"];
    self.cityStr=dic[@"cityName"];
    GDMapManager *manager=[GDMapManager shareInstance];
    [manager getLocation];
    //    NSString *ytttt=[[GDMapManager shareInstance] getLoactionWithCityName:@""];
    
    NSString *JSStr=[NSString stringWithFormat:@"GeographicalLocation('%@','%@','%@')",dic[@"longitude"],dic[@"latitude"],dic[@"cityName"]
                     ];
    [self.webView evaluateJavaScript:JSStr completionHandler:^(id  result,NSError *error){
        NSLog(@"%@",error);
        if (!error) {
            
        }
    }];
    
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
 //   NSLog(@"viewH:-->%f  TabBarHeight--->%f   self.viewNaviBar.height--->%f ",self.view.height,TabBarHeight,self.viewNaviBar.height);
}
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    //  NSLog(@"%s",__FUNCTION__);
    [super webView:webView didStartProvisionalNavigation:navigation];
   
}
#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    // NSLog(@"%s",__FUNCTION__);
    [super webView:webView didCommitNavigation:navigation];
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //   NSLog(@"%s",__FUNCTION__);
    [super webView:webView didFinishNavigation:navigation];
    [SVProgressHUD dismiss];
   
    if (self.cityStr.length<1) {
          //覆盖父类方法
            GDMapManager *manager=[GDMapManager shareInstance];
                [manager getLocation];
            //    NSString *ytttt=[[GDMapManager shareInstance] getLoactionWithCityName:@""];
            NSString *JSStr;
            if (manager.currentCity.length>1) {
                JSStr=[NSString stringWithFormat:@"GeographicalLocation('%@','%@','%@')",manager.strlongitude,manager.strlatitude,manager.currentCity
                                 ];
            }
            else
            {
                JSStr=[NSString stringWithFormat:@"GeographicalLocation('%@','%@','%@')",@"116.413521",@"39.894247",@"东城区"
                       ];
            
            }
            [webView evaluateJavaScript:JSStr completionHandler:^(id  result,NSError *error){
                NSLog(@"%@",error);
                if (!error) {
                    
                }
            }];
    }
    else
    {
        NSString *JSStr;
       
        JSStr=[NSString stringWithFormat:@"GeographicalLocation('%@','%@','%@')",self.jingStr,self.weiStr,self.cityStr
                   ];
        
        
        [webView evaluateJavaScript:JSStr completionHandler:^(id  result,NSError *error){
            NSLog(@"%@",error);
            if (!error) {
                
            }
        }];
    }
//    NSString *storageStr=[NSString stringWithFormat:@"loadToken()"];
//    [webView evaluateJavaScript:storageStr completionHandler:^(id  result,NSError *error){
//        NSLog(@"storageStr error%@",error);
//        NSLog(@"storageStr result%@",result);
//        if (!error) {
//            NSString *tokenStr=(NSString *)result;
//            NSDictionary *tokenDic=[tokenStr mj_JSONObject];
//            if ([tokenDic isKindOfClass:[NSDictionary class]]) {
//                [self performSelector:@selector(saveToken:) withObject:tokenDic afterDelay:0.5];
//            }
//        }
//        
//    }];
}
-(void)saveToken:(NSDictionary *)dic
{
    NSString *tokenStr=[dic JSONString];
    NSString *storageStr=[NSString stringWithFormat:@"saveToken(%@)",tokenStr];
    [self.webView evaluateJavaScript:storageStr completionHandler:^(id  result,NSError *error){
        NSLog(@"saveToken error%@",error);
        NSLog(@"saveToken result%@",result);
        if (!error) {
//            NSString *tokenStr=(NSString *)result;
//            NSDictionary *tokenDic=[tokenStr mj_JSONObject];
//            if ([tokenDic isKindOfClass:[NSDictionary class]]) {
//
//            }
        }
    }];
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
