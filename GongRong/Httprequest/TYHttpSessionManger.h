//
//  TYHttpSessionManger.h
//  TuyouTravel
//
//  Created by 王旭 on 16/6/12.
//  Copyright © 2016年 TuYouTravel. All rights reserved.
//

#import "AFHTTPSessionManager.h"


@interface TYHttpSessionManger : AFHTTPSessionManager

@property (nonatomic,strong)AFHTTPSessionManager *manager;

+(AFHTTPSessionManager *)shareInstance;
@end
