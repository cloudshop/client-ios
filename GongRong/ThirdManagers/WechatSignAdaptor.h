//
//  WechatSignAdaptor.h
//  智云网校
//
//  Created by Apple on 2017/6/22.
//  Copyright © 2017年 bwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WechatSignAdaptor : NSObject


@property (nonatomic,strong) NSMutableDictionary *dic;

- (instancetype)initWithWechatAppId:(NSString *)wechatAppId
                        wechatMCHId:(NSString *)wechatMCHId
                            tradeNo:(NSString *)tradeNo
                   wechatPartnerKey:(NSString *)wechatPartnerKey
                           payTitle:(NSString *)payTitle
                           orderNo :(NSString *)orderNo
                           totalFee:(NSString *)totalFee
                           deviceIp:(NSString *)deviceIp
                          notifyUrl:(NSString *)notifyUrl
                          tradeType:(NSString *)tradeType;

///创建发起支付时的SIGN签名(二次签名)
- (NSString *)createMD5SingForPay:(NSString *)appid_key
                        partnerid:(NSString *)partnerid_key
                         prepayid:(NSString *)prepayid_key
                          package:(NSString *)package_key
                         noncestr:(NSString *)noncestr_key
                        timestamp:(UInt32)timestamp_key;

@end
