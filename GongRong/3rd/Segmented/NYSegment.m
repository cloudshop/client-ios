//
//  NYSegment.m
//  WGSDK
//
//  Created by wihan on 14-11-3.
//  Copyright (c) 2014年 WeiGe. All rights reserved.
//

#import "NYSegment.h"

static CGFloat const kMinimumSegmentWidth = 68.0f;

@implementation NYSegment

- (instancetype)initWithTitle:(NSString *)title {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.titleLabel.text = title;
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.titleLabel = [[UILabel alloc] initWithFrame:self.frame];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 2)];
        self.lineView.backgroundColor=[UIColor colorWithRed:101.0/255 green:94.0/255 blue:230.0/255 alpha:1.0];
        [self addSubview:self.lineView];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize sizeThatFits = [self.titleLabel sizeThatFits:size];
    return CGSizeMake(MAX(sizeThatFits.width * 1.4f, kMinimumSegmentWidth), sizeThatFits.height);
}

@end
