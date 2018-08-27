//
//  ResourceListViewController.h
//  Mcu_sdk_demo
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCUResourceNode;

@interface ResourceListViewController : UIViewController

@property(nonatomic,retain)MCUResourceNode *parentNode;/**< 父节点*/

@end
