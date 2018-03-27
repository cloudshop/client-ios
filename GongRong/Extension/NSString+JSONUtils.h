//
//  NSString+JSONUtils.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONUtils)

- (id)objectFromJSONString;
- (id)mutableObjectFromJSONString;

- (id)objectFromJSONStringWithError:(NSError **)error;
- (id)mutableObjectFromJSONStringWithError:(NSError **)error;

+ (NSString *)JSONString:(id)object;
+ (NSString *)prettyJSONString:(id)object;

@end

@interface NSData (JSONUtils)

// The NSData MUST be UTF8 encoded JSON.
- (id)objectFromJSONData;
- (id)objectFromJSONDataWithError:(NSError **)error;

- (id)mutableObjectFromJSONData;
- (id)mutableObjectFromJSONDataWithError:(NSError **)error;

@end

@interface NSDictionary (JSONUtils)

- (NSString *)JSONString;
- (NSString *)prettyJSONString;

@end

@interface NSArray (JSONUtils)

- (NSString *)JSONString;
- (NSString *)prettyJSONString;

@end
