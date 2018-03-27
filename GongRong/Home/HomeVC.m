//
//  HomeVC.m
//  GongRong
//
//  Created by 王旭 on 2018/1/12.
//

#import "HomeVC.h"
#import "CoderReader.h"

#import <AlipaySDK/AlipaySDK.h>

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
     NSMutableDictionary *apsDi=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"test",@"alert",@"2",@"badge",@"default",@"sound", nil];
     NSMutableDictionary *pushDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"idStr",@"PDF",@"notifyFileType",@"http://wiz-image-bucket.oss-cn-beijing.aliyuncs.com/null/话术.pdf",@"notifyUrl",@"KS",@"type", apsDi,@"aps",nil];
     
     [[ZYMessageTipsViewManager sharedManager] showNotification:pushDic completionBlock:^{
     NSString *url = pushDic[@"notifyUrl"];
     // [weakself jumpToWebViewWithUrl:url];
     }];
     return;
     */
//   [self.navigationController pushViewController:messageVC animated:YES];
  
   
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
