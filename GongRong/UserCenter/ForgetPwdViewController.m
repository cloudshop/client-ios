//
//  ForgetPwdViewController.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ForgetNextStepViewController.h"
#import "NSString+CheckUserInfo.h"
#import "ConUtils.h"

@interface ForgetPwdViewController ()
{
    UIButton *loadBtn;
    UIView *backView;
}
@end

@implementation ForgetPwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self.viewNaviBar setLogInMode];
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle];
    if(!self.titleStr)
    {
    [self.viewNaviBar setTitle:@"找回密码"];
    }
    else{
     [self.viewNaviBar setTitle:self.titleStr];
    }
    self.view.backgroundColor= UIColorWithHex(0xf4f4f4);
    
    time = 59;
    
    isUserPhoneType = YES;
    
    [self initTextInfo];
    //[self createBackView];
    loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 204, ScreenWidth-20, 44)];
    loadBtn.layer.cornerRadius=5;
    loadBtn.backgroundColor=kAppColor1;
    [loadBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
}
-(void)keyBoardHidden
{
    [accountText resignFirstResponder];
    [verifyText resignFirstResponder];
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
            [backView addSubview:accountText];
        }
        if(backView.tag==101)
        {
            UILabel *proSeperateLine = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100, 0, 1, 44)];
            [proSeperateLine setBackgroundColor:kAppColor8];
            [backView addSubview:proSeperateLine];
            
            verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [verifyCodeBtn setFrame:CGRectMake(ScreenWidth-100, 5, 100, 40)];
            [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [verifyCodeBtn addTarget:self action:@selector(queryVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
            [verifyCodeBtn setTitleColor:kAppColor1 forState:UIControlStateNormal];
            [verifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [backView addSubview:verifyCodeBtn];
            [backView addSubview:verifyText];
        }
    }
}
- (void)initTextInfo
{
    accountText = [[UITextField alloc] initWithFrame:CGRectMake(10, 94, ScreenWidth-20, 40)];
    accountText.keyboardType = UIKeyboardTypeNumberPad;
    [self setTextField:accountText withPlaceholder:@"请输入您绑定的手机号" withSecure:NO];
    [self.view addSubview:accountText];
    
    verifyText = [[UITextField alloc] initWithFrame:CGRectMake(10, 94+50, ScreenWidth*0.6, 40)];
    verifyText.keyboardType = UIKeyboardTypeNumberPad;
    [self setTextField:verifyText withPlaceholder:@"请输入验证码" withSecure:NO];
    [self.view addSubview:verifyText];
    
    verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyCodeBtn setFrame:CGRectMake(ScreenWidth*0.6+20, 94+50, ScreenWidth*0.4-30, 40)];
    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifyCodeBtn setBackgroundImage:[UIImage imageNamed:@"myorder_button_disabled"] forState:UIControlStateNormal];
    [verifyCodeBtn addTarget:self action:@selector(queryVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [verifyCodeBtn setTitleColor:kAppColor1 forState:UIControlStateNormal];
    [verifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    verifyCodeBtn.layer.borderWidth=0.5;
    verifyCodeBtn.layer.borderColor=[kAppColor1 CGColor];
    [self.view addSubview:verifyCodeBtn];
}

- (void)setTextField:(UITextField*)textField withPlaceholder:(NSString*)title withSecure:(BOOL)isSecure
{
    textField.placeholder = title;
    textField.font = [UIFont systemFontOfSize:14];
    textField.delegate = self;
    textField.backgroundColor=RGB(244, 244, 244);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.returnKeyType = UIReturnKeyDone;
    if (isSecure)
    {
        textField.secureTextEntry = YES;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)nextStep:(id)sender
{
    [self.view endEditing:YES];
    if ([accountText text] == nil || [[accountText text] isEqualToString:@""])
    {
        [self showToast:@"请输入绑定的手机号或邮箱"];
        return;
    }
    if ([verifyText text] == nil || [[verifyText text] isEqualToString:@""])
    {
        [self showToast:@"请输入正确的验证码"];
        return;
    }
    if (![ConUtils checkUserNetwork])
    {
        [self showToast:@"网络连接不可用，请稍后再试！"];
    }
    else
    {
        
        ForgetNextStepViewController *controller = [[ForgetNextStepViewController alloc] initWithUserAccount:[accountText text] AndVerifyCode:verifyText.text];
        [self.navigationController pushViewController:controller animated:YES];
        return;
        
        //[indicator startAnimating];
        [SVProgressHUD show];
        loadBtn.userInteractionEnabled = NO;
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:[accountText text] forKey:@"userCode"];
        [mulDic setObject:[verifyText text] forKey:@"verify"];
        HttpBaseRequest *request=[[HttpBaseRequest alloc]initWithDelegate:self];
        [request initRequestComm:mulDic withURL:USER_VERIFYCODE operationTag:USERVERIFYCODE];
       // [HttpRequestComm checkVerifyCode:mulDic withDelegate:self];
    }
}
- (void)queryVerifyCode:(id)sender
{
    [self.view endEditing:YES];
    //判断用户输入的类型
    if ([accountText text] == nil || [[accountText text] isEqualToString:@""])
    {
        [self showToast:@"请输入绑定的手机号"];
    }
    else
    {
        if (![[accountText text] checkUserPhoneNumber]) {
            [self showToast:@"请输入绑定的手机号"];
            return;
        }
        [SVProgressHUD show];
        if (self.forgetType==loginForget) {
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];

        [mulDic setObject:[accountText text] forKey:@"phone"];
        
        HttpBaseRequest *request=[[HttpBaseRequest alloc]initWithDelegate:self];
        [request initRequestComm:mulDic withURL:USER_SMSCODE operationTag:USERSMSCODE];
        }
        else if (self.forgetType==walletForget)
        {
            NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
            [mulDic setObject:[accountText text] forKey:@"userCode"];
            [mulDic setObject:@"0" forKey:@"type"];
            [mulDic setObject:[accountText text] forKey:@"mobile"];
            [mulDic setObject:@"0" forKey:@"method"];
          //  [HttpRequestComm getVerifyCode:mulDic withDelegate:self];
        }
    }
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

- (void)popViewController
{
    [timer invalidate];
    [SVProgressHUD dismiss];
    [super popViewController];
}

- (void)verifyCodding
{
    [verifyCodeBtn setUserInteractionEnabled:NO];
    [verifyCodeBtn setTitle:[NSString stringWithFormat:@"重新获取%d",time] forState:UIControlStateNormal];
    time -=1;
    if (time == 0)
    {
        [verifyCodeBtn setUserInteractionEnabled:YES];
        [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        time = 59;
        [timer invalidate];
    }
}

# pragma mark HttpRequestCommDelegate
//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    BaseResponse *resp=[[BaseResponse alloc]init];
    [resp setHeadData:inParam];

    switch (tagId) {
        case USERVERIFYCODE:
            if (inParam == nil)
            {
                //数据库返回内容为空时
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                if (resp.code==0) {
                    [timer invalidate];
                    verifyCodeBtn.userInteractionEnabled = YES;
                    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                 //   ForgetNextStepViewController *controller = [[ForgetNextStepViewController alloc] initWithUserAccount:[accountText text]];
                 //   [self.navigationController pushViewController:controller animated:YES];
                }
                else
                {
                    [self showToast:resp.message];
                }
            }
            break;
        case 122:
            loadBtn.userInteractionEnabled = YES;
            if (inParam == nil)
            {
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
                {
                    [timer invalidate];
                    verifyCodeBtn.userInteractionEnabled = YES;
                    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                 //   ForgetNextStepViewController *controller = [[ForgetNextStepViewController alloc] initWithUserAccount:[accountText text]];
                 //   [self.navigationController pushViewController:controller animated:YES];
                }
                else
                {
                    [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
                }
            }
            break;
        
        case USERSMSCODE:
        {
            if (inParam == nil)
            {
                //数据库返回内容为空时
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                
                
                if (resp.code == 0)
                {
                    //验证码下发成功
                    [self showToast:@"验证码下发成功"];
                    // [verifyResponse setResultData:inParam];
                }else
                {
                    //验证码下发失败
                    [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
                    [verifyCodeBtn setUserInteractionEnabled:YES];
                    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    time = 59;
                    [timer invalidate];
                }
                
            }
        }
            break;
   
        default:
            break;
    }
}

//网络请求失败协议方法
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    switch (tagId) {
        case 121:
            [self showToast:NO_NETWORK_TEXT];
            break;
        case 122:
            loadBtn.userInteractionEnabled = YES;
            [self showToast:NO_NETWORK_TEXT];
            break;
            
        default:
            break;
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}


@end
