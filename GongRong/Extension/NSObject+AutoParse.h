//
//  NSObject+AutoParse.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 说明
 
 1.数组类型的变量要声明为:
 @property (nonatomic, strong) NSArray<resultVO>* arrResults;//从NSArray的property attributes获取类型信息
 
 2.resultVO的头文件声明加上协议类型:
 @protocol resultVO <NSObject>
 
 3.支持基本数据类型的属性（bool,int,float,char etc）,不支持CGRect，CGSize，CGPoint
 
 @end
 
 resultVO的属性类型为NSString, NSNumber, NSArray三种类型。
 
 ****JSON object types in iOS****
 You use the NSJSONSerialization class to convert JSON to Foundation objects and convert Foundation objects to JSON.
 An object that may be converted to JSON must have the following properties://但是转换成JSON的对象必须具有如下属性：
 The top level object is an NSArray or NSDictionary.//顶层对象必须是NSArray或者NSDictionary
 
 All objects are instances of NSString, NSNumber, NSArray, NSDictionary, or NSNull.//所有的对象必须是NSString、NSNumber、NSArray、NSDictionary、NSNull的实例
 
 All dictionary keys are instances of NSString.//所有NSDictionary的key必须是NSString类型
 
 Numbers are not NaN or infinity.//数字对象不能是非数值或无穷
 */


@interface NSObject (AutoJson)

//对象转为NSDictionary
-(NSDictionary*)toDictionary;

// 自动解析Json
- (void)parseAutomatically:(NSDictionary *)dicJson;

@end

// NSStirng protocol
@protocol NSString <NSObject>

@end

// NSNumber protocol
@protocol NSNumber <NSObject>

@end