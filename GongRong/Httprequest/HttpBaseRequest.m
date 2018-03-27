//
//  HttpBaseRequest.m
//  Booking
//
//  Created by wihan on 14-10-16.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import "HttpBaseRequest.h"
#import "HttpRequestCommDelegate.h"
#import "SharedUserDefault.h"

static HttpBaseRequest *baseRequest ;

@implementation HttpBaseRequest {
    NSString * result ;
    NSMutableArray * resultArray;
    NSInteger *httpTag ;
}

@synthesize delegate;

//网络请求单例方法
+(HttpBaseRequest *) sharedInstance {
    if(baseRequest == nil){
        baseRequest = [[HttpBaseRequest alloc]init];
    }
    return baseRequest ;
}

//初始化方法
-(HttpBaseRequest *)initWithDelegate:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc]init];
    // HttpBaseRequest *request = [HttpBaseRequest sharedInstance];//[[HttpBaseRequest alloc]init];
    request.delegate = own ;
    return request ;
}

//网络GET请求实现方法
-(void)initGetRequestComm:(NSMutableDictionary *) params withURL:(NSString *) subUrl operationTag:(NSInteger ) tag {
    
    AFHTTPSessionManager *manager = [TYHttpSessionManger shareInstance];
    
    NSString *urlStr =@"" ;
    if(tag>=SETWALLETPASSWORLD)
    {
        //        if (tag>=PaySign) {
        //            urlStr=[NSString stringWithFormat:@"%@%@", BASEPAYSERVER, subUrl];
        //        }
        //        else{
        urlStr=[NSString stringWithFormat:@"%@%@", BASEWALLETSERVER, subUrl];
        //        }
    }
    else
    {
        urlStr=[NSString stringWithFormat:@"%@%@", BASEURLPATH, subUrl];
    }
    NSURL *url=[NSURL URLWithString:urlStr];
    
    NSString *token=[[SharedUserDefault sharedInstance]getUserToken];
    if (token) {
        [params setObject:token forKey:@"token"];
    }
    
    
    [manager GET:url.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject){
        self.reTag = tag ;
        NSDictionary *dic = responseObject;
        if (!dic) {
            if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestSuccessComm:withInParams:)])
                [self.delegate httpRequestFailueComm:tag withInParams:@"数据异常"];
            return ;
        }
        if (![dic isKindOfClass:[NSDictionary class]]) {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        }
        
        NSLog(@"%@",dic);
        if (dic &&[dic isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultt=[dic objectForKey:@"result"];
            if (resultt) {
                if ([[resultt objectForKey:@"code"] intValue]==-2) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_TokenInvalid object:nil];
                }
            }
        }
        if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestSuccessComm:withInParams:)])
            [self.delegate httpRequestSuccessComm:tag withInParams:dic];
    }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestFailueComm:withInParams:)])
                  [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
              
          }];
    
    
}

//网络请求实现方法
-(void)initRequestComm:(NSMutableDictionary *) params withURL:(NSString *) subUrl operationTag:(NSInteger ) tag {
    
     AFHTTPSessionManager *manager = [TYHttpSessionManger shareInstance];
  
    NSString *urlStr =@"" ;
    if(tag>=SETWALLETPASSWORLD)
    {
//        if (tag>=PaySign) {
//            urlStr=[NSString stringWithFormat:@"%@%@", BASEPAYSERVER, subUrl];
//        }
//        else{
            urlStr=[NSString stringWithFormat:@"%@%@", BASEWALLETSERVER, subUrl];
//        }
    }
    else
    {
     urlStr=[NSString stringWithFormat:@"%@%@", BASEURLPATH, subUrl];
    }
    NSURL *url=[NSURL URLWithString:urlStr];
  
    NSString *token=[[SharedUserDefault sharedInstance]getUserToken];
    if (token) {
    [params setObject:token forKey:@"token"];
    }
    
    
    [manager POST:url.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject){
        self.reTag = tag ;
        NSDictionary *dic = responseObject;
        if (!dic) {
            if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestSuccessComm:withInParams:)])
           [self.delegate httpRequestFailueComm:tag withInParams:@"数据异常"];
            return ;
        }
        if (![dic isKindOfClass:[NSDictionary class]]) {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        }
        
        NSLog(@"%@",dic);
        if (dic &&[dic isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultt=[dic objectForKey:@"result"];
            if (resultt) {
                if ([[resultt objectForKey:@"code"] intValue]==-2) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_TokenInvalid object:nil];
                }
            }
        }
         if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestSuccessComm:withInParams:)])
        [self.delegate httpRequestSuccessComm:tag withInParams:dic];
    }
    failure:^(NSURLSessionTask *operation, NSError *error) {
         if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestFailueComm:withInParams:)])
        [self.delegate httpRequestFailueComm:tag withInParams:[error description]];

    }];
   
    
}
//带上传的网络请求实现方法
-(void)initRequestComm:(NSMutableDictionary *) params  withFilePaths:(NSMutableArray *)imgArr withURL:(NSString *) subUrl operationTag:(NSInteger ) tag
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURLPATH, subUrl];
    NSURL *url=[NSURL URLWithString:urlStr];
    if (SYSTEM_VERSION>=8.0) {
        AFHTTPSessionManager *manager = [TYHttpSessionManger shareInstance];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *token=[[SharedUserDefault sharedInstance]getUserToken];
        if (token) {
            [params setObject:token forKey:@"token"];
        }
        [manager POST:url.absoluteString parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData> _Nonnull formData)
         {
             for (NSDictionary *dic  in imgArr) {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:dic[@"path"]] name:dic[@"name"] error:nil];
             }
             
         }progress:nil success:^(NSURLSessionTask *task, id responseObject){
             self.reTag = tag ;
             
             NSDictionary *dic = responseObject;
             if (![dic isKindOfClass:[NSDictionary class]]) {
                 dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
             }
             
             //  NSDictionary *dict=[dic objectForKey:@"result"];
             NSLog(@"%@",dic);
             if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestSuccessComm:withInParams:)])
                 [self.delegate httpRequestSuccessComm:tag withInParams:dic];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
             
         }];
        
    }
    else
    {
        NSString *token=[[SharedUserDefault sharedInstance]getUserToken];
        if (token) {
            [params setObject:token forKey:@"token"];
        }
        NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
            // NSData *data=[NSData dataWithContentsOfURL:url];
            //[formData appendPartWithFileURL:[NSURL fileURLWithPath:imgPath] name:@"data" error:nil];
            for (NSDictionary *dic  in imgArr) {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:dic[@"path"]] name:dic[@"name"] error:nil];
            }
        } error:nil];
        [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:request writingStreamContentsToFile:url completionHandler:^(NSError *error){
            AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.responseSerializer=[AFHTTPResponseSerializer serializer];
            NSURLSessionUploadTask *uploadTask=[manager uploadTaskWithRequest:request fromFile:url progress:nil completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){
                if (error) {
                    if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestFailueComm:withInParams:)])
                        [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
                }
                else
                {
                    self.reTag = tag ;
                    NSDictionary *dic = responseObject;
                    if (![dic isKindOfClass:[NSDictionary class]]) {
                        dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    }
                    if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestFailueComm:withInParams:)])
                        [self.delegate httpRequestSuccessComm:tag withInParams:dic];
                }
            }];
            [uploadTask resume];
        }];
        
    }
    
    
    //    if (tag==UPLOADSERVICEIMG) {//UPLOAD_SERVICEIMG
    //        urlStr=[NSString stringWithFormat:@"%@%@", FILESERVERUPLOAD, UPLOAD_SERVICEIMG];
    //    }
    /*
     NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
     [formData appendPartWithFileURL:[NSURL fileURLWithPath:imgPath] name:@"data" error:nil];
     } error:nil];
     AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
     
     [manager POST:url.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject){
     self.reTag = tag ;
     NSDictionary *dic = responseObject;
     
     //  NSDictionary *dict=[dic objectForKey:@"result"];
     NSLog(@"%@",dic);
     [self.delegate httpRequestSuccessComm:tag withInParams:dic];
     }
     failure:^(NSURLSessionTask *operation, NSError *error) {
     [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
     
     }];
     
     
     
     
     [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObj)
     {
     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
     [self.delegate httpRequestSuccessComm:tag withInParams:dic];
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
     [self.delegate httpRequestFailueComm:self.reTag withInParams:[error description]];
     }];
     
     [operation start];
     */
 
}
-(void)initUploadFileRequest:(NSDictionary *)params withFilePath:(NSString *)imgPath operationTag:(NSInteger)tag
{
     //NSString *urlStr = [NSString stringWithFormat:@"%@%@", FILESERVERUPLOAD, UPLOAD_FILE];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURLPATH, UPLOAD_FILE];
    NSURL *url=[NSURL URLWithString:urlStr];
    if (SYSTEM_VERSION>=8.0) {
        AFHTTPSessionManager *manager = [TYHttpSessionManger shareInstance];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url.absoluteString parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData> _Nonnull formData)
         {
         [formData appendPartWithFileURL:[NSURL fileURLWithPath:imgPath] name:@"file" error:nil];
         }progress:nil success:^(NSURLSessionTask *task, id responseObject){
             self.reTag = tag ;
             
             NSDictionary *dic = responseObject;
             if (![dic isKindOfClass:[NSDictionary class]]) {
                 dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
             }             
             
             //  NSDictionary *dict=[dic objectForKey:@"result"];
             NSLog(@"%@",dic);
             if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestSuccessComm:withInParams:)])
             [self.delegate httpRequestSuccessComm:tag withInParams:dic];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
             
         }];
        
    }
    else
    {
        NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
           // NSData *data=[NSData dataWithContentsOfURL:url];
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:imgPath] name:@"data" error:nil];
        } error:nil];
        [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:request writingStreamContentsToFile:url completionHandler:^(NSError *error){
            AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.responseSerializer=[AFHTTPResponseSerializer serializer];
            NSURLSessionUploadTask *uploadTask=[manager uploadTaskWithRequest:request fromFile:url progress:nil completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){
                if (error) {
                    if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestFailueComm:withInParams:)])
                      [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
                }
                else
                {
                    self.reTag = tag ;
                    NSDictionary *dic = responseObject;
                    if (![dic isKindOfClass:[NSDictionary class]]) {
                        dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    }
                    if(self.delegate&&[self.delegate respondsToSelector:@selector(httpRequestFailueComm:withInParams:)])
                    [self.delegate httpRequestSuccessComm:tag withInParams:dic];
                }
            }];
            [uploadTask resume];
        }];
        
    }
    
   
//    if (tag==UPLOADSERVICEIMG) {//UPLOAD_SERVICEIMG
//        urlStr=[NSString stringWithFormat:@"%@%@", FILESERVERUPLOAD, UPLOAD_SERVICEIMG];
//    }
    /*
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:imgPath] name:@"data" error:nil];
    } error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [manager POST:url.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject){
        self.reTag = tag ;
        NSDictionary *dic = responseObject;
        
        //  NSDictionary *dict=[dic objectForKey:@"result"];
        NSLog(@"%@",dic);
        [self.delegate httpRequestSuccessComm:tag withInParams:dic];
    }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
              
          }];
    

    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObj)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
         [self.delegate httpRequestSuccessComm:tag withInParams:dic];
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate httpRequestFailueComm:self.reTag withInParams:[error description]];
     }];
    
    [operation start];
    */
}

//支付接口请求
-(void) initPayRequest:(NSDictionary *) params withURL:(NSString *) url operationTag:(NSInteger ) tag {
    
     AFHTTPSessionManager *manager = [TYHttpSessionManger shareInstance];
     NSString *urlStr =[NSString stringWithFormat:@"%@%@", PAYBASEURLPATH, url];
    
    NSURL *finalyUrl=[NSURL URLWithString:urlStr];
    
    [manager POST:finalyUrl.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject){
        self.reTag = tag ;
        NSDictionary *dic = responseObject;
        if (![dic isKindOfClass:[NSDictionary class]]) {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        }
        
        NSLog(@"%@",dic);
        [self.delegate httpRequestSuccessComm:tag withInParams:dic];
    }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
              
          }];

    
    /*
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", PAYBASEURLPATH, url];
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.reTag = tag ;
        NSDictionary *dic = responseObject;//[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [self.delegate httpRequestSuccessComm:tag withInParams:dic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
    }];
     */
}

@end
