//
//  UserLoadViewController.h
//  Booking
//
//  Created by 1 on 11-12-31.
//  Copyright (c) 2011年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "BaseViewController.h"

#import "UserElement.h"

#import "SVProgressHUD.h"

@interface UserLoadViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *accountField;
    UITextField *pwdField;
    
  //  HttpRequestComm *requestComm;
    
  //  LoginResponse *loginResponse;
    
   
    
    //UIActivityIndicatorView *indicatorView;
}

@property (assign,nonatomic) BOOL loginTag;
@property (nonatomic, copy) NSString *nameofBC;
@property (nonatomic,strong) UserElement *userElement;

@end
