//
//  NSArray+OrNil.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (OrNil)

- (id)objectOrNilAtIndex:(NSUInteger)index;

@end
