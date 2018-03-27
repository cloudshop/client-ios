//
//  NSArray+OrNil.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "NSArray+OrNil.h"

@implementation NSArray (OrNil)

- (id)objectOrNilAtIndex:(NSUInteger)index
{
    id object = nil;
    
    if (index < [self count]) {
        object = [self objectAtIndex:index];
    }
    
    return object;
}

@end
