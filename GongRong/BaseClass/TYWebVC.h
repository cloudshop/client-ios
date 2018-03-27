//
//  TYWebVC.h
//  TuyouTravel
//
//  Created by 王旭 on 16/3/24.
//  Copyright © 2016年 TuyouTravel. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomNaviBarView.h"
//#import "MCDownloadManager.h"

@interface TYWebVC : BaseViewController<UIGestureRecognizerDelegate,CustomNaviBarViewDelegate,UIWebViewDelegate>


-(void)setUrl:(NSString*)urlString;
//-(void)openRequest;
@property (nonatomic, strong) UIWebView* webView;
//@property (nonatomic,strong)CustomNaviBarView *viewNaviBar;
//@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)NSURL *URL;
@end
