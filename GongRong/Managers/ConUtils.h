//
//  ConUtils.h
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ConUtils : NSObject

/*
 * 自定义加粗字体类
 * @sizeValue 字体的大小
 */
+(UIFont *)boldAndSizeFont:(int) sizeValue;

/*
 * 时间的转换yyyy-MM-dd
 */
+(NSString *) getyyyyMMddSpaceTime :(NSDate *) date ;
/**
 *  时间格式转换
 *
 *  @param date 需要转换的时间
 *
 *  @return 转换之后的时间格式
 *
 *  @since 1.0.0
 */
+(NSString *)getyyyMMddHHmmSpaceTime :(NSDate *)date;

/*
 * 时间转换为hh:mm
 */
+(NSString *) getHHmmTime:(NSDate *) date ;

/*
 * 时间转换yyyyMMdd
 */
+(NSString *) getyyyyMMddTime:(NSString *) timeStr ;

/*
 * 自定义时长追加的方法
 */
+(NSString *) getHHmmAddTime:(NSString *) timeStr AndTimeLong:(NSString *) timeLong ;

/*
 * 时间日期转换
 */
+(NSString *) getDDMMTime:(NSString *) timeStr ;

/*
 * 判断用户网络是否可用
 */
+ (BOOL)checkUserNetwork;



/*
 * 计算距离的方法
 */
+(NSString *) getDistanceLatA:(double)lat lngA:(double)lng ;

/*
 * 剩余时间的字符组合方法
 */
+(NSString *) getReduceTime:(NSString *) dateStr ;

/*
 * 发布时间的组合方法
 */
+(NSString *) getSendTime:(NSString *) dateStr ;

/*
 * 计算内容所占UILabel的宽度
 */
+(CGFloat)labelWidth:(NSString *) contentText withFont:(UIFont *) font ;

/*
 * 计算内容所占UILabel的高度
 */
+(CGFloat)cellHeight:(NSString*)contentText withWidth:(CGFloat)with withFont:(UIFont *) font ;
+ (CGFloat)imageViewHeightWithImages:(NSArray *)images;
/*
 * 字符串的排序
 */
+(NSString *) stingSort:(NSMutableDictionary *)sortDic ;

/*
 * 图片背景的拉伸处理
 */
+(UIImage *) getImageScale:(NSString *) imageName ;


/**
 *  本地缓存图片
 *
 *  @param logoString   图片的URLString
 *  @param imageView    显示的imageView
 *  @param director     本地存储的目录
 *  @param defaultImage 图片下载失败显示的默认图片
 */
+ (void)checkFileWithURLString:(NSString *)logoString withImageView:(UIImageView *)imageView withDirector:(NSString *)director withDefaultImage:(NSString *)defaultImage;

/**
 *  本地缓存图片但是不获取URL
 *
 *  @param logoString   图片的URLString
 *  @param imageView    显示的imageView
 *  @param director     本地存储的目录
 *  @param defaultImage 图片下载失败显示的默认图片
 *  @param return       是否需要下载新图片
 */
+ (BOOL)checkFileWithURLStringOnly:(NSString *)logoString withImageView:(UIImageView *)imageView withDirector:(NSString *)director withDefaultImage:(NSString *)defaultImage;

/*
 * 获取当前日期
 */
+ (NSString *)getCurrentDate;
+ (void)createFilterListPlistFile;
+ (void)savePlist:(NSArray *)data path:(NSString *)path;
+ (NSArray *)getPlist:(NSString *)path;

/*
 * 计算与当前位置的距离的方法
 */
+(NSString *) getDistanceWithMyLatA:(double)lat lngA:(double)lng myLatA:(double)myLatA mylngA:(double)mylngA;
+ (void)timerFireMethod:(NSTimer *)theTimer showControl:(UILabel *)showControl endTimeStr:(NSString *)endTimeStr startTimeStr:(NSString *)startTimeStr timeStart:(BOOL)timeStart;
+ (NSString *) jsonStringWithString:(NSString *) string;
+ (NSString *) jsonStringWithArray:(NSArray *)array;
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dic;
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;//Unicode汉字转码

/*
 *url参数解析 [{key:username,Value:王不二},{}]
 */
+(NSMutableArray *)formatParamWithParamStr:(NSString *)paramStr;
/*
 *url参数填充
 */
+(NSMutableArray *)setParamValueWithParamStr:(NSMutableArray *)paramArr;
/*
 *url参数增加 有不加  没有的加 [{key:username,Value:王不二},{}]
 */
+(NSMutableArray *)addParamValueWithOldParamArr:(NSMutableArray *)paramArr AndTargetArr:(NSMutableArray *)targetArr;
/*
 *url参数拼接 拼接成 XX=XX&XX=XX格式
 */
+(NSString *)formatUrlParamWithParamArr:(NSMutableArray *)paramArr;

+ (CGFloat)systemVersion;
+ (BOOL)canUsePhotiKit;

+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message ;
+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle ;
+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle actionHandler:(void (^ __nullable)())actionHandler ;
+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message yesTitle:(NSString *)yesTitle yesAction:(void (^ __nullable)())yesAction ;

+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message yesTitle:(NSString *)yesTitle yesAction:(void (^ __nullable)())yesAction cancelTitle:(NSString *)cancelTitle cancelAction:(void (^ __nullable)())cancelAction ;
+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message firstActionTitle:(NSString *)firstActionTitle firstAction:(void (^ __nullable)())firstAction secondActionTitle:(NSString *)secondActionTitle secondAction:(void (^ __nullable)())secondAction ;
+ (UIViewController *)mostFrontViewController ;

//格式化字符串
+(NSString *)formatUrlStr:(NSString *)UrlStr;

@end
