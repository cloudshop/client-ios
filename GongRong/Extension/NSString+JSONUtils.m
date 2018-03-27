//
//  NSString+JSONUtils.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "NSString+JSONUtils.h"

@implementation NSString(JSONUtils)

- (id)objectFromJSONString
{
    return [self objectFromJSONStringWithError:nil];
}

- (id)mutableObjectFromJSONString
{
    return [self mutableObjectFromJSONStringWithError:nil];
}

- (id)objectFromJSONStringWithError:(NSError **)error
{
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id     JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:error];
    
    return JSONObject;
}

- (id)mutableObjectFromJSONStringWithError:(NSError **)error
{
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id     JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:error];
    
    return JSONObject;
}

+ (NSString *)JSONString:(id)object
{
    if (!object) {
        return nil;
    }
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

+ (NSString *)prettyJSONString:(id)object
{
    if (!object) {
        return nil;
    }
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

@end

@implementation NSData (JSONUtils)

- (id)objectFromJSONData
{
    return [self objectFromJSONDataWithError:nil];
}

- (id)objectFromJSONDataWithError:(NSError **)error
{
    id JSONObject = [NSJSONSerialization JSONObjectWithData:self options:0 error:error];
    
    return JSONObject;
}

- (id)mutableObjectFromJSONData
{
    return [self mutableObjectFromJSONDataWithError:nil];
}

- (id)mutableObjectFromJSONDataWithError:(NSError **)error
{
    id JSONObject = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:error];
    
    return JSONObject;
}

@end

@implementation NSDictionary (JSONUtils)

- (NSString *)JSONString
{
    return [NSString JSONString:self];
}

- (NSString *)prettyJSONString
{
    return [NSString prettyJSONString:self];
}

@end

@implementation NSArray (JSONUtils)

- (NSString *)JSONString
{
    return [NSString JSONString:self];
}

- (NSString *)prettyJSONString
{
    return [NSString prettyJSONString:self];
}

@end