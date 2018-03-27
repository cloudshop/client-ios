//
//  HttpRequestCommDelegate.h
//  Booking
//
//  Created by wihan on 14-10-16.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpRequestCommDelegate <NSObject>

//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(NSInteger) tagId withInParams:(id) inParam;

//网络请求失败协议方法
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *) error ;

@end
