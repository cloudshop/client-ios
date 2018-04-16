//
//  ConUtils.m
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ConUtils.h"
#import "Reachability.h"
#import "SharedUserDefault.h"
#import <CoreLocation/CoreLocation.h>
#import "HttpRequestField.h"
//#import ""

@implementation ConUtils

/*
 * 自定义加粗字体类
 * @sizeValue 字体的大小
 */
+(UIFont *)boldAndSizeFont:(int) sizeValue{
    UIFont *font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:sizeValue];
    return font ;
}

/*
 * 时间的转换yyyy-MM-dd
 */
+(NSString *) getyyyyMMddSpaceTime :(NSDate *) date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getyyyMMddHHmmSpaceTime :(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}


/*
 * 时间转换为hh:mm
 */
+(NSString *) getHHmmTime:(NSDate *) date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:date];
}

/*
 * 时间转换yyyyMMddHHmm
 */
+(NSString *) getyyyyMMddTime:(NSString *) timeStr {
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    return timeStr ;
}

/*
 * 时间日期转换
 */
+(NSString *) getDDMMTime:(NSString *) timeStr {
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd"];
    matter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [matter dateFromString:timeStr];
    [matter setDateFormat:@"MM月dd日"];
    return [matter stringFromDate:date];
}

/*
 * 自定义时长追加的方法
 */
+(NSString *) getHHmmAddTime:(NSString *) timeStr AndTimeLong:(NSString *) timeLong {
    
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"HH:mm"];
    matter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [matter dateFromString:timeStr];
    date = [date dateByAddingTimeInterval:([timeLong integerValue])*60*60];
    NSString *time = [matter stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@-%@",timeStr,time];
}

/*
 * 检查用户网络是否可用
 */
+ (BOOL)checkUserNetwork
{
    BOOL userNetworkReachbility;
    //Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
            userNetworkReachbility = NO;
            break;
        case ReachableViaWiFi:
            userNetworkReachbility = YES;
            break;
        case ReachableViaWWAN:
            userNetworkReachbility = YES;
            break;
            
        default:
            break;
    }
    return userNetworkReachbility;
}


/*
 * 计算距离的方法
 */
+(NSString *) getDistanceLatA:(double)lat lngA:(double)lng {
    double latA = 10.1;//[[[SharedUserDefault sharedInstance] getLatitude ] floatValue];
    double lngA = 145.1;//[[[SharedUserDefault sharedInstance] getLongitude ] floatValue];
    CLLocation *current = [[CLLocation alloc] initWithLatitude:latA longitude:lngA];
    CLLocation *before = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    CLLocationDistance meters = [current distanceFromLocation:before];
    if(meters/1000 >10){
        //return @"10km以上";
        [NSString stringWithFormat:@"%dkm",meters/1000];
    }
    return [NSString stringWithFormat:@"%.2fkm",meters/1000];
}

/*
 * 计算与当前位置的距离的方法
 */
+(NSString *) getDistanceWithMyLatA:(double)lat lngA:(double)lng myLatA:(double)myLatA mylngA:(double)mylngA {
    double latA = myLatA;
    double lngA = mylngA;
    CLLocation *current = [[CLLocation alloc] initWithLatitude:latA longitude:lngA];
    CLLocation *before = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    CLLocationDistance meters = [current distanceFromLocation:before];
    if(meters/1000 >10){
        return @"10km以上";
    }
    return [NSString stringWithFormat:@"%.2fkm",meters/1000] ;
}

/*
 * 剩余时间的字符组合方法
 */
+(NSString *) getReduceTime:(NSString *) dateStr {
    NSString *timeStr = @"0";
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd HH:mm"];
    matter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [matter dateFromString:dateStr];
    
    long nowValue = [[NSDate date] timeIntervalSince1970];
    long reduceValue = [date timeIntervalSince1970];
    
    long value = (reduceValue - nowValue) ;
    
    if(value <  60){
//        return time = dateStr;
        return @"已过期";
    }
    
    NSInteger day = 60 * 60 * 24 ;
    NSInteger hour = 60 * 60 ;
    NSInteger minute = 60 ;
    
    NSInteger days = value / day ;
    NSString *str = @"剩余";
    
    if(days > 0){
        str = [NSString stringWithFormat:@"%@%ld天",str,(long)days];
    }
    
    long hours = (value)/hour ;
    if(hours > 0){
        timeStr = @"";
        //str = [NSString stringWithFormat:@"%@%d小时",str,hours];
        timeStr = [NSString stringWithFormat:@"%ld",hours];
    }
    
    NSInteger minutes = (value%day)%hour;
    
    //str = [NSString stringWithFormat: @"%@%d分钟",str,(minutes/minute)];
    timeStr = [NSString stringWithFormat:@"%@,%ld",timeStr,(long)(minutes/minute)];
    
    return timeStr;
}

/*
 * 发布时间的组合方法
 */
+(NSString *) getSendTime:(NSString *) dateStr {
    NSString *time =@"";
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    matter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [matter dateFromString:dateStr];
    
    long nowValue = [[NSDate date] timeIntervalSince1970];
    long reduceValue = [date timeIntervalSince1970];
    
    long value = (nowValue-reduceValue  ) ;
    
    if(value <  60){
        return time = dateStr;
    }
    
    NSInteger day = 60 * 60 * 24 ;
    NSInteger hour = 60 * 60 ;
    NSInteger minute = 60 ;
    
    NSInteger days = value / day ;
    NSString *str = @"发布于";
    
    if(days > 0){
        str = [NSString stringWithFormat:@"%@%ld天",str,(long)days];
    }
    
    long hours = (value % day)/hour ;
    if(hours > 0){
        str = [NSString stringWithFormat:@"%@%ld小时",str,hours];
    }
    
    NSInteger minutes = (value%day)%hour;
    
    str = [NSString stringWithFormat: @"%@%ld分钟前",str,(long)(minutes/minute)];
    
    return str;
}

/*
 * 计算内容所占UILabel的宽度
 */
+(CGFloat)labelWidth:(NSString *) contentText withFont:(UIFont *) font {
    CGSize titleSize = [contentText sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    return titleSize.width ;
}

/*
 * 计算内容所占UILabel的高度
 */
+(CGFloat)cellHeight:(NSString*)contentText withWidth:(CGFloat)with withFont:(UIFont *) font {
    CGSize size =[contentText sizeWithFont:font constrainedToSize:CGSizeMake(with, 300000.0f)];
    CGFloat height = size.height + 0.;
    return height;
}
+ (CGFloat)imageViewHeightWithImages:(NSArray *)images {
    
    if (images && images.count > 0) {
        
        if (images.count == 1) {
            return 150;
        } else if (images.count <= 4 && images.count != 3) {
            
            return (ScreenWidth - 75)/2 * ((images.count+1)/2) + (images.count-1)/2 *5;
        }
        else {
            CGFloat imageWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 70;
            
            CGFloat imageViewHeight = (imageWidth - 10)/3.0;
            CGFloat _imageViewHeight = 0.0;
            if (images.count % 3) {
                
                if (images.count > 3) {
                    NSInteger rowCount = images.count / 3;
                    if(images.count %3 > 0)
                    {
                        rowCount ++;
                    }
                    _imageViewHeight = imageViewHeight *(rowCount) + (rowCount - 1) * 5;
                }
                else {
                    _imageViewHeight = imageViewHeight;
                }
                
            }
            else {
                
                if (images.count > 3) {
                    NSInteger rowCount = images.count / 3.0;
                    if(images.count %3 > 0)
                    {
                        rowCount ++;
                    }
                    _imageViewHeight = imageViewHeight *(rowCount) + (rowCount - 1) * 5;
                }
                
                else
                {
                    _imageViewHeight = imageViewHeight;
                }
            }
            
            return _imageViewHeight;
        }
    }
    else {
        return 0;
    }
}

/*
 * 字符串的排序
 */
+(NSString *) stingSort:(NSMutableDictionary *)sortDic {
    NSMutableArray *sortAry = [[NSMutableArray alloc]init];
    NSMutableString *muString = [[NSMutableString alloc]init];
    NSArray *keys = [sortDic allKeys];
    for (NSString *key in keys) {
        [sortAry addObject:[NSString stringWithFormat:@"%@=%@",key,[sortDic objectForKey:key]]];
    }
    NSArray *sortedArray = [sortAry sortedArrayUsingSelector:@selector(compare:)];
    //参数排序字符串
    for (NSString *param in sortedArray) {
        [muString appendString:[NSString stringWithFormat:@"%@&",param]];
    }
    //除去组合字符串后的最后一个&符号
    NSString *parStr = [muString substringToIndex:([muString length]-1)];
    return parStr;
}

/*
 * 图片背景的拉伸处理
 */
+(UIImage *) getImageScale:(NSString *) imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
}





+ (void)checkFileWithURLString:(NSString *)logoString withImageView:(UIImageView *)imageView withDirector:(NSString *)director withDefaultImage:(NSString *)defaultImage
{
    if (logoString == nil || [logoString isEqualToString:@""])
    {
        [imageView setImage:[UIImage imageNamed:defaultImage]];
        return;
    }
    NSString *directoryPath = [FILE_PATH stringByAppendingString:[NSString stringWithFormat:@"/%@",director]];
    BOOL isDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [directoryPath stringByAppendingString:[NSString stringWithFormat:@"/%@",logoString.lastPathComponent]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [imageView setImage:[UIImage imageWithContentsOfFile:filePath]];
    }
    else
    {
        NSString *picUrlString =@""; //[NSString stringWithFormat:@"%@%@",FILESERVER,logoString];
        if ([logoString hasPrefix:@"http"]||[logoString hasPrefix:@"www."]) {
            picUrlString=logoString;
        }
        else
        {
            picUrlString=[NSString stringWithFormat:@"%@%@",FILESERVER,logoString];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                       {
                           NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrlString]];
                           if (data != nil)
                           {
                               [data writeToFile:filePath atomically:YES];
                               dispatch_sync(dispatch_get_main_queue(), ^(void)
                                             {
                                                 [imageView setImage:[UIImage imageWithData:data]];
                                             });
                           }
                           else
                           {
                               [imageView setImage:[UIImage imageNamed:defaultImage]];
                           }
                       });
    }
}

+ (BOOL)checkFileWithURLStringOnly:(NSString *)logoString withImageView:(UIImageView *)imageView withDirector:(NSString *)director withDefaultImage:(NSString *)defaultImage
{
    BOOL flag = NO;
    if (logoString == nil || [logoString isEqualToString:@""])
    {
        if(defaultImage.length > 0)
        {
            [imageView setImage:[UIImage imageNamed:defaultImage]];
        }
        else
        {
            [imageView setImage:[UIImage imageFromColor:[UIColor colorWithHex:0xf1f1f1 alpha:1.0f]]];
        }
        return flag;
    }
    NSString *directoryPath = [FILE_PATH stringByAppendingString:[NSString stringWithFormat:@"/%@",director]];
    BOOL isDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [directoryPath stringByAppendingString:[NSString stringWithFormat:@"/%@",logoString.lastPathComponent]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        @autoreleasepool
        {
//            __block UIImageView *backImageView = imageView;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*2.0f),
//                           dispatch_get_main_queue(), ^{[backImageView setImage:[UIImage imageWithContentsOfFile:filePath]];});

            [imageView setImage:[UIImage imageWithContentsOfFile:filePath]];
        }
    }
    else
    {
        if(defaultImage.length > 0)
        {
            [imageView setImage:[UIImage imageNamed:defaultImage]];
        }
        else
        {
            [imageView setImage:[UIImage imageFromColor:[UIColor colorWithHex:0xf1f1f1 alpha:1.0f]]];
        }
        
        flag = YES;
    }
    
    return flag;
}

/*
 * 获取当前日期
 */
+ (NSString *)getCurrentDate
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSLog(@"locationString:%@",locationString);
    return locationString;
}

/*
 * 创建ListFilter.plist文件
 */
+ (void)createFilterListPlistFile
{
    NSString *directoryPath = @"后面的宏";//[FILE_PATH stringByAppendingString:[NSString stringWithFormat:@"/%@", CACHEROOT_FILE_PATH]];
    BOOL isDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [directoryPath stringByAppendingString:[NSString stringWithFormat:@"/%@",@"ListFilter.plist"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
}
/*
 * 保存ListFilter.plist文件
 */
+ (void)savePlist:(NSArray *)data path:(NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *rootDir = @"后面的宏";//[NSString stringWithFormat:@"%@/%@", documentDirectory, CACHEROOT_FILE_PATH];
    NSString *filePath = [rootDir stringByAppendingPathComponent:path];
    [data writeToFile:filePath atomically:YES];
}

+ (NSArray *)getPlist:(NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *rootDir = @"后面的宏";//[NSString stringWithFormat:@"%@/%@", documentDirectory, CACHEROOT_FILE_PATH];
    NSString *filePath = [rootDir stringByAppendingPathComponent:path];
    NSArray* plistArray = [[NSArray alloc]initWithContentsOfFile:filePath];
    return plistArray;
}

+ (void)timerFireMethod:(NSTimer *)theTimer showControl:(UILabel *)showControl endTimeStr:(NSString *)endTimeStr startTimeStr:(NSString *)startTimeStr timeStart:(BOOL)timeStart
{
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *endTime = [[NSDateComponents alloc] init];    //初始化目标时间
    NSDate *today = [NSDate date];    //得到当前时间
    NSDate *date = [NSDate dateWithTimeInterval:60 sinceDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    static int year;
    static int month;
    static int day;
    static int hour;
    static int minute;
    static int second;
    //从NSDate中取出年月日，时分秒，但是只能取一次
    if(timeStart)
    {
        year = [[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[dateString substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[dateString substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[dateString substringWithRange:NSMakeRange(17, 2)] intValue];
    }
    
    NSArray *endTimeArray = [endTimeStr componentsSeparatedByString:@":"];
    
    if(endTimeArray && endTimeArray.count < 3)
    {
        [endTime setYear:year];
        [endTime setMonth:month];
        [endTime setDay:day];
        [endTime setHour:[endTimeArray[0] integerValue]];
        [endTime setMinute:[endTimeArray[1] integerValue]];
        [endTime setSecond:0];
    }
    NSDate *todate = [cal dateFromComponents:endTime]; //把目标时间装载入date
    
    //用来得到具体的时差，是为了统一成北京时间
    unsigned int unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    NSString *xiaoShi = [NSString stringWithFormat:@"%ld", (long)[d hour]];
    if([d hour] < 10)
    {
        xiaoShi = [NSString stringWithFormat:@"0%ld",(long)[d hour]];
    }
    NSString *fen = [NSString stringWithFormat:@"%ld", (long)[d minute]];
    if([d minute] < 10)
    {
        fen = [NSString stringWithFormat:@"0%ld",(long)[d minute]];
    }
    NSString *miao = [NSString stringWithFormat:@"%ld", (long)[d second]];
    if([d second] < 10)
    {
        miao = [NSString stringWithFormat:@"0%ld",(long)[d second]];
    }
    
    if(([d second] <= 0) && ([d minute] <= 0) && ([d hour] <= 0))
    {
        [theTimer invalidate];
        showControl.text = @"当天已过期";
    }
    else
    {
        showControl.text = [NSString stringWithFormat:@"%@:%@:%@",xiaoShi, fen, miao];
    }
}

+ (NSString *) jsonStringWithString:(NSString *) string
{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+ (NSString *) jsonStringWithArray:(NSArray *)array
{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (NSString *valueObj in array) {
        //NSString *value = [self jsonStringWithString:valueObj];
        if (valueObj) {
            [values addObject:[NSString stringWithFormat:@"%@",valueObj]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                          mutabilityOption:NSPropertyListImmutable
                                                                    format:NULL
                                                          errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}
/*
 *url参数解析 [{key:username,Value:王不二},{key:password,Value:12345}]
 */
+(NSMutableDictionary *)formatParamWithParamStr:(NSString *)paramStr
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSArray *oneArr=[paramStr componentsSeparatedByString:@"?"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];

    if (oneArr.count>1) {
    
        NSString *realParamsStr=oneArr[1];
        NSArray *key_ValueArr=[realParamsStr componentsSeparatedByString:@"&"];
                for (int i=0; i<key_ValueArr.count; i++) {
        NSString *towStr=key_ValueArr[i];
        NSArray *towArr=[towStr componentsSeparatedByString:@"="];
            
        //NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:towArr[0],@"key",towArr[1],@"value",nil];
            [dic setObject:towArr[1] forKey:towArr[0]];
       // [arr addObject:dic];
        }
    }
    return dic;
}
/*
 *url参数填充 {key:username,Value:王不二}
 */
+(NSMutableArray *)setParamValueWithParamStr:(NSMutableArray *)paramArr
{
    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:paramArr];
    
   // UserElement *userEle=[[SharedUserDefault sharedInstance] getUserInfo];
    
    for (int i=0; i<paramArr.count; i++) {
        NSMutableDictionary *paramDic=paramArr[i];
        /*
        if([[paramDic objectForKey:@"key"] isEqualToString:webParaMemberId]&&[[paramDic objectForKey:@"value"]isEqualToString:webParaMemberId]){
            [paramDic setObject:userEle.memberId forKey:@"value"];
        }
        if([[paramDic objectForKey:@"key"] isEqualToString:webParaTrueName]&&[[paramDic objectForKey:@"value"]isEqualToString:webParaTrueName]){
            [paramDic setObject:userEle.nickName forKey:@"value"];
        }
        if([[paramDic objectForKey:@"key"] isEqualToString:webParaCityId]&&[[paramDic objectForKey:@"value"] isEqualToString:webParaCityId]){
            NSString* cityId = [WGPublicData sharedInstance].currentHotCityInfo.areaId;
            [paramDic setObject:cityId forKey:@"value"];
        }
        if([[paramDic objectForKey:@"key"] isEqualToString:webParaUserCode]&&[[paramDic objectForKey:@"key"] isEqualToString:webParaUserCode]){
            [paramDic setObject:userEle.userCode forKey:@"value"];
        }
        if([[paramDic objectForKey:@"key"] isEqualToString:webParaMobile]&&[[paramDic objectForKey:@"key"] isEqualToString:webParaMobile]){
            if (userEle.mobile.length>1) {
                [paramDic setObject:userEle.mobile forKey:@"value"];
            }
            else{
                [paramDic setObject:userEle.userCode forKey:@"value"];
            }
        }
        if([[paramDic objectForKey:@"key"] isEqualToString:webParaisBiz]&&[[paramDic objectForKey:@"key"] isEqualToString:webParaisBiz]){
            [paramDic setObject:kisBiz forKey:@"value"];
        }
        */
    }
    return arr;
}

/*
 *url参数增加 有不加  没有的加 [{key:username,Value:王不二},{}]
 */
+(NSMutableArray *)addParamValueWithOldParamArr:(NSMutableArray *)paramArr AndTargetArr:(NSMutableArray *)targetArr
{
    /*
     #define webParaMemberId @"memberId"//用户ID
     #define webParaTrueName @"trueName"//用户真实姓名
     #define webParaNickName @"nickName"//用户昵称
     #define webParaCityId @"cityId"//城市ID
     #define webParaUserCode @"userCode"//用户手机
     #define webParaisBiz @"isBiz"//是否是商家端（或是否的导游）
     */
    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:paramArr];
    
    if (!targetArr||targetArr.count<1) {
        return arr;
    }
    
   // UserElement *userEle=[[SharedUserDefault sharedInstance] getUserInfo];
    
    for (int j=0; j<targetArr.count; j++) {
        NSString *keyStr=targetArr[j];
        BOOL hasFound=NO;
        for (int i=0; i<paramArr.count; i++) {
            NSMutableDictionary *paramDic=paramArr[i];
            if([[paramDic objectForKey:@"key"] isEqualToString:keyStr]){
                hasFound=YES;
                break;
            }
        }
        if (!hasFound) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",keyStr, nil];
            /*
            if([keyStr isEqualToString:webParaMemberId]){
                [dic setObject:webParaMemberId forKey:@"key"];
                [dic setObject:userEle.memberId forKey:@"value"];
            }
            if([keyStr isEqualToString:webParaNickName]){
                [dic setObject:webParaNickName forKey:@"key"];
                [dic setObject:userEle.nickName forKey:@"value"];
            }
            if([keyStr isEqualToString:webParaTrueName]){
                [dic setObject:webParaTrueName forKey:@"key"];
                [dic setObject:userEle.trueName forKey:@"value"];
            }
            if([keyStr isEqualToString:webParaMobile]){
                [dic setObject:webParaMobile forKey:@"key"];
                if (userEle.mobile.length>1) {
                    [dic setObject:userEle.mobile forKey:@"value"];
                }
                else{
                    [dic setObject:userEle.userCode forKey:@"value"];
                }
                
                
            }
            if([keyStr isEqualToString:webParaCityId]){
                NSString* cityId = [WGPublicData sharedInstance].currentHotCityInfo.areaId;
                [dic setObject:webParaCityId forKey:@"key"];
                [dic setObject:cityId forKey:@"value"];
            }
            if([keyStr isEqualToString:webParaUserCode]){
                [dic setObject:webParaUserCode forKey:@"key"];
                [dic setObject:userEle.userCode forKey:@"value"];
            }
            if([keyStr isEqualToString:webParaisBiz]){
                [dic setObject:webParaisBiz forKey:@"key"];
                [dic setObject:kisBiz forKey:@"value"];
            }
            */
            [arr addObject:dic];
        }
        
    }
    return arr;
}
/*
 *url参数拼接 拼接成 XX=XX&XX=XX格式
 */
+(NSString *)formatUrlParamWithParamArr:(NSMutableArray *)paramArr
{
    if (!paramArr) {
        return @"";
    }
    NSMutableString *paramstr=[NSMutableString string];
    if (paramArr.count==1) {
        NSDictionary *dic=paramArr[0];
        
        paramstr=[NSMutableString stringWithFormat:@"%@=%@",dic[@"key"],dic[@"value"]];
        return paramstr;
    }
    else
    {
        for (int i=0; i<paramArr.count-1; i++) {
            NSDictionary *dicc=paramArr[i];
            [paramstr appendFormat:@"%@=%@&",dicc[@"key"],dicc[@"value"]];
            
        }
        NSDictionary *dic=paramArr[paramArr.count-1];
        [paramstr appendFormat:@"%@=%@",dic[@"key"],dic[@"value"]];
        
    }
    
    return paramstr;
}
//
+ (CGFloat)systemVersion {
    static CGFloat _version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _version = [[UIDevice currentDevice].systemVersion floatValue];
    });
    return _version;
}

+ (BOOL)canUsePhotiKit {
    return [self systemVersion] >= 8.0;
}
+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self showMessageAlertWithTitle:title message:message actionTitle:@"确定" actionHandler:nil];
}

+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle {
    [self showMessageAlertWithTitle:title message:message actionTitle:actionTitle actionHandler:nil];
}

+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle actionHandler:(void (^ __nullable)())actionHandler {
    //IOS8.0及以后，采用UIAlertController
    if ([ConUtils systemVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action;
        if (actionHandler) {
            action = [UIAlertAction actionWithTitle:actionTitle
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                actionHandler();
                                            }];
        }else {
            action = [UIAlertAction actionWithTitle:actionTitle
                                              style:UIAlertActionStyleCancel
                                            handler:nil];
        }
        
        [alertController addAction:action];
        
        [[self mostFrontViewController] presentViewController:alertController animated:YES completion:nil];
        
    }
    
}

+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message yesTitle:(NSString *)yesTitle yesAction:(void (^ __nullable)())yesAction {
    [self showConfirmAlertWithTitle:title message:message yesTitle:yesTitle yesAction:yesAction cancelTitle:@"取消" cancelAction:nil];
}

+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message yesTitle:(NSString *)yesTitle yesAction:(void (^ __nullable)())yesAction cancelTitle:(NSString *)cancelTitle cancelAction:(void (^ __nullable)())cancelAction {
    [self showConfirmAlertWithTitle:title message:message firstActionTitle:yesTitle firstAction:yesAction secondActionTitle:cancelTitle secondAction:cancelAction];
}

+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message firstActionTitle:(NSString *)firstActionTitle firstAction:(void (^ __nullable)())firstAction secondActionTitle:(NSString *)secondActionTitle secondAction:(void (^ __nullable)())secondAction {
    //IOS8.0及以后，采用UIAlertController
    if ([ConUtils systemVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:firstActionTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           if (firstAction)
                                                               firstAction();
                                                       }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:secondActionTitle
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction *action) {
                                                            if (secondAction)
                                                                secondAction();
                                                        }];
        
        [alertController addAction:action];
        [alertController addAction:action2];
        
        [[self mostFrontViewController] presentViewController:alertController animated:YES completion:nil];
        
    }
}
+ (UIViewController *)mostFrontViewController {
    /*
    UIViewController *vc = [self rootViewController];
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    return vc;
     */
    UIViewController *vc=[WGPublicData sharedInstance].currentViewController;
    return vc;
}
+(NSString *)formatUrlStr:(NSString *)UrlStr
{
    NSString * urlStr =[UrlStr stringByReplacingOccurrencesOfString:@"%"withString:@".+."];
    
    NSString*  finalyUrl=[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    finalyUrl=[finalyUrl stringByReplacingOccurrencesOfString:@".+." withString:@"%"];
    
    return finalyUrl;
}
@end
