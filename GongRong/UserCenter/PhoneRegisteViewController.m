//
//  PhoneRegisteViewController.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "PhoneRegisteViewController.h"
#import "GetuiManager.h"
//#import "MailRegisteViewController.h"
#import "NSString+CheckUserInfo.h"
#import "ConUtils.h"
//#import "UserProtocalViewController.h"

//#import "WGRegisterViewController.h"
//#import "WGRegisterSuccessViewController.h"

#import "WGPublicData.h"
//#import "LoginResponse.h"
#import "UserElement.h"


@interface PhoneRegisteViewController ()<HttpRequestCommDelegate,UIActionSheetDelegate>
{
    UIButton *registeBtn;
    UIView *backView;
    UIScrollView *backScrollerView;
   // LoginResponse *loginResponse;
    UserElement *userElement;
}
@property (nonatomic,strong)NSMutableDictionary *userDict;

@end

@implementation PhoneRegisteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle];
    [self.viewNaviBar setTitle:@"注册"];
    [self.viewNaviBar setLogInMode];
    self.view.backgroundColor= kAppColorBackground;//UIColorWithHex(0xf4f4f4);
    self.automaticallyAdjustsScrollViewInsets = NO;
    time = 59;
   
   
    isAgreeProtocal = YES;
    [self craeteScrollerView];
    [self initRegisteInfo];
    [self createBackground];
    
	// Do any additional setup after loading the view.
}

-(void)craeteScrollerView
{
    backScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    backScrollerView.showsHorizontalScrollIndicator=YES;
    backScrollerView.showsVerticalScrollIndicator=NO;
    backScrollerView.contentSize=CGSizeMake(ScreenWidth, ScreenHeight+90);
    [self.view addSubview:backScrollerView];
}
-(void)createBackground
{
    NSArray *titleArr=@[@"姓名",@"昵称",@"手机号",@"密码",@"确认密码",@"验证码",@"邀请码"];
    float BTTop=44+14;
    for(int i=0;i<7;i++)
    {
        double h = 44;
        double y = 30+i*(h+10);
        BTTop=y+44+14;
        backView=[[UIView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, h)];
        backView.backgroundColor=[UIColor whiteColor];
        backView.tag=100+i;
        [backScrollerView addSubview:backView];
        
        UILabel *titleLB=[[UILabel alloc]initWithFrame:Rect(30,12 , 50, 30)];
        titleLB.font=[UIFont systemFontOfSize:14];
        titleLB.text=titleArr[i];
        titleLB.textColor=kAppColor5;
        [titleLB sizeToFit];
        [backView addSubview:titleLB];
        titleLB.left=30;
        titleLB.centerY=22;
        
        if(backView.tag==100)
        {
            [backView addSubview:trueName];
            trueName.left=titleLB.right+30;
        }
        if(backView.tag==105)
        {
            UILabel *proSeperateLine = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100, 0, 1, 44)];
            [proSeperateLine setBackgroundColor:kAppColorSeparate];
            [backView addSubview:proSeperateLine];
            
            verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [verifyCodeBtn setFrame:CGRectMake(ScreenWidth-100, 5, 100, 40)];
            [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [verifyCodeBtn addTarget:self action:@selector(queryVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
            [verifyCodeBtn setTitleColor:kAppColor1 forState:UIControlStateNormal];
            [verifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [backView addSubview:verifyCodeBtn];
            [backView addSubview:verificationCode];
            verificationCode.size=Size(ScreenWidth-verifyCodeBtn.width-titleLB.right, verificationCode.height);
            verificationCode.left=titleLB.right+30;
        }
        if(backView.tag==101)
        {
            [backView addSubview:nickName];
             nickName.left=titleLB.right+30;
        }
        if(backView.tag==102)
        {
            [backView addSubview:phoneNum];
             phoneNum.left=titleLB.right+30;
        }
        if(backView.tag==103)
        {
            [backView addSubview:password];
             password.left=titleLB.right+30;
            UIButton *checkBT=[UIButton buttonWithType:UIButtonTypeCustom];
            [checkBT setImage:[UIImage imageNamed:@"canSeePassword"] forState:UIControlStateNormal];
            [checkBT setImage:[UIImage imageNamed:@"unSeePassword"] forState:UIControlStateSelected];
            [checkBT addTarget:self action:@selector(setPasswordCanSee:) forControlEvents:UIControlEventTouchUpInside];
            checkBT.frame=Rect(ScreenWidth-50, 13, 25, 18);
            checkBT.tag=backView.tag+100;
            [backView addSubview:checkBT];
            
        }
        if(backView.tag==104)
        {
            [backView addSubview:confirmPwd];
             confirmPwd.left=titleLB.right+30;
            UIButton *checkBT=[UIButton buttonWithType:UIButtonTypeCustom];
            [checkBT setImage:[UIImage imageNamed:@"canSeePassword"] forState:UIControlStateNormal];
            [checkBT setImage:[UIImage imageNamed:@"unSeePassword"] forState:UIControlStateSelected];
            [checkBT addTarget:self action:@selector(setPasswordCanSee:) forControlEvents:UIControlEventTouchUpInside];
            checkBT.frame=Rect(ScreenWidth-50, 13, 25, 18);
            checkBT.tag=backView.tag+100;
            [backView addSubview:checkBT];
        }
        if(backView.tag==106)
        {
            [backView addSubview:inviteCode];
            inviteCode.left=titleLB.right+30;
        }
    }
    
    registeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, BTTop, ScreenWidth-40, 44)];
    [registeBtn setBackgroundColor:kAppMainColor];
    registeBtn.layer.cornerRadius=5;
    registeBtn.layer.masksToBounds=YES;
    [registeBtn setTitle:@"提交" forState:UIControlStateNormal];
    registeBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [registeBtn addTarget:self action:@selector(registe:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:registeBtn];
    
    
    /*
    protocalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protocalBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_checkbox_pressed"] forState:UIControlStateNormal];
   
    [protocalBtn setFrame:CGRectMake(10, 270+25, 22.5, 22.5)];
    [protocalBtn addTarget:self action:@selector(protocalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:protocalBtn];
    
    
    UILabel *protocalInfo = [[UILabel alloc] initWithFrame:CGRectMake(35, 270+25, 75, 22.5)];
    [protocalInfo setBackgroundColor:[UIColor clearColor]];
    [protocalInfo setText:@"我已阅读并接受"];
    [protocalInfo setFont:[UIFont systemFontOfSize:10]];
    [backScrollerView addSubview:protocalInfo];
    
    UIButton *protocalViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protocalViewBtn setTitleColor:kAppColor1 forState:UIControlStateNormal];
    [protocalViewBtn setFrame:CGRectMake(95, 270+25, 100, 22.5)];
    [protocalViewBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [protocalViewBtn addTarget:self action:@selector(viewProtocal:) forControlEvents:UIControlEventTouchUpInside];
    [protocalViewBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [backScrollerView addSubview:protocalViewBtn];
     */
    
}
- (void)initRegisteInfo
{
   
    trueName = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 44)];
    [self setTextField:trueName withPlaceholder:@"请输入真实姓名" withSecure:NO];
   // phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    trueName.tag = 3001;
    
    nickName = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 44)];
    [self setTextField:nickName withPlaceholder:@"输入昵称" withSecure:NO];
    // phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    nickName.tag = 3002;
    
    phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 44)];
    [self setTextField:phoneNum withPlaceholder:@"请输入您的手机号码" withSecure:NO];
    phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    phoneNum.tag = 3003;
    
    verificationCode = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 100 - 10, 40)];
    [self setTextField:verificationCode withPlaceholder:@"请输入验证码" withSecure:NO];
    verificationCode.tag = 3006;
    verificationCode.keyboardType = UIKeyboardTypeNumberPad;
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 40)];
    [self setTextField:password withPlaceholder:@"请输入6-16位密码" withSecure:YES];
    password.tag = 3004;
    
    confirmPwd = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 40)];
    [self setTextField:confirmPwd withPlaceholder:@"请确认您的密码" withSecure:YES];
    confirmPwd.tag = 3005;
    
    inviteCode = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 40)];
    [self setTextField:inviteCode withPlaceholder:@"请输入邀请码(区分大小写)" withSecure:NO];
    //phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    phoneNum.tag = 3007;
}

- (void)setTextField:(UITextField*)textField withPlaceholder:(NSString*)title withSecure:(BOOL)isSecure
{
    textField.placeholder = title;
    textField.font = [UIFont systemFontOfSize:14];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    if (isSecure)
    {
        textField.secureTextEntry = YES;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)protocalBtnClick:(id)sender
{
    if (isAgreeProtocal)
    {
        isAgreeProtocal = NO;
        [protocalBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_checkbox"] forState:UIControlStateNormal];
    }
    else
    {
        isAgreeProtocal = YES;
        [protocalBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_checkbox_pressed"] forState:UIControlStateNormal];
    }
}
-(void)setPasswordCanSee:(UIButton *)sender
{
   
        if (sender.selected) {
             if (sender.tag==203) {
                 password.secureTextEntry=YES;
             }
             else
             {
                 confirmPwd.secureTextEntry=YES;
             }
            sender.selected=NO;
        }
        else
        {
            if (sender.tag==203) {
                password.secureTextEntry=NO;
            }
            else
            {
                confirmPwd.secureTextEntry=NO;
            }
            sender.selected=YES;
        }
    
    
}

-(void)viewProtocal:(id)sender
{
  //  UserProtocalViewController *controller = [[UserProtocalViewController alloc] init];
   // [self.navigationController pushViewController:controller animated:YES];
}



/*
 *  获取验证码
 */
- (void)queryVerifyCode:(id)sender
{
    [self.view endEditing:YES];
    if ([[phoneNum text] isEqualToString:@""] || phoneNum == nil || [phoneNum text] == nil)
    {
        //用户手机号为空时的提示
        [self showToast:@"请输入正确的手机号码"];
    }
    else{
        if ([[phoneNum text] checkUserPhoneNumber])
        {
            if (![ConUtils checkUserNetwork])
            {
                [self showToast:@"网络连接不可用，请稍后再试！"];
            }
            else
            {
                timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(verifyCodding) userInfo:nil repeats:YES];
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary: @{@"phone":phoneNum.text}];
                HttpBaseRequest *request=[[HttpBaseRequest alloc]initWithDelegate:self];
              //  [request initRequestComm:dic withURL:USER_SMSCODE operationTag:USERSMSCODE];
                [request initGetRequestComm:dic withURL:USER_SMSCODE operationTag:USERSMSCODE];
             //   [HttpRequestComm getCecurityCode:[phoneNum text] withDelegate:self withFlag:nil];
            }
        }
        else
        {
            [self showToast:@"请输入正确的手机号码"];
        }
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
    
    [self resignFirstResponder:phoneNum];
    [self resignFirstResponder:verificationCode];
    [self resignFirstResponder:password];
    [self resignFirstResponder:confirmPwd];
    [self resignFirstResponder:nickName];
    [self resignFirstResponder:trueName];
    [self resignFirstResponder:inviteCode];
}

- (void)registe:(id)sender
{
    [self resignFirstResponder:phoneNum];
    [self resignFirstResponder:verificationCode];
    [self resignFirstResponder:password];
    [self resignFirstResponder:confirmPwd];
    [self resignFirstResponder:nickName];
    [self resignFirstResponder:trueName];
    [self resignFirstResponder:inviteCode];
    
    
//    if (!isAgreeProtocal)
//    {
//        //用户未勾选协议的提示
//        [self showToast:@"请选择接受用户协议"];
//    }else
    {
        if ([self checkUserInfo]) {
            if (![ConUtils checkUserNetwork])
            {
                [self showToast:@"网络连接不可用，请稍后再试！"];
            }
            else
            {
                
               // registeBtn.userInteractionEnabled = NO;
                
                self.userDict = [[NSMutableDictionary alloc] init];
                [self.userDict setObject:[phoneNum text] forKey:@"phone"];
                [self.userDict setObject:[trueName text] forKey:@"name"];
                [self.userDict setObject:[nickName text] forKey:@"nickname"];
                [self.userDict setObject:[inviteCode text] forKey:@"inviteCode"];
                
                [self.userDict setObject:[verificationCode text] forKey:@"code"];
                
                [self.userDict setObject:[[password text] md5] forKey:@"password"];
                /*
                WGRegisterViewController *wvc=[[WGRegisterViewController alloc]init];
                wvc.userDict=mulDic;
                [self.navigationController pushViewController:wvc animated:YES];
                 */
               
               // [self.userDict setObject:logoUrl forKey:@"logoUrl"];
                
//                if([GetuiManager sharedInstance].deviceToken)
//                {
//                    [self.userDict setObject:[GetuiManager sharedInstance].deviceToken forKey:@"device_code"];
//                }
//                
//                if([GetuiManager sharedInstance].clientId)
//                {
//                    [self.userDict setObject:[GetuiManager sharedInstance].clientId forKey:@"pushID"];
//                }
                /*
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"]!=nil)
                {
                    [self.userDict setObject:[GetuiManager sharedInstance].deviceToken forKey:@"device"];
                }
                 */
                /*
                NSString *cityId = @"110100";
//                if([PublicManager sharedInstance].currentHotCityInfo && [WGPublicData sharedInstance].currentHotCityInfo.areaId)
//                {
//                    cityId = [WGPublicData sharedInstance].currentHotCityInfo.areaId;
//                }
                [self.userDict setObject:cityId forKey:@"city"];
                 */
                HttpBaseRequest *request=[[HttpBaseRequest alloc]initWithDelegate:self];
                [request initRequestComm:self.userDict withURL:USER_REGISTER operationTag:USERREGISTER];
                [SVProgressHUD show];

            }
        }
    }
}

- (void)verifyCodding
{
    [verifyCodeBtn setUserInteractionEnabled:NO];
    [verifyCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",time] forState:UIControlStateNormal];
    time -=1;
    if (time == 0)
    {
        [verifyCodeBtn setUserInteractionEnabled:YES];
        [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        time = 59;
        [timer invalidate];
        timer = nil;
    }
}

- (BOOL)checkUserInfo
{
    if ([[phoneNum text] isEqualToString:@""] || [phoneNum text] == nil)
    {
        [self showToast:@"请输入正确的手机号码"];
        return  NO;
    }
    else if ([[trueName text] isEqualToString:@""] || [trueName text] == nil)
    {
        [self showToast:@"请输入真实姓名"];
        return  NO;

    }
    else if ([[nickName text] isEqualToString:@""] || [nickName text] == nil)
    {
        [self showToast:@"请输入昵称"];
        return  NO;
        
    }
    else if ([[inviteCode text] isEqualToString:@""] || [inviteCode text] == nil)
    {
        [self showToast:@"请输入邀请码"];
        return  NO;
        
    }
    else
    {
        if (![[phoneNum text] checkUserPhoneNumber])
        {
            [self showToast:@"请输入正确的手机号码"];
            return  NO;;
        }
    }
    
    if ([[verificationCode text] isEqualToString:@""] || [verificationCode text] == nil)
    {
        [self showToast:@"请输入验证码!"];
        return  NO;
    }
    else
    {
        if ([[verificationCode text] length] == 0)
        {
            [self showToast:@"验证码错误，请重新输入"];
            return  NO;
        }
    }
    
    if ([password text] == nil || [[password text] isEqualToString:@""])
    {
        [self showToast:@"密码长度必须为6-16个字符"];
        return  NO;
    }
    else
    {
        if ([[password text] length] > 16 || [[password text] length] < 6)
        {
            [self showToast:@"密码长度必须为6-16个字符"];
            return  NO;
        }
    }
    
    if ([confirmPwd text] == nil || [[confirmPwd text] isEqualToString:@""])
    {
        [self showToast:@"两次输入的密码不一致"];
        return  NO;
    }
    else
    {
        if (![[confirmPwd text] isEqualToString:[password text]])
        {
            [self showToast:@"两次输入的密码不一致"];
            return  NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backLogin
{
    [timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark HttpRequestCommDelegate
//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(NSInteger) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    BaseResponse *resp=[[BaseResponse alloc]init];
    [resp setHeadData:inParam];
    switch (tagId) {
           
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
            
        case USERREGISTER:
        {
            registeBtn.userInteractionEnabled = YES;
           
            if(resp.code==0)
            {
               /*
                if(loginResponse.userElement)
                {
                    [self showToast:@"注册成功"];
                    [self performSelector:@selector(backLogin) withObject:nil afterDelay:2];
                    userElement = loginResponse.userElement;
                    [[SharedUserDefault sharedInstance] setLoginState:@"Y"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                    [[SharedUserDefault sharedInstance] setUserInfo:[NSKeyedArchiver archivedDataWithRootObject:userElement]];
                    [self loginWithUsername:[userElement.userCode md5] password:userElement.passWord];
                    // [self sendDynmicWithHeadUrl:userElement.logoUrl];
                }
                else
                {
                    [[SharedUserDefault sharedInstance] setLoginState:@"N"];
                ![[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                    [self showToast:@"注册失败!"];
                }
                */
                [self showToast:@"注册成功，请登录!"];
                [self.navigationController popViewControllerAnimated:YES ];
                
            }
            else{
                userElement = nil;
                NSString *returnMsg = [[inParam objectForKey:@"result"] objectForKey:@"msg"];
                if (returnMsg == nil || [returnMsg isEqualToString:@""])
                {
                    [self showToast:@"亲!你的网络不太好哦,重新试试"];
                }
                else
                {
                    [self showToast:returnMsg];
                }
            }
        }
            break;
            
        default:
            break;
    }
}

//网络请求失败协议方法
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    registeBtn.userInteractionEnabled = YES;
    [self showToast:NO_NETWORK_TEXT];
}
#pragma mark —环信登陆

//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)passWord
{
    [self showToast:@"正在登录..."];
    //异步登陆账号
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // EMError *error = [[EMClient sharedClient] loginWithUsername:username password:passWord];
        dispatch_async(dispatch_get_main_queue(), ^{
           // [weakself hideHud];
            /*
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[EMClient sharedClient] dataMigrationTo3];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"登录成功");
                        [[SharedUserDefault sharedInstance] setLoginState:@"Y"];
                        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
                        NSInteger unreadCount = 0;
                        for (EMConversation *conversation in conversations)
                        {
                            unreadCount += conversation.unreadMessagesCount;
                        }
                        [WGPublicData sharedInstance].myMsgCount = unreadCount;
                        [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_LEFT_VIEW
                                                                            object:nil];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                        /*
                         NSString *showName = @"匿名";
                         if(self.userElement && self.userElement.nickName)
                         {
                         showName = self.userElement.nickName;
                         }
                         [[EMClient sharedClient] setApnsNickname:showName];
                         * //
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                        
                    });
                });
            }
            else {
                
                if ([error.description isEqualToString:@"Already logged"]) {
                    [[SharedUserDefault sharedInstance] setLoginState:@"Y"];
                    // NSLog(@"classArr%@",[[SharedUserDefault sharedInstance]getUserRelationClass].classArr);
                    NSArray *conversations = [[[EMClient sharedClient] chatManager] getAllConversations];
                    NSInteger unreadCount = 0;
                    for (EMConversation *conversation in conversations)
                    {
                        unreadCount += conversation.unreadMessagesCount;
                    }
                    [WGPublicData sharedInstance].myMsgCount = unreadCount;
                    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_LEFT_VIEW
                                                                        object:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    
                    NSString *showName = @"匿名";
                    if(userElement && userElement.nickName)
                    {
                        showName = userElement.nickName;
                    }
                    [[EMClient sharedClient] setApnsNickname:showName];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                }
                else{
                    [[SharedUserDefault sharedInstance] setLoginState:@"N"];
                    [self showToast:error.description];
                }
                
                
                switch (error.code)
                {
                        //                    case EMErrorNotFound:
                        //                        TTAlertNoTitle(error.errorDescription);
                        //                        break;
                    case EMErrorNetworkUnavailable:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                        break;
                    case EMErrorServerNotReachable:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                        break;
                    case EMErrorUserAuthenticationFailed:
                        TTAlertNoTitle(error.errorDescription);
                        break;
                    case EMErrorServerTimeout:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                        break;
                    default:
                        TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                        break;
                }
            }
            */
        });
    });
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

//限制手机号输入字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == phoneNum) {
        if (textField.text.length >= 11 && string.length > 0) {
            return NO;
        }
    }
    if (textField == password) {
        if (textField.text.length >= 16 && string.length > 0) {
            return NO;
        }
    }
    if (textField == confirmPwd) {
        if (textField.text.length >= 16 && string.length > 0) {
            return NO;
        }
    }
    if (textField == verificationCode) {
        if (textField.text.length >= 6 && string.length > 0) {
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

#pragma mark 放弃成为第一响应者

- (void)resignFirstResponder:(UIView *)view {
    
    if ([view isFirstResponder]) {
        [view resignFirstResponder];
    }
    
}

@end
