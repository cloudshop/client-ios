//
//  ForgetNextStepViewController.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ForgetNextStepViewController.h"
//#import "Configuration.h"
#import "UserLoadViewController.h"
#import "NSString+CheckUserInfo.h"

@interface ForgetNextStepViewController ()
{
    UIButton *loadBtn;
    UIView *backView;
    NSString *verifyCode;
}
@end

@implementation ForgetNextStepViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUserAccount:(NSString*)userAccount AndVerifyCode:(NSString *)code
{
    if (self = [super init]) {
        accountNumber = userAccount;
        verifyCode=code;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle];
    [self.viewNaviBar setTitle:@"找回密码"];
     [self.viewNaviBar setLogInMode];
    self.view.backgroundColor= UIColorWithHex(0xf4f4f4);
    
    [self initTextInfo];
    //[self createBackView];
    
    loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, ScreenWidth-20, 44)];
    loadBtn.backgroundColor=kAppColor1;
    loadBtn.layer.cornerRadius=5;
    [loadBtn setTitle:@"完成" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(finishFindPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
	// Do any additional setup after loading the view.
}
-(void)createBackView
{
    for(int i=0;i<2;i++)
    {
        double h = 44;
        double y = 94+i*(h+10);
        backView=[[UIView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, h)];
        backView.backgroundColor=[UIColor whiteColor];
        backView.tag=100+i;
        [self.view addSubview:backView];
        
        if(backView.tag==100)
        {
            [backView addSubview:pwdText];
        }
        if(backView.tag==101)
        {
            [backView addSubview:confirmPwdText];
        }
    }
}

- (void)initTextInfo
{
    
    pwdText = [[UITextField alloc] initWithFrame:CGRectMake(10, 94, ScreenWidth-20, 40)];
    [self setTextField:pwdText withPlaceholder:@"请输入6-16位密码" withSecure:YES];
    [self.view addSubview:pwdText];
    
    confirmPwdText = [[UITextField alloc] initWithFrame:CGRectMake(10, 94+50, ScreenWidth-20, 40)];
    [self setTextField:confirmPwdText withPlaceholder:@"请确认您的密码" withSecure:YES];
    [self.view addSubview:confirmPwdText];
}

- (void)setTextField:(UITextField*)textField withPlaceholder:(NSString*)title withSecure:(BOOL)isSecure
{
    textField.placeholder = title;
    textField.font = [UIFont systemFontOfSize:14];
    textField.returnKeyType = UIReturnKeyDone;
    textField.backgroundColor=RGB(244, 244, 244);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    if (isSecure)
    {
        textField.secureTextEntry = YES;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)finishFindPwd:(id)sender
{
    [self.view endEditing:YES];
    if ([self checkUserPwdInfo])
    {
        if (![ConUtils checkUserNetwork])
        {
            [self showToast:@"网络连接不可用，请稍后再试！"];
        }
        else
        {
            [SVProgressHUD show];
            loadBtn.userInteractionEnabled = NO;
          //  [HttpRequestComm findPassWord:[[pwdText text] md5] andUserCount:accountNumber withDelegate:self];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:verifyCode forKey:@"code"];
            [dic setObject:[[pwdText text] md5]forKey:@"pwd"];
            [dic setObject:accountNumber forKey:@"phone"];
            HttpBaseRequest *req=[[HttpBaseRequest alloc]initWithDelegate:self];
            [req initRequestComm:dic withURL:FIND_PWDCODE operationTag:FINDPWDCODE];
            
        }
    }
}

- (BOOL)checkUserPwdInfo
{
    if ([pwdText text] == nil || [[pwdText text] isEqualToString:@""])
    {
        [self showToast:@"请输入6-16个字符"];
        return NO;
    }
    else
    {
        if ([[pwdText text] length] <6 || [[pwdText text] length] > 16)
        {
            [self showToast:@"请输入6-16个字符"];
            return NO;
        }
    }
    
    if ([confirmPwdText text] == nil || [[confirmPwdText text] isEqualToString:@""])
    {
        [self showToast:@"两次输入密码不一致"];
        return NO;
    }
    else
    {
        
        if (![[confirmPwdText text] isEqualToString:[pwdText text]])
        {
            confirmPwdText.text=@"";
            pwdText.text=@"";
            [self showToast:@"两次输入密码不一致"];
            return NO;
        }
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark HttpRequestCommDelegate
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    //[indicator stopAnimating];
    loadBtn.userInteractionEnabled = YES;
    //NSLog(@"修改密码返回内容：%@,%@",inParam,[[inParam objectForKey:@"result"] objectForKey:@"msg"]);
    if (inParam == nil)
    {
        [self showToast:@"网络异常，请稍后再试"];
    }
    else
    {
        if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
        {
            [self showToast:@"修改密码成功,即将跳往登陆页面"];
            [self performSelector:@selector(backLogin) withObject:nil afterDelay:2];
        }
        else
        {
            [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
        }
    }
}

- (void)backLogin
{
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index - 2)] animated:YES];
}
//网络请求失败协议方法
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    //[indicator stopAnimating];
    loadBtn.userInteractionEnabled = YES;
    [self showToast:NO_NETWORK_TEXT];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == pwdText) {
        if (textField.text.length >= 16 && string.length > 0) {
            return NO;
        }
    }
    if (textField == confirmPwdText) {
        if (textField.text.length >= 16 && string.length > 0) {
            return NO;
        }
    }
    return YES;
}
- (void)popViewController
{
    [SVProgressHUD dismiss];
    [super popViewController];
}

@end
