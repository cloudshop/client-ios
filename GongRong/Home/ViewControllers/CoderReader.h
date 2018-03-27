//
//  CoderReader.h
//  ZhongYiTrain
//
//  Created by 王旭 on 2017/4/28.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SJViewControllerSuccessBlock)(NSString *);
@interface CoderReader : BaseViewController

/** 扫描成功回调block */
@property (nonatomic, copy) SJViewControllerSuccessBlock successBlock;
@end
