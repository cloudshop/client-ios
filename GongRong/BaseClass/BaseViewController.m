//
//  BaseViewController.m
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import "BaseViewController.h"
#import "WGPublicData.h"
#import "UIImageView+WebCache.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(id)init
{
    self = [super init];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(!_viewNaviBar)
    {
        _viewNaviBar = [[CustomNaviBarView alloc] initWithFrame:Rect(0.0f, 0.0f, [CustomNaviBarView barSize].width, [CustomNaviBarView barSize].height)];
        _viewNaviBar.m_viewCtrlParent = self;
        [self.view addSubview:_viewNaviBar];
    }
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    
    if (self.titleStr) {
        [self.viewNaviBar setTitle:self.titleStr];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
       // [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
     self.automaticallyAdjustsScrollViewInsets=NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self)
    {
        [WGPublicData sharedInstance].currentViewController=self;
    }
    
    if (_viewNaviBar && !_viewNaviBar.hidden)
    {
        [self.view bringSubviewToFront:_viewNaviBar];
    }else{}
}
- (void)dealloc
{
    _viewNaviBar = nil;
   // [UtilityFunc cancelPerformRequestAndNotification:self];
}

/*
 * 返回上一个ViewController
 */
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 显示用户信息提示框
 */
- (void)showToast:(NSString *) msg  {
    
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 5 ;
    view.tag = 600 ;
    CGFloat width = [ConUtils labelWidth:msg withFont:[UIFont systemFontOfSize:15]];
    view.frame = CGRectMake(0, 0, width+30, 50);
    view.backgroundColor = [UIColor blackColor];
    //view.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+150);
    //    view.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-view.frame.size.height-view.frame.size.height/2-20);
    view.center = CGPointMake(ScreenWidth/2, ScreenHeight-TabBarHeight-view.frame.size.height/2-10);
    
    UILabel *msgLa = [[UILabel alloc] init];
    msgLa.frame = CGRectMake(0, 0, width+30, 50) ;
    msgLa.text = msg ;
    msgLa.textAlignment = NSTextAlignmentCenter ;
    msgLa.font = [ConUtils boldAndSizeFont:15];
    msgLa.backgroundColor = [UIColor clearColor];
    msgLa.textColor = INFO_TEXT_COLOR;
    [view addSubview:msgLa];
    
    
    [[[UIApplication sharedApplication].delegate window] addSubview:view];
    
    //[self.view addSubview:view];
    
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dismissToastView) userInfo:nil repeats:NO];
    
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void)
     {
         [view setAlpha:0.6];
         
     }completion:^(BOOL finished)
     {
         NSLog(@"toast 结果%d",finished);
         [view removeFromSuperview];
     }];
    
    
}
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
