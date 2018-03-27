//
//  NSMutableArray+OrNil.m
//  Booking
//
//  Created by alankong on 15/7/27.
//  Copyright (c) 2015年 Bluecreate. All rights reserved.
//

#import "NSMutableArray+OrNil.h"

@implementation NSMutableArray (OrNil)

- (void)addObjectOrNil:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

@end
