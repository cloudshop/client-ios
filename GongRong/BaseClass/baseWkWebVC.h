//
//  baseWkWebVC.h
//  TuyouTravel
//
//  Created by 王旭 on 16/9/20.
//  Copyright © 2016年 TuYouTravel. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
//#import <WebKit/WKWebView.h>
//#import <WebKit/WKFoundation.h>
#import "CustomNaviBarView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WKWebView+AccessoryHiding.h"
#import "SVProgressHUD.h"
#import "GDMapManager.h"



@protocol webVCProtocol <NSObject>
-(void)backAndRefreshOld;
@end
@interface baseWkWebVC : BaseViewController<UIGestureRecognizerDelegate,UIAlertViewDelegate,CustomNaviBarViewDelegate,WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate,webVCProtocol>



@property (nonatomic, strong) WKWebView* webView;

@property (nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSURL *URL;

@property (nonatomic,strong)JSContext *contex;

@property (nonatomic,strong)NSMutableArray *urlsArr;//用来记录每一次加载的url（全路径）
//下面这两个参数（新加载一次url就需要重新赋值）
@property (nonatomic,strong)NSString *backLocation;//需要返回的位置
@property (nonatomic,assign)BOOL immediately;//是否需要立即执行跳转（为false的时候就允许第一次加载，其他情况立即跳转）
@property (nonatomic,assign)BOOL backRefresh;//返回到特定页面后是否需要刷新
@property (nonatomic,assign)BOOL needLogin;
@property (nonatomic,assign)BOOL showClose;
@property (nonatomic,strong)NSMutableDictionary *parameDic;//需要向页面中传入的参数列表
@property (nonatomic,weak)id<webVCProtocol>webDelegate;

-(void)setUrl:(NSString*)urlString;
-(void)openRequest;
-(void)goBackUrl:(NSString *)targetUrl andNeedRefresh:(BOOL)needRefresh;
- (void)newbtnBack:(id)sender;
@end
