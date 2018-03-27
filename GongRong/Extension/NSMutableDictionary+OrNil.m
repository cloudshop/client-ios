//
//  NSMutableDictionary+OrNil.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "NSMutableDictionary+OrNil.h"

@implementation NSMutableDictionary (OrNil)

- (void)setObjectOrNil:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
