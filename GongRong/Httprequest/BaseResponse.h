//
//  BaseResponse.h
//  Booking
//
//  Created by wihan on 14-10-17.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 * 数据响应基类
 */
@interface BaseResponse : NSObject

@property (nonatomic) NSInteger index ;
@property (nonatomic) NSInteger pageSize ;
@property (nonatomic) NSInteger code ;
//@property (nonatomic) NSInteger totalPage ;
//@property (nonatomic) NSInteger totalRecord ;
@property (nonatomic) NSInteger  hasNextPage;
@property (strong ,nonatomic) NSString *message ;
@property (strong,nonatomic)id datas;
@property (strong,nonatomic)id data;

-(void) setResultData:(id) inParam ;

-(void) setHeadData:(id) inParam ;

@end
