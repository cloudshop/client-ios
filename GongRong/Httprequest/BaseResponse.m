//
//  BaseResponse.m
//  Booking
//
//  Created by wihan on 14-10-17.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import "BaseResponse.h"
/*
 * 数据响应基类
 */
@implementation BaseResponse

-(void) setHeadData:(id) inParam {
    NSDictionary *paramDic = (NSDictionary *) inParam ;
    NSDictionary *resultDic = [paramDic objectForKey:@"result"];
    self.code = [[resultDic objectForKey:@"code"] integerValue];
    self.message = [resultDic objectForKey:@"msg"];
    
    NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
    self.datas=[bodyDic objectForKey:@"datas"];
    self.data=[bodyDic objectForKey:@"data"];
    self.index = [[bodyDic objectForKey:@"index"] integerValue];
    self.pageSize = [[bodyDic objectForKey:@"pageSize"] integerValue];
  //  self.totalPage = [[bodyDic objectForKey:@"totalPage"] integerValue];
  //  self.totalRecord = [[bodyDic objectForKey:@"totalRecord"] integerValue];
    self.hasNextPage=[[bodyDic objectForKey:@"hasNextPage"] integerValue];
}

-(void) setResultData:(id) inParam
{
    //
}

@end
