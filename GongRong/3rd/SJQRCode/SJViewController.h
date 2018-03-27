//
//  ViewController.h
//  SJQRCode
//
//  Created by Sunjie on 16/11/15.
//  Copyright © 2016年 Sunjie. All rights reserved.
//
//
// 项目还未完成，将继续更新。
//
//

//
//


#import <UIKit/UIKit.h>

typedef void(^SJViewControllerSuccessBlock)(NSString *);

@interface SJViewController : UIViewController

/** 扫描成功回调block */
@property (nonatomic, copy) SJViewControllerSuccessBlock successBlock;

@end

