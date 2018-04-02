//
//  BaseViewController.h
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GongRong.pch"
#import "CustomNaviBarView.h"
#import "SVProgressHUD.h"

#import "HttpRequestCommDelegate.h"
#import "HttpBaseRequest.h"
#import "UtilityFunc.h"
#import "UIImageView+WebCache.h"

@interface BaseViewController : UIViewController<HttpRequestCommDelegate>

@property (nonatomic, strong) CustomNaviBarView *viewNaviBar;

@property (nonatomic,strong)NSString *titleStr;
-(void)popViewController ;

/*
 * 显示用户信息提示框
 */
- (void)showToast:(NSString *) msg ;

@end
