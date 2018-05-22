//
//  HttpRequestField.h
//  Booking
//
//  Created by wihan on 14-10-16.
//  Copyright (c) 2014年 Bluecreate. All rights reserved.
//

#ifndef Booking_HttpRequestField_h
#define Booking_HttpRequestField_h
#import "GongRong.pch"

#if GR_DEBUG

//测试服务器地址
#define Web_BASEURLPATH  @"http://cloud.eyun.online:8888"
//#define Web_BASEURLPATH  @"http://www.grjf365.com/#/"
//#define BASEURLPATH @"http://app.grjf365.com:9080/"
#define BASEURLPATH @"http://app.grjf365.com/"
//#define BASEURLPATH  @"http://cloud.eyun.online:9080/"
//#define Web_BASEURLPATH @"http://192.168.1.110:1111"  // 建北电脑
//#define Web_BASEURLPATH  @"http://192.168.1.109:8888"//敬敬电脑
//#define BASEURLPATH  @"http://192.168.1.96:9080/"//国文电脑电脑

//#define FILESERVER @"http://106.3.78.236:8086/fileserver"//图片文件服务器
#define FILESERVER  @"http://leifeng365.oss-cn-shanghai.aliyuncs.com"


#define FILESERVERORI  @"http://106.3.78.236:8092/fileserver/web"

#define FILESERVERUPLOAD @"http://101.200.161.26:81"
//#define FILESERVER @"http://192.168.1.204:9080/weigee"
//#define FILESERVER @"http://192.168.1.144:9080/file"

#define BASEWALLETSERVER  @"http://101.200.161.26:81/account/"

#define BASEPAYSERVER  @"http://101.200.161.26:81/"
#define FileImage @"http://106.3.78.236:8092/fileserver/web/"


#define PAYBASEURLPATH @"http://pay.weigee.net"//支付接口

#define PAYKEYWORLD @"vR4Sap"
#define MERCHID @"ee789a1a-34c6-4a3c-9a99-6d9f20052ad6"


#else

//正式服务器地址

#define BASEURLPATH @"http://app.grjf365.com/"
//#define BASEURLPATH @"http://leifeng365.com:81"
#define Web_BASEURLPATH  @"http://app.grjf365.com"
//#define BASEWALLETSERVER  @"http://account.weigee.net/account/"
#define BASEWALLETSERVER  @"http://leifeng365.com:81/account/"

#define BASEPAYSERVER  @"http://leifeng365.com:81/"

//#define FILESERVER @"http://file.weigee.net/web"//高清大图
#define FILESERVER  @"http://leifeng365.oss-cn-shanghai.aliyuncs.com"




#define FILESERVERUPLOAD  @"http://leifeng365.com:81"
//#define FILESERVERUPLOAD @"http://192.168.0.111:8080/service-main"

#define PAYBASEURLPATH @"http://pay.weigee.net"
#define PAYKEYWORLD @"wAg296"
#define MERCHID  @"a5bfac64-dd25-459f-b01c-8ec0fa7566a7"

#endif //WG_DEBUG



//接口请求的子路径
#define Get_bannerList @"banner/list"//获取banner、活动列表
#define Push_Sign @"signrecord/sign" //签到
#define Get_SignHistory @"signrecord/sign_of_week" //获取一周签到记录
#define Get_RecordList @"membership_point/list"//积分明细
#define User_type_List @"user/user_type_array"//获取用户类型列表
#define USER_LOGIN @"api/auth/login/app" //用户登录

#define USER_LOGOUT @"user/logout" //退出登入
//#define USER_REGISTER @"/mobileUser/register.cmd" //用户注册
#define USER_REGISTER @"uaa/api/register"//注册
#define USER_SMSCODE @"verify/api/verify/smscode" //用户通过手机号获取验证码
#define User_Modify_Phone @"user/modify_phone_code"//变更手机号 获取验证码
#define User_Verify_phone @"user/verify_phone" //变更手机号

#define USER_SENDPWDCODE @"/mobileUser/sendPwdCode.cmd" //用户找回密码或绑定手机邮箱，获取验证码
#define USER_VERIFYCODE @"/mobileUser/verify.cmd" //找回用户密码或绑定手机邮箱，验证验证码

#define FIND_PWDCODE @"user/forgotPwd" //找回密码，修改密码
#define FIND_PWDSUCCEED @"/user/findPwd.cmd"
//#define FIND_PWDCODE @"/user/sendPwdCode.cmd"
#define USER_GetUserInfo @"user/userinfo" //获取用户信息
#define USER_UPDATE @"user/modify" //修改用户信息
//#define USER_UPDATEPWD @"/mobileUser/updatePwd.cmd" //修改会员密码
#define USER_UPDATEPWD @"/user/updatePwd.cmd" //修改会员密码

#define Wallets_User @"wallet/api/wallets/user"//钱包账户
#define Oreder_deposit @"order/api/dep-orders/deposit"//  创建充值订单
#define Get_CitysList @"dict/api/cities"//获取城市列表
#define Get_CourseDetialList @"course/list"//获取科目下课程列表
#define ReGet_Videourl @"course/refresh_url"//重新获取视频的URl
#define Get_AttachmentUrl  @"course/attachment_url"//获取课件资源地址
#define Submit_StudyRecord @"studyrecord/save"//提交视频学习时长

#define Collect_Course @"coursetype/favorite" //收藏科目
#define Collect_Attachment @"course/favorite" //收藏课程




#define COMMIT_SUGGESTION @"/user/feedback.cmd" //意见反馈
#define CONFIRM_ORDER @"/robOrder/confirm.cmd" //确认订单
//#define UPLOAD_FILE @"/uploadImg.cmd" //上传文件
//#define UPLOAD_FILE @"/UploadAppImg.cmd"
//#define UPLOAD_FILE @"/uploadfile/UploadAppImg.cmd"
#define UPLOAD_FILE @"upload"
//#define UPLOAD_SERVICEIMG @"/fileserver/uploadImg.cmd" //上传服务套餐等图片
#define MY_MESSAGE @"/mobileCommon/listNews.cmd" //我的消息
#define PAY_SUBURL @"/gateway/index.cmd"
#define SUBMIT_COMMENT @"/order/addEvaluate.cmd" //评论的提交

#define QUERY_EVALUATE @"/order/queryEvaluate.cmd" //评论内容查询
#define SHOP_NOTICE @"/mobileCommon/queryMemberNotice.cmd"  //用户获取商家接单的信息
#define VERSION_CHECK @"/appmanager/api/version/ios"  //版本信息检测
#define PUSH_REGISTE_DEVICE @"/push/registerDevice.cmd"   //推送服务设备信息注册
#define ARRIVE_PAY  @"/order/arrivePay.cmd"     //到店支付

#define LIST_NEWS @"/user/ListNews.cmd"//消息列表

#define Delete_My_Party @"/party/SubmitDelMyParty.cmd"//删除我的局
#define Submit_Evaluate @"/order/evaluate/review.cmd"//评价订单


//#define List_Member_Collect @"/user/ListFriend.cmd"//我的好友列表
#define FRIEND_LIST @"/user/ListFriend.cmd"//我的好友列表
#define ATTENTION_LIST @"/user/ListMemberCollect.cmd"//我的关注列表
#define FANS_LIST @"/user/ListCollectedMember.cmd"//我的粉丝列表

#define LIST_SERVICEPEOPLE @"/user/ListServicePeople.cmd"//服务过的人

#define LIST_CONTACT @"/user/ListContact.cmd"//我的人脉圈

#define REMOVE_REGISTERUSER @"/party/RefuseJoin.cmd"//删除已报名参加活动的用户
#define PLACE_COMEPERSON @"/user/ListHasCame.cmd"//他们来过
#define CHECK_ADDRESS @"/user/uploadContact.cmd"//通讯录联系人校验
#define SUBMIT_MEMBER_IMG  @"/user/SubmitMemberImg.cmd"//用户上传相册
#define SUBMIT_BOOK @"/order/create.cmd"//提交预定


#define REQUESTDYNMICDETIAL @"/dynamic/GetDynamicDetail.cmd" //动态详情

#define CALLPHONESERVER  @"/calllogs/submitCalllogs.cmd"//拨打电话记录




#define GET_MENTER_ITEMLIST @"/user/mentor/itemList.cmd"//获取系统服务项目列表


#define Order_Check @"/order/check.cmd"//订单支付前校验

#define USER_WALLET_SMSCODE @"/user/sendVerifyCode.cmd" //用户通过手机号获取钱包验证码

#define GET_TOKEN @"auth/token/get.do" //获取token值
//Http请求接口标识
enum HTTPREQUESTTAG
{
    
    USERLOGIN = 0,
    GetBannerList,//banner列表、活动列表
    PushSign, //签到
    GetSignHistory, //获取一周签到记录
    GetRecordList,//积分明细
    UsertypeList,//获取用户类型列表
    USERSMSCODE, //用户通过手机号获取验证码
    UserModifyPhone,//变更手机号 获取验证码
    UserVerifyphone, //变更手机号
    USERVERIFYCODE,//忘记密码的时候重置密码，校验验证码
    FINDPWDCODE, //找回密码，修改密码
    GetproductDetial,//获取产品详情
    USERREGISTER,//注册
    USERGetUserInfo ,//获取用户信息
    USERUPDATE, //修改用户信息

    RecommendCourseType,//推荐科目列表
    WalletsUser,//获取钱包账户
    Orederdeposit,//  创建充值订单
     GetCitysList,//获取城市列表
   
    
    USERUPDATEPWD,
    USERLOGOUT,
    BUSINESSLIST,
    SHOPNEARLIST,
    FINDROOMLIST,
    ROBORDER,
    ROBORDERLIST,
    ROBORDERLIST0,
    ROBORDERLIST1,
    ROBORDERLIST2,
    ROBORDERLIST3,
    ROBORDERDETAIL,
        UPLOADFILE,
   // UPLOADSERVICEIMG,
    MYORDERDETAIL,
    MYMESSAGE,
    PAYCONST,
    MYORDERLIST0,
    MYORDERLIST1,
    MYORDERLIST2,
    MYORDERLIST3,
    SUBMITCOMMENT,
    PAYMETHOD,
    QUERYEVALUATE,
    SHOPNOTICE,
    VERSIONCHECK,
    PUSHREGISTEDEVICE,
    ARRIVEPAY,

    
      ATTENTIONLIST,//我的关注列表
   

    
// new == = = = = == = = == = = = = = = = = =
    SERVERINTRODUCED,  //服务介绍
  
    REQUEST_DYNMICDETIAL, //动态详情
    
    
    
    
    //钱包的服务器不一样
    SETWALLETPASSWORLD=2000,  //设置钱包支付密码
   
    

    
};

//请求类型， 区别于钱包还是普通
typedef enum : NSUInteger{
    normalRequest=0,
    walletRequest
} RequestType;



//接口请求常量
#define USERCODE @"userCode"
#define PASSWORD @"passWord"
#define NEWPWD @"newPwd"
#define SID @"sid"
#define CITY @"city"
#define LATITUDE @"latitude"
#define LONGITUDE @"longitude"
#define INDEX @"index"
#define PAGESIZE @"pageSize"
#define TYPE @"type"
#define SHOPID @"shopId"
#define MEMBERID @"memberId"
#define PROVINCEID @"provinceId"
#define ROBTYPE @"robType"
#define VOLUMEID @"volumeId"
#define ARRIVETIME @"arriveTime"
#define CONSUMDURATION @"consumDuration"
#define CONSUMINTERVAL @"consumInterval"
#define CONSUMDATE @"consumDate"
#define ADDRESS @"address"
#define OFFERPRICE @"offerPrice"
#define CONTRACT @"contract"
#define MOBILE @"mobile"
#define SHOPTYPE @"shopType"
#define PARTYID @"partyId"
#define BUSINESSAREAID @"businessAreaId"
#define RANG @"rang"
#define GOODS @"goods"
#define APPOINTSHOPID @"appointShopId"
#define STATUS @"status"
#define ROBID @"robId"
#define ORDERRESOURCE @"orderResource"
#define ENDTIME @"endTime"
#define LEAVEWORD @"leaveWord"
#define TOTALPRICE @"totalPrice"
#define GOODSNAME @"goodsName"
#define TOPTYPE @"topType"
#define BRIEF @"brief"
#define ISCOST @"isCost"

//For V2.0
#define RANGETYPE @"rangeType"
#define SHOPTYPE @"shopType"
#define SORTTYPE @"sortType"
#define PAGE @"page"
#define ISEVALUATE @"isEvaluate"
#define SERVICEID @"serviceId"
#define ACTUALLYPAID @"actuallyPaid"
#define GOODSTYPE @"goodsType"
#define COSTTYPE @"costtype"
#define CITYID @"cityId"
#define SHOPSNAME @"shopsName"
#define ORDERID @"orderId"
#define ORDERTYPE @"orderType"
#define VID @"vid"
#define CONSUMINTERVAL @"consumInterval"
#define STARTTIME @"startTime"
#define ENDTIME @"endTime"
#define AMOUNTS @"amounts"
#define DETAILJSON @"detailJson"
#define KEYWORD @"keyword"
#define ROOMTYPE @"roomType"
#define ISSEND @"isSend"
#define ISMAIN @"isMain"
#define CONSUMDURATION @"consumDuration"
#define ISBIZ @"isBiz"

//For V6.0
#define PARTYID @"partyId"
#define SERVICENAME @"serviceName"
#define JOINNUM @"joinNum"
#define CONTENT @"content"
#define INFOTYPE @"infoType" //1是人 5是商品
#define INFOID @"infoId"

#define REMARK @"remark"

#endif
