//
//  HttpBaseRequest.h
//  Booking
//
//  Created by wihan on 14-10-16.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestCommDelegate.h"
#import "HttpRequestField.h"
#import "BaseResponse.h"

//@interface MyOperation : AFHTTPRequestOperation
//    @property (nonatomic) NSInteger tag;
//@end

@interface HttpBaseRequest : NSObject<NSXMLParserDelegate>

@property (weak ,nonatomic) id<HttpRequestCommDelegate> delegate;

@property (nonatomic) NSInteger reTag ;


//网络请求单例方法
+(HttpBaseRequest *)sharedInstance ;

//初始化方法
-(HttpBaseRequest *)initWithDelegate:(id) own ;
//网络GET请求实现方法
-(void)initGetRequestComm:(NSMutableDictionary *) params withURL:(NSString *) subUrl operationTag:(NSInteger ) tag;
//网络请求实现方法
-(void)initRequestComm:(NSMutableDictionary *) params withURL:(NSString *) subUrl operationTag:(NSInteger ) tag ;
//带上传的网络请求实现方法
-(void)initRequestComm:(NSMutableDictionary *) params  withFilePaths:(NSMutableArray *)imgArr withURL:(NSString *) subUrl operationTag:(NSInteger ) tag ;

//上传文件接口请求方法
-(void)initUploadFileRequest:(NSDictionary *)params withFilePath:(NSString *)imgPath operationTag:(NSInteger)tag;

//支付接口请求方法
-(void) initPayRequest:(NSDictionary *) params withURL:(NSString *) url operationTag:(NSInteger ) tag ;

@end

