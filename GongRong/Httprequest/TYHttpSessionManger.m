//
//  TYHttpSessionManger.m
//  TuyouTravel
//
//  Created by 王旭 on 16/6/12.
//  Copyright © 2016年 TuYouTravel. All rights reserved.
//

#import "TYHttpSessionManger.h"

@implementation TYHttpSessionManger

+(AFHTTPSessionManager *)shareInstance
{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] initWithBaseURL:nil];
       
    });
    return manager;
    
   /*
    AFHTTPSessionManager *manager=[[[self class] alloc] initWithBaseURL:nil];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    return manager;
    */
}
@end
