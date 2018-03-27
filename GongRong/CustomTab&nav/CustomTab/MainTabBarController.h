//
//  MainTabBarController.h
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"

@interface MainTabBarController : UITabBarController

@property (nonatomic,strong)NSArray *iconArray;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong) CustomTabBar *myView;

-(id)initWithViewControllers:(NSArray *)arr;

@end
