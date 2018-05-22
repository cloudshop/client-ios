//
//  PopRootWebVC.m
//  GongRongPoints
//
//  Created by 王旭 on 2018/5/21.
//

#import "PopRootWebVC.h"

@interface PopRootWebVC ()

@end

@implementation PopRootWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle];
    self.viewNaviBar.m_btnBack.hidden=NO;
    [self.viewNaviBar.m_btnBack addTarget:self action:@selector(backToRootVC) forControlEvents:UIControlEventTouchUpInside];
    self.viewNaviBar.hidden=NO;
}
-(void)backToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //   NSLog(@"%s",__FUNCTION__);
    [super webView:webView didFinishNavigation:navigation];
    [SVProgressHUD dismiss];
    if (webView.title.length > 0) {
        //self.viewNaviBar. = webView.title;
        if (!self.titleStr) {
            [self.viewNaviBar setTitle:self.webView.title ];
        }
    }
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
