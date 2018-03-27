//
//  ForgetNextStepViewController.h
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"


@interface ForgetNextStepViewController : BaseViewController<UITextFieldDelegate>
{
    //TextFiledBackgroundView *backgroundView;
    
    UITextField *pwdText;
    UITextField *confirmPwdText;
    
    NSString *accountNumber;
    
    //UIActivityIndicatorView *indicator;
}

- (id)initWithUserAccount:(NSString*)userAccount AndVerifyCode:(NSString *)code;
@end
