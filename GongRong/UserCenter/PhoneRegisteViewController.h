//
//  PhoneRegisteViewController.h
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpBaseRequest.h"
#import "BaseViewController.h"


@interface PhoneRegisteViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *nickName;
    UITextField *trueName;
    
    UITextField *phoneNum;
    UITextField *verificationCode;
    UITextField *password;
    UITextField *confirmPwd;
    UITextField *inviteCode;
    
    
    UIAlertController *typeAct;
    
    UIButton *protocalBtn;
    
    
    BOOL isAgreeProtocal;
    
   
    
    NSTimer *timer;
    int time;
    UIButton *verifyCodeBtn;
    
    //UIActivityIndicatorView *indicator;
}
@end
