//
//  SJScanningView.h
//  SJQRCode
//
//  Created by Sunjie on 16/11/15.
//  Copyright © 2016年 Sunjie. All rights reserved.
//
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/** 按钮的类型 */
typedef NS_ENUM(NSInteger, SJButtonType){
    SJButtonTypeReturn = 1,
    SJButtonTypeAlbum,
    SJButtonTypeTorch,
};

@protocol SJScanningViewDelegate <NSObject>

/** 按钮的点击事件的代理 */
- (void)clickBarButtonItemSJButtonType:(SJButtonType)type;

@end

@interface SJScanningView : UIView

/** 是否授权 */
@property (nonatomic, assign) BOOL isRestrict;
@property (nonatomic, assign) id<SJScanningViewDelegate> scanningDelegate;

/** 设置动画 */
- (void)scanning;
/** 移除动画 */
- (void)removeScanningAnimations;

@end
