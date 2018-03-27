//
//  NSMutableDictionary+OrNil.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (OrNil)

- (void)setObjectOrNil:(id)anObject forKey:(id <NSCopying>)aKey;

@end
