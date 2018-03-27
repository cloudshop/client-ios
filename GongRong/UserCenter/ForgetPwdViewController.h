//
//  ForgetPwdViewController.h
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


enum Forget_Type {
    loginForget=0,
    walletForget,
    
} ;

@interface ForgetPwdViewController : BaseViewController<UITextFieldDelegate>
{

    
    UITextField *accountText;
    UITextField *verifyText;
    
    BOOL isUserPhoneType;
    
    
    
    NSTimer *timer;
    int time;
    UIButton *verifyCodeBtn;
    
}
@property(nonatomic ,assign)enum Forget_Type forgetType;

@end
