//
//  LoginViewController.m
//  iVMS-C-MCU1.0
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 hikvision. All rights reserved.
//

#import "LoginViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
#import "AddressViewController.h"
#import "ResourceListViewController.h"
#import "Mcu_sdk/MCUVmsNetSDK.h"

@interface LoginViewController ()
<
UITextFieldDelegate
>

@end

@implementation LoginViewController {
    UITextField     *g_userNameField;/**< 用户名输入框*/
    UITextField     *g_passwordField;/**< 密码输入框*/
}

#pragma mark - UIViewController life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:MSP_USERNAME];
    NSString *password = [defaults objectForKey:MSP_PASSWORD];
    if (userName) {
        g_userNameField.text = userName;
    }
    if (password) {
        g_passwordField.text = password;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - initUI
- (void)initUI {
    [self.view setBackgroundColor:kAppColor7];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_background"]];
    [self.view addSubview:backgroundImage];
    
    UIImageView *headImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_logo"]];
    [self.view addSubview:headImage];
    
    g_userNameField = [UITextField new];
    [g_userNameField setBackground:[UIImage imageNamed:@"login_fieldBackground"]];
    
    UIView *userNameLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 44)];
    g_userNameField.leftView = userNameLeftView;
    UIImageView *userNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_username"]];
    [userNameLeftView addSubview:userNameImageView];
    [userNameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameLeftView).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(14, 17));
        make.centerY.equalTo(userNameLeftView);
    }];
    g_userNameField.leftViewMode = UITextFieldViewModeAlways;
    g_userNameField.tag = 1000;
    g_userNameField.returnKeyType = UIReturnKeyNext;
    g_userNameField.delegate = self;
    [g_userNameField setTextColor:[UIColor whiteColor]];
    g_userNameField.font = [UIFont systemFontOfSize:14.0f];
    g_userNameField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入用户名" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view addSubview:g_userNameField];
    
    g_passwordField = [UITextField new];
    g_passwordField.delegate = self;
    [g_passwordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    g_passwordField.tag = 2000;
    [g_passwordField setBackground:[UIImage imageNamed:@"login_fieldBackground"]];
    [g_passwordField setTextColor:[UIColor whiteColor]];
    g_passwordField.secureTextEntry = YES;
    g_passwordField.returnKeyType = UIReturnKeyDone;
    g_passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    g_passwordField.font = [UIFont systemFontOfSize:14.0f];
    g_passwordField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIView *passwordLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 44)];
    g_passwordField.leftView = passwordLeftView;
    UIImageView *passwordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_password"]];
    [passwordLeftView addSubview:passwordImageView];
    [passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLeftView).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(14, 17));
        make.centerY.equalTo(passwordLeftView);
    }];
    g_passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:g_passwordField];
    
    UIButton *loginButton = [UIButton new];
    [loginButton setBackgroundColor:[UIColor whiteColor]];
    loginButton.layer.cornerRadius = 2.0f;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitleColor:UIColorWithHex(0x0093FF) forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    UIButton *setButton = [[UIButton alloc]init];
    [setButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setLoginAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setButton];
    
#pragma mark  添加关闭按钮
    UIButton *closeBT=[UIButton buttonWithType:UIButtonTypeCustom];
    closeBT.frame=Rect(10, StatusBarHeight+15, 25, 25);
    closeBT.backgroundColor=[UIColor clearColor];
    [closeBT setImage:[UIImage imageNamed:@"clearPhoneNBIMG"] forState:UIControlStateNormal];
    [self.view addSubview:closeBT];
    [closeBT addTarget:self action:@selector(closeCurrent) forControlEvents:UIControlEventTouchUpInside];
    
    [closeBT mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(30);
    }];
    
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.edges.equalTo(self.view);
    }];
    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(81);
    }];
    
    [g_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImage.mas_bottom).with.offset(60);
        make.size.mas_equalTo(CGSizeMake(280, 44));
        make.centerX.equalTo(self.view);
    }];
    
    [g_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(g_userNameField.mas_bottom).with.offset(10);
        make.size.equalTo(g_userNameField);
        make.centerX.equalTo(self.view);
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(g_passwordField.mas_bottom).with.offset(28);
        make.size.mas_equalTo(CGSizeMake(280, 44));
        make.centerX.equalTo(self.view);
    }];
    
    [setButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-20);
        make.bottom.equalTo(self.view).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
}
-(void)closeCurrent
{
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - Custom Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (IPHONE4) {
        [UIView animateWithDuration:0.3f animations:^{
            self.view.bounds = CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height);
        }completion:^(BOOL finish){
            
        }];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.view.bounds = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height);
        }completion:^(BOOL finish){
            
        }];
    }
    return YES;
}

/**
 *  点击return按钮后执行的方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1000) {
        [g_passwordField becomeFirstResponder];
    }else if(textField.tag == 2000){
        //        [_userNameField becomeFirstResponder];
        [self loginButtonClicked];
    }
    return YES;
}

#pragma mark - Event response
/**
 *  点击设置登录地址
 */
- (void)setLoginAddress {
    [self.view endEditing:YES];
    self.navigationController.navigationBarHidden = NO;
    AddressViewController *addressController = [[AddressViewController alloc]init];
    [self.navigationController pushViewController:addressController animated:YES];
}

#pragma mark ---点击登录按钮
/**
 *  点击登录按钮
 */
- (void)loginButtonClicked {
    [self.view endEditing:YES];
    [self frameUndo];
    
    if (g_userNameField.text.length == 0 || g_passwordField.text.length == 0) {
        //用户名密码不能为空
        [SVProgressHUD showErrorWithStatus:@"用户名或密码不能为空"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:delayTime];
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:g_userNameField.text forKey:MSP_USERNAME];
    [defaults setObject:@"" forKey:MSP_PASSWORD];
    [defaults synchronize];
    NSString *loginAddress = [defaults objectForKey:MSP_ADDRESS];
    if ([loginAddress isEqualToString:@""] || !loginAddress) {
        [SVProgressHUD showErrorWithStatus:@"请先输入登录地址"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:delayTime];
        return;
    }
    NSString *passwordMD5 = g_passwordField.text;
    if (passwordMD5.length < 32) {
        passwordMD5 = [self getMD5String:passwordMD5];
    }
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    //调用 登录平台接口,完成登录操作
    //注意:登录密码必须是经过MD5加密的
    [[MCUVmsNetSDK shareInstance] loginMspWithUsername:g_userNameField.text password:passwordMD5 success:^(id responseDic){
        NSInteger result = [responseDic[@"status"] integerValue];
        if (result == 200) {
            [SVProgressHUD dismiss];
            [defaults setObject:g_userNameField.text forKey:MSP_USERNAME];
            [defaults setObject:passwordMD5 forKey:MSP_PASSWORD];
            [defaults synchronize];
            [self jumpToRootView];//跳转到主界面
        } else {
            //返回码为200,代表登录成功.返回码为202,203,204时,分别代表的意思是初始密码登录,密码强度不符合要求,密码过期.这三种情况都需要修改密码.请开发者使用当前账号登录BS端平台,按要求进行密码修改后,再进行APP的开发测试工作.其他返回码,请根据平台返回提示信息进行提示或处理
            [SVProgressHUD showErrorWithStatus:responseDic[@"description"]];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:delayTime];
        }
    }failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器连接失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:delayTime];
    }];
}

/**
 *  点击空白地方结束编辑事件
 */
- (void)tap {
    [self.view endEditing:YES];
    [self frameUndo];
}

#pragma mark - Private Method
/**
 *  MD5加密
 *
 *  @param str 登录密码
 *
 *  @return 加密后的字符串
 */
-(NSString *)getMD5String:(NSString *)str{
    const char *cstr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [result appendFormat:@"%02X",digest[i]];
    }
    return result;
}

/**
 *  上移还原
 */
- (void)frameUndo {
    [UIView animateWithDuration:0.3f animations:^{
        self.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }completion:^(BOOL finish){
        
    }];
}

/**
 *  跳转到主界面
 */
- (void)jumpToRootView {
    ResourceListViewController *resourceList = [[ResourceListViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:resourceList];
    [self presentViewController:nav animated:NO completion:nil];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= 32 && string.length > range.length) {
        return NO;
    }
    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField{
    if (textField.markedTextRange == nil && textField.text.length > 32) {
        textField.text = [textField.text substringToIndex:20];
    }
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
