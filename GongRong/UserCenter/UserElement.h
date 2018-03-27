//
//  UserElement.h
//  Booking
//
//  Created by wihan on 14-10-17.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 * 用户信息数据模型
 */
@interface UserElement : NSObject

@property (strong, nonatomic) NSString *userCode ;
@property (strong, nonatomic) NSString *sessionId ;
@property (strong, nonatomic) NSString *memberId ;
@property (strong, nonatomic) NSString *nickName ;
@property (strong, nonatomic) NSString *contact;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *logoUrl ;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *inviteCode;
@property (strong, nonatomic) NSString *trueName;
@property (strong, nonatomic) NSString *personsign;
@property (strong, nonatomic) NSString *trade;
@property (strong, nonatomic) NSString *marriage;
@property (strong, nonatomic) NSString *userStar;
@property (strong, nonatomic) NSString *passWord;
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *userQQ;
@property (strong, nonatomic) NSMutableArray *imgs;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *degree;
@property (strong, nonatomic) NSString *verifyStatus;
@property (strong, nonatomic) NSString *remindSet;
@property (strong, nonatomic) NSString *acceptPartyNum;
@property (strong, nonatomic) NSString *collectCount;
@property (strong, nonatomic) NSString *contactsNum;
@property (strong, nonatomic) NSString *joinPartyNum;
@property (strong, nonatomic) NSString *mentorMobile;
@property (strong, nonatomic) NSString *praisetCount;
@property (strong, nonatomic) NSString *servicePerpleNum;
@property (strong, nonatomic) NSString *sid;
@property (strong, nonatomic) NSString *tradeId;

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *homeplace ;
@property (strong, nonatomic) NSString *school;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *identityUrlP;
@property (strong, nonatomic) NSString *identityUrlA;
@property (strong, nonatomic) NSString *mentorShopName;
@property (strong, nonatomic) NSString *accno;
@property (strong, nonatomic) NSString *isMentor;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *couponUsed;
@property (strong, nonatomic) NSString *hasNoPropertyPwd;


@property (nonatomic,strong)NSString * headImgUrl;
@property (nonatomic,strong)NSString *idStr;
@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSString * nickname;
@property (nonatomic,strong)NSString * token;
@property (nonatomic,strong)NSString *userTypeName;//用户类型
@property (nonatomic,strong)NSString *studyCourseCount;//正在学习的统计
@property (nonatomic,strong)NSNumber *membershipPoint;//获得积分统计
@property (nonatomic,strong)NSString *faCode;//工号
@property (nonatomic,strong)NSString *subCompany;//分公司
@property (nonatomic,strong)NSString *branches;//支公司
@property (nonatomic,strong)NSString *phone;//手机号

@end
