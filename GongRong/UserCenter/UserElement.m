//
//  UserElement.m
//  Booking
//
//  Created by wihan on 14-10-17.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#import "UserElement.h"

/*
 * 用户信息数据模型
 */
@implementation UserElement

- (NSString *)memberId
{
    if(_memberId.length > 0)
    {
        return _memberId;
    }
    return @"";
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    [aCoder encodeObject:self.sessionId forKey:@"sessionId"];
    [aCoder encodeObject:self.memberId forKey:@"memberId"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.contact forKey:@"contact"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.logoUrl forKey:@"logoUrl"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.inviteCode forKey:@"inviteCode"];
    [aCoder encodeObject:self.personsign forKey:@"personsign"];
    [aCoder encodeObject:self.trade forKey:@"trade"];
    [aCoder encodeObject:self.trueName forKey:@"trueName"];
    [aCoder encodeObject:self.marriage forKey:@"marriage"];
    [aCoder encodeObject:self.userStar forKey:@"userStar"];
    [aCoder encodeObject:self.passWord forKey:@"passWord"];
    [aCoder encodeObject:self.degree forKey:@"degree"];
    [aCoder encodeObject:self.userQQ forKey:@"userQQ"];
    [aCoder encodeObject:self.imgs forKey:@"imgs"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.age forKey:@"age"];
    [aCoder encodeObject:self.verifyStatus forKey:@"verifyStatus"];
    [aCoder encodeObject:self.remindSet forKey:@"remindSet"];
    [aCoder encodeObject:self.acceptPartyNum forKey:@"acceptPartyNum"];
    [aCoder encodeObject:self.collectCount forKey:@"collectCount"];
    [aCoder encodeObject:self.contactsNum forKey:@"contactsNum"];
    [aCoder encodeObject:self.joinPartyNum forKey:@"joinPartyNum"];
    [aCoder encodeObject:self.mentorMobile forKey:@"mentorMobile"];
    [aCoder encodeObject:self.praisetCount forKey:@"praisetCount"];
    [aCoder encodeObject:self.servicePerpleNum forKey:@"servicePeopleNum"];
    [aCoder encodeObject:self.sid forKey:@"sid"];
    [aCoder encodeObject:self.tradeId forKey:@"tradeId"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.homeplace forKey:@"homeplace"];
    [aCoder encodeObject:self.school forKey:@"school"];
    [aCoder encodeObject:self.company forKey:@"company"];
    [aCoder encodeObject:self.identityUrlP forKey:@"identityUrlP"];
    [aCoder encodeObject:self.identityUrlA forKey:@"identityUrlA"];
    [aCoder encodeObject:self.mentorShopName forKey:@"mentorShopName"];
    [aCoder encodeObject:self.accno forKey:@"accno"];
    [aCoder encodeObject:self.isMentor forKey:@"isMentor"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:self.couponUsed forKey:@"couponUsed"];
    [aCoder encodeObject:self.hasNoPropertyPwd forKey:@"hasNoPropertyPwd"];
    
    
   
    [aCoder encodeObject:self.idStr forKey:@"idStr"];
    [aCoder encodeObject:self.headImgUrl forKey:@"headImgUrl"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.userTypeName forKey:@"userTypeName"];
    
    [aCoder encodeObject:self.studyCourseCount forKey:@"studyCourseCount"];
    [aCoder encodeObject:self.membershipPoint forKey:@"membershipPoint"];
    [aCoder encodeObject:self.faCode forKey:@"faCode"];
    [aCoder encodeObject:self.subCompany forKey:@"subCompany"];
    [aCoder encodeObject:self.branches forKey:@"branches"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userCode = [aDecoder decodeObjectForKey:@"userCode"];
        self.sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
        self.memberId= [aDecoder decodeObjectForKey:@"memberId"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.contact = [aDecoder decodeObjectForKey:@"contact"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.logoUrl = [aDecoder decodeObjectForKey:@"logoUrl"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.trueName = [aDecoder decodeObjectForKey:@"trueName"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.inviteCode = [aDecoder decodeObjectForKey:@"inviteCode"];
        self.trade=[aDecoder decodeObjectForKey:@"trade"];
        self.personsign=[aDecoder decodeObjectForKey:@"personsign"];
        self.marriage=[aDecoder decodeObjectForKey:@"marriage"];
        self.userStar=[aDecoder decodeObjectForKey:@"userStar"];
        self.passWord=[aDecoder decodeObjectForKey:@"passWord"];
        self.birthday=[aDecoder decodeObjectForKey:@"birthday"];
        self.userQQ=[aDecoder decodeObjectForKey:@"userQQ"];
        self.imgs=[aDecoder decodeObjectForKey:@"imgs"];
        self.age=[aDecoder decodeObjectForKey:@"age"];
        self.verifyStatus=[aDecoder decodeObjectForKey:@"verifyStatus"];
        self.acceptPartyNum=[aDecoder decodeObjectForKey:@"acceptPartyNum"];
        self.collectCount=[aDecoder decodeObjectForKey:@"collectCount"];
        self.contactsNum=[aDecoder decodeObjectForKey:@"contactsNum"];
        self.joinPartyNum=[aDecoder decodeObjectForKey:@"joinPartyNum"];
        self.mentorMobile=[aDecoder decodeObjectForKey:@"mentorMobile"];
        self.praisetCount=[aDecoder decodeObjectForKey:@"praisetCount"];
        self.servicePerpleNum=[aDecoder decodeObjectForKey:@"servicePeopleNum"];
        self.sid=[aDecoder decodeObjectForKey:@"sid"];
        self.tradeId=[aDecoder decodeObjectForKey:@"tradeId"];
        
        self.address=[aDecoder decodeObjectForKey:@"address"];
         self.degree=[aDecoder decodeObjectForKey:@"degree"];
        self.homeplace=[aDecoder decodeObjectForKey:@"homeplace"];
        self.school=[aDecoder decodeObjectForKey:@"school"];
        self.company=[aDecoder decodeObjectForKey:@"company"];
        self.identityUrlP=[aDecoder decodeObjectForKey:@"identityUrlP"];
        self.identityUrlA=[aDecoder decodeObjectForKey:@"identityUrlA"];
        self.mentorShopName=[aDecoder decodeObjectForKey:@"mentorShopName"];
        self.accno=[aDecoder decodeObjectForKey:@"accno"];
        self.isMentor=[aDecoder decodeObjectForKey:@"isMentor"];
        self.remark=[aDecoder decodeObjectForKey:@"remark"];
        self.couponUsed=[aDecoder decodeObjectForKey:@"couponUsed"];
        self.hasNoPropertyPwd=[aDecoder decodeObjectForKey:@"hasNoPropertyPwd"];
        
        
        
        self.headImgUrl = [aDecoder decodeObjectForKey:@"headImgUrl"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.idStr=[aDecoder decodeObjectForKey:@"idStr"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.userTypeName = [aDecoder decodeObjectForKey:@"userTypeName"];
       
        self.studyCourseCount = [aDecoder decodeObjectForKey:@"studyCourseCount"];
        self.membershipPoint = [aDecoder decodeObjectForKey:@"membershipPoint"];
        self.faCode = [aDecoder decodeObjectForKey:@"faCode"];
       
         self.faCode = [aDecoder decodeObjectForKey:@"faCode"];
         self.subCompany = [aDecoder decodeObjectForKey:@"subCompany"];
         self.branches = [aDecoder decodeObjectForKey:@"branches"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}

@end
