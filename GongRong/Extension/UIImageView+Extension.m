//
//  UIImageView+Extension.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (id)initWithImageNamed:(NSString *)name
{
    return [self initWithImage:[UIImage imageNamed:name]];
}

- (void)setImageNamed:(NSString *)name
{
    [self setImageNamed:name useImageSize:NO];
}

- (void)setImageNamed:(NSString *)name useImageSize:(BOOL)useImageSize
{
    UIImage *image = [UIImage imageNamed:name];
    [self setImage:image];
    if (useImageSize == YES) {
        CGRect ivFrame = self.frame;
        ivFrame.size = image.size;
        [self setFrame:ivFrame];
    }
}


- (void)useImageSize
{
    CGRect ivFrame = self.frame;
    ivFrame.size = self.image.size;
    [self setFrame:ivFrame];
}

@end
