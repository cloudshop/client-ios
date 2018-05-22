    //
//  UserLoadViewController.m
//  Booking
//
//  Created by 1 on 11-12-31.
//  Copyright (c) 2011年 bluecreate. All rights reserved.
//


#import "UserLoadViewController.h"


#import "SharedUserDefault.h"
#import "NSString+CheckUserInfo.h"
#import "ConUtils.h"


#import "WGPublicData.h"
#import "ForgetPwdViewController.h"
#import "PhoneRegisteViewController.h"
#import "GRRegisterVC.h"
#import "JGManager.h"
#import "TYWebVC.h"
#import "PopRootWebVC.h"

enum
{
    WXLogin=1,
    QQLogin=2,
    XLLogin=3
}loginType;
@interface UserLoadViewController ()
{
    UIButton *loadBtn;
    UIButton *checkPWBT;
}

@property (nonatomic,strong)NSString *platType;
@end

@implementation UserLoadViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */
-(void)backBTclicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     LRLog(@"----->navigationBarHeight%f",self.navigationController.navigationBar.height);
    self.view.backgroundColor= [UIColor whiteColor];//UIColorWithHex(0xf4f4f4);
    [self.viewNaviBar setTitle: @"登录"];
    self.tabBarController.tabBar.hidden = YES;
    
  
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle/*NavBarTypeLeftTitleRight*/];
    //self.viewNaviBar.backgroundColor=kAppColor1;
    //[self.viewNaviBar setLogInMode];
    self.viewNaviBar.hidden=NO;
   // self.viewNaviBar.m_btnBack.hidden=YES;
    
    /*
    UIButton *backBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBT setImage:[UIImage imageNamed:@"back_new"] forState:UIControlStateNormal];
    [backBT addTarget:self action:@selector(backBTclicked) forControlEvents:UIControlEventTouchUpInside];
    backBT.frame=Rect(11, 27, 30, 30);
    [self.view addSubview:backBT];
    */
    
    self.view.backgroundColor=kAppColorBackground;
    self.userElement =[[SharedUserDefault sharedInstance]getUserInfo];
    
    /*
    UIImageView *IMGV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_Third"]];
    IMGV.size=Size(115, 52);
    [self.view addSubview:IMGV];
    
    IMGV.centerX=ScreenWidth/2;
    if (ScreenHeight==480) {
        IMGV.top=64;
    }
    else
    {
    IMGV.top=68;
    }

    UIImageView *iconV=[[UIImageView alloc]initWithImageNamed:@"Icon"];
    [self.view addSubview:iconV];
    iconV.layer.cornerRadius=10;
    iconV.clipsToBounds=YES;
    iconV.frame=Rect((ScreenWidth-65)/2, 40, 65, 65);
    */
    
    UIView *phoneNBView=[[UIView alloc]init];
    phoneNBView.layer.borderColor=[UIColorWithHex(0xE6E6E6) CGColor];
    //phoneNBView.layer.borderWidth=1;
    phoneNBView.backgroundColor=kAppColor8;
    [self.view addSubview:phoneNBView];
    float viewStartH;
    if (ScreenHeight>480) {
        viewStartH=NaviBarHeight+StatusBarHeight+80;
    }
    else
    {
        viewStartH=NaviBarHeight+StatusBarHeight;
    }
    phoneNBView.frame=CGRectMake(0, viewStartH, ScreenWidth, 40);
    
    
    UILabel *phoneIcon=[[UILabel alloc]init];
    [phoneNBView addSubview:phoneIcon];
    phoneIcon.text=@"账号";
    phoneIcon.font=[UIFont systemFontOfSize:14];
    [phoneIcon sizeToFit];
    phoneIcon.centerY=40/2;
    phoneIcon.left=30;
    
    
   // [self initUserAccount];
    accountField = [[UITextField alloc] initWithFrame:CGRectMake(25, 0, ScreenWidth-50-62, 40)];
    if(self.userElement.userCode.length!=0)
    {
        accountField.text=self.userElement.userCode;
    }
    //    UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 18, 20)];
    //    headView.image=[UIImage imageNamed:@"login_icon_phone"];
    //    accountField.leftView=headView;
    //    accountField.leftViewMode=UITextFieldViewModeAlways;
    [self setTextField:accountField withPlaceholder:@"请输入手机号" withSecure:NO];
    accountField.keyboardType= UIKeyboardTypeNumberPad;
    //self.phonenum.returnKeyType=UIReturnKeyDone;
   
    [accountField addTarget:self action:@selector(limitLength:) forControlEvents:UIControlEventEditingChanged];
    [phoneNBView addSubview:accountField];
    accountField.left=phoneIcon.right+8;
 
   
    viewStartH+=50+10;
    
  //  [self initUserPassword];
    
    UIView *passwordView=[[UIView alloc]init];
    passwordView.layer.borderColor=[UIColorWithHex(0xE6E6E6) CGColor];
   // passwordView.layer.borderWidth=1;
    [self.view addSubview:passwordView];
    passwordView.backgroundColor=kAppColor8;
    passwordView.frame=CGRectMake(0, viewStartH, ScreenWidth, 40);
    
    UILabel *passwordIcon=[[UILabel alloc]init];
    [passwordView addSubview:passwordIcon];
    passwordIcon.text=@"密码";
    passwordIcon.font=[UIFont systemFontOfSize:14];
    [passwordIcon sizeToFit];
    passwordIcon.centerY=40/2;
    passwordIcon.left=30;

    
    pwdField = [[UITextField alloc] initWithFrame:CGRectMake(25, 0, ScreenWidth-50-62, 40)];
    [self setTextField:pwdField withPlaceholder:@"请输入密码" withSecure:YES];
    [passwordView addSubview:pwdField];
    pwdField.left=passwordIcon.right+8;
    passwordView.top=viewStartH;
    
    checkPWBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [checkPWBT setImage:[UIImage imageNamed:@"hiddenPWIMG"] forState:UIControlStateNormal];
    [checkPWBT setImage:[UIImage imageNamed:@"checkPWIMG"] forState:UIControlStateSelected];
    checkPWBT.frame=Rect(pwdField.right, pwdField.top+10, 25, 20);
    [passwordView addSubview:checkPWBT];
    [checkPWBT addTarget:self action:@selector(checkPasswordBT:) forControlEvents:UIControlEventTouchUpInside];
    
    viewStartH+=50+25;
    
    loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, viewStartH, ScreenWidth-60, 40)];
    loadBtn.backgroundColor=kAppMainColor;//RGB(120, 2, 224);
    //loadBtn.layer.cornerRadius=5;
    [loadBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [loadBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(userLoad:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    //loadBtn.top=passwordView.bottom+15;
    
    UIButton *registeBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [registeBT setFrame:CGRectMake(100, 110+64, 100, 0)];
    registeBT.titleLabel.textAlignment=NSTextAlignmentLeft;
    [registeBT setTitle:@"注册账号" forState:UIControlStateNormal];
    [registeBT setTitleColor:kAppMainColor forState:UIControlStateNormal];
    [registeBT.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [registeBT addTarget:self action:@selector(userRegiste:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeBT];
    //registeBT.centerX=ScreenWidth/2;
    
    [registeBT sizeToFit];
    //registeBT.height=forgrtPwLabel.height;
    registeBT.left=loadBtn.left;
    registeBT.top=loadBtn.bottom+20;

    
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdBtn setFrame:CGRectMake(100, 110+64, 100, 40)];
    forgetPwdBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:kAppMainColor forState:UIControlStateNormal];
    [forgetPwdBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [forgetPwdBtn addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    [forgetPwdBtn sizeToFit];
    forgetPwdBtn.right=loadBtn.right;
    forgetPwdBtn.top=registeBT.top;
    
    /*
    UILabel *forgrtPwLabel=[[UILabel alloc]init];
    forgrtPwLabel.frame=CGRectMake(35, 110+64, 120, 40);
    [self.view addSubview:forgrtPwLabel];
    forgrtPwLabel.text=@"还没有账号?";
    
    forgrtPwLabel.font=[UIFont systemFontOfSize:14];
    forgrtPwLabel.textColor=RGB(74, 74, 74);
    [forgrtPwLabel sizeToFit];
    forgrtPwLabel.bottom=ScreenHeight-20;
    forgrtPwLabel.centerX=ScreenWidth/2-30;
    */

   
    return;
    UILabel *thirdLB=[[UILabel alloc]init];
    thirdLB.textColor=kAppColor6;
    thirdLB.text=@"其他登录方式";
    thirdLB.font=[UIFont systemFontOfSize:11];
    [thirdLB sizeToFit];
    [self.view addSubview:thirdLB];
    thirdLB.bottom=ScreenHeight-160;
    thirdLB.centerX=ScreenWidth/2;
    
    UIView *leftLine=[[UIView alloc]init];
    leftLine.backgroundColor=RGB(230, 230,230);
    leftLine.size=Size((ScreenWidth-60-thirdLB.width)/2, 0.5);
    [self.view addSubview:leftLine];
    leftLine.right=thirdLB.left-10;
    leftLine.centerY=thirdLB.centerY;
    
    UIView *rightLine=[[UIView alloc]init];
    rightLine.backgroundColor=RGB(230, 230,230);
    rightLine.size=Size((ScreenWidth-60-thirdLB.width)/2, 0.5);
    [self.view addSubview:rightLine];
    rightLine.left=thirdLB.right+10;
    rightLine.bottom=thirdLB.centerY;

    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn setFrame:CGRectMake(0, 110+64, 00, 40)];
    [thirdBtn setImage:[UIImage imageNamed:@"Appicon"] forState:UIControlStateNormal];
    [thirdBtn addTarget:self action:@selector(thirdWebLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];
    [thirdBtn sizeToFit];
    thirdBtn.centerX=ScreenWidth/2;
    thirdBtn.top=thirdLB.bottom+20;
    
    
    /*
//SSO登陆
    BOOL WXInstall= [ WXApi isWXAppInstalled];
    BOOL QQInstall= [QQApiInterface isQQInstalled];
    
    NSMutableArray *titleArr=[[NSMutableArray alloc]init];
    NSMutableArray *imgArr=[[NSMutableArray alloc]init];
    if(WXInstall)
    {
        [titleArr addObject:@"微信登录"];
        [imgArr addObject:@"wechat_Third"];
    }
    if (QQInstall) {
        [titleArr addObject:@"QQ登录"];
        [imgArr addObject:@"qq_Third"];
    }
    [titleArr addObject:@"微博登录"];
    [imgArr addObject:@"sina_Third"];
   
    float spaceWith=0.;//(ScreenWidth-95-44*titleArr.count)/2;
    float secondSpaceWith=0.;
    if (titleArr.count==1) {
        secondSpaceWith=(ScreenWidth-95-44)/2;
        spaceWith=0;
        
    }
    else if (titleArr.count==2)
    {
        secondSpaceWith=(ScreenWidth-95-44*2)/3;
        spaceWith=0;
    }
    else
    {
        secondSpaceWith=0;//(ScreenWidth-95-44*3)/2;
        spaceWith=(ScreenWidth-95-44*3)/4;
    }

    for (int i=0;i<titleArr.count;i++)
    {
        UILabel *titleLB=[[UILabel alloc]init];
        [self.view addSubview:titleLB];
        titleLB.text=titleArr[i];
        [titleLB sizeToFit];
        titleLB.textColor=UIColorWithHex(0x9B9B9B);
        titleLB.font=[UIFont systemFontOfSize:12];
        if (ScreenHeight==480) {
             titleLB.bottom=lineV.top-15;
        }
        else
        {
          titleLB.bottom=lineV.top-25;
        }
       
        titleLB.left=42.5+secondSpaceWith+spaceWith+(44+secondSpaceWith+spaceWith)*i;
        
        
        UIImageView *IMGV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:imgArr[i]]];
        [self.view addSubview:IMGV];
        IMGV.frame=CGRectMake(42.5+secondSpaceWith+spaceWith+(44+secondSpaceWith+spaceWith)*i, 110+64+80, 44, 44);
        IMGV.bottom=titleLB.top-6;
        
        
        
        UIButton *SSOBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [SSOBT setFrame:CGRectMake(42.5+secondSpaceWith+spaceWith+(44+secondSpaceWith+spaceWith)*i, 110+64+80, 44, 44)];
        
        SSOBT.height=IMGV.height+titleLB.height+6;
        SSOBT.top=IMGV.top;
        SSOBT.left=IMGV.left;
        int typeLogin=0;
        if ([[titleArr objectAtIndex:i] isEqualToString:@"微信登录"]) {
            typeLogin=WXLogin;
        }
        else if ([[titleArr objectAtIndex:i] isEqualToString:@"QQ登录"])
        {
            typeLogin=QQLogin;
        }
        else{
            typeLogin=XLLogin;
        }
        SSOBT.tag=120+typeLogin;
//        SSOBT.titleLabel.textAlignment=NSTextAlignmentLeft;
//        [SSOBT setTitle:titleArr[i] forState:UIControlStateNormal];
//        [SSOBT setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [SSOBT.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [SSOBT addTarget:self action:@selector(SSOLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:SSOBT];
    }
    
    */
   
}
-(void)thirdWebLogin
{
    /*
    TYWebVC *web=[[TYWebVC alloc]init];
    web.titleStr=@"登录";
    NSString *urlStr;
    
    urlStr=[NSString stringWithFormat:@"%@%@%@",BASEURLPATH,@"user/third_login?deviceToken=",[GetuiManager sharedInstance].deviceToken];
    //urlStr=[NSString stringWithFormat:@"%@",@"https://www.baidu.com"];
   
    [web setUrl:urlStr];
    [self.navigationController pushViewController:web animated:YES];
    */
    
//    ThirdLoginWeb *WebViewVC=[[ThirdLoginWeb alloc]init];
//    NSString *urlStr;
//
//    urlStr=[NSString stringWithFormat:@"%@%@%@/%@",BASEURLPATH,@"user/third_login/",[GetuiManager sharedInstance].clientId,[GetuiManager sharedInstance].deviceToken];
//    //urlStr=[NSString stringWithFormat:@"%@",@"https://www.baidu.com"];
//
//    [WebViewVC setUrl:urlStr];
//
//    [self.navigationController pushViewController:WebViewVC animated:YES];
    
}
-(void)checkPasswordBT:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        pwdField.secureTextEntry=NO;
    }
    else
    {
        pwdField.secureTextEntry=YES;
    }
    
}
- (void)forgetPassword:(id)sender
{

//    ForgetPwdViewController *fvc=[[ForgetPwdViewController alloc]init];
//    fvc.forgetType=loginForget;
//    [self.navigationController pushViewController:fvc animated:YES];
    PopRootWebVC *vc4=[[PopRootWebVC alloc]init];
    [vc4 setUrl:[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/#/RegisterNew"]];
    [self.navigationController pushViewController:vc4 animated:YES];
}


- (void)initUserAccount
{
    accountField = [[UITextField alloc] initWithFrame:CGRectMake(25, 89, ScreenWidth-50, 40)];
    if(self.userElement.userCode.length!=0)
    {
        accountField.text=self.userElement.userCode;
    }
//    UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 18, 20)];
//    headView.image=[UIImage imageNamed:@"login_icon_phone"];
//    accountField.leftView=headView;
//    accountField.leftViewMode=UITextFieldViewModeAlways;
    [self setTextField:accountField withPlaceholder:@"请输入手机号" withSecure:NO];
    accountField.keyboardType= UIKeyboardTypeNumberPad;
    //self.phonenum.returnKeyType=UIReturnKeyDone;
   // [accountField addTarget:self action:@selector(limitLength:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:accountField];
}
-(void)limitLength:(UITextField *)sender
{
    bool isChinese;//判断当前输入法是否是中文
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
       // return;
    }
    
    if(sender == accountField) {
        // 8位
        NSString *str = [[accountField text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        if (isChinese) { //中文输入法下
            UITextRange *selectedRange = [accountField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [accountField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                NSLog(@"汉字");
                if ( str.length>=9) {
                  //  NSString *strNew = [NSString stringWithString:str];
                   // [accountField setText:[strNew substringToIndex:8]];
                }
            }
            else
            {
                NSLog(@"输入的英文还没有转化为汉字的状态");
                
            }
        }
        else{
          //  NSLog(@"str=%@; 本次长度=%ld",str,[str length]);
             NSString *strNew = [NSString stringWithString:str];
            if ([str length]<=11) {
               
               // [accountField setText:[strNew substringToIndex:11]];
            }
            else
            {
                 [accountField setText:[strNew substringToIndex:11]];
               // [self showToast:@"手机号码只支持11位"];
            }
        }
    }
}
- (void)initUserPassword
{
    pwdField = [[UITextField alloc] initWithFrame:CGRectMake(25, 89+50, ScreenWidth-50, 40)];
    
    [self setTextField:pwdField withPlaceholder:@"请输入密码" withSecure:YES];
    [self.view addSubview:pwdField];
}

- (void)setTextField:(UITextField*)textField withPlaceholder:(NSString*)title withSecure:(BOOL)isSecure
{
    textField.placeholder = title;
    textField.font = [UIFont systemFontOfSize:14];
    textField.delegate = self;
   // textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.layer.borderWidth=1;
//    textField.layer.borderColor=[RGB(230, 230, 230) CGColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.returnKeyType = UIReturnKeyDone;
    if (isSecure)
    {
        textField.secureTextEntry = YES;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

}
- (void)userLoad:(id)sender
{
    [self.view endEditing:YES];
    
  
    if ([self checkUserInfo])
    {
        if (![ConUtils checkUserNetwork])
        {
            [self showToast:@"网络连接不可用，请稍后再试！"];
        }
        else
        {
            /*
             NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
             
             HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
             [dic setObject:@"admin" forKey:@"username"];
             [dic setObject:@"admin" forKey:@"password"];
             [request initRequestJsonComm:dic withURL:USER_LOGIN operationTag:USERLOGIN];
             [SVProgressHUD show];
             */
            [SVProgressHUD show];
            loadBtn.userInteractionEnabled = NO;
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            HttpBaseRequest *request=[[HttpBaseRequest alloc]initWithDelegate:self];
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            [dic setObject:accountField.text forKey:@"username"];
            //[dic setObject:[pwdField.text md5] forKey:@"password"];
            [dic setObject:pwdField.text  forKey:@"password"];
            [dic setObject:[JGManager shareInstance].registrationID forKey:@"registrationID"];//registrationID
            [dic setObject:@"password" forKey:@"grant_type"];
            [dic setObject:@"w1eb_app" forKey:@"client_secret"];
            [dic setObject:@"web_app" forKey:@"client_id"];
            
            [request initRequestJsonComm:dic withURL:USER_LOGIN operationTag:USERLOGIN];
           // [HttpRequestComm userLogin:[accountField text] AndPassword:[pwdField text] withDelegate:self];
        }
    }
}
- (int)checkUserType
{
    if ([self.userElement.userCode checkUserPhoneNumber])
    {
        return 0;
    }
    else if ([self.userElement.userCode checkUserMailNumber])
    {
        return 1;
    }
    return 2;
}

- (BOOL)checkUserInfo
{
    if (accountField == nil || [accountField text] == nil || [[accountField text] isEqualToString:@""])
    {
        [self showToast:@"请输入正确的手机号码"];
        return NO;
    }
    else
    {
        if (![[accountField text] checkUserPhoneNumber]&&![[accountField text] checkUserMailNumber])
        {
            [self showToast:@"请输入正确的手机号码"];
            return NO;
        }
    }
    if ([pwdField text] == nil || [[pwdField text] isEqualToString:@""])
    {
        [self showToast:@"密码长度必须为6-16个字符"];
        return NO;
    }
    else
    {
        if ([[pwdField text] length] < 6 || [[pwdField text] length] > 16)
        {
            [self showToast:@"密码长度必须为6-16个字符"];
            return NO;
        }
    }
    return YES;
}

-(BOOL)checkUserCode
{
    if (accountField == nil || [accountField text] == nil || [[accountField text] isEqualToString:@""])
    {
        [self showToast:@"请输入正确的手机号码"];
        return NO;
    }
    else
    {
        if (![[accountField text] checkUserPhoneNumber]&&![[accountField text] checkUserMailNumber])
        {
            [self showToast:@"请输入正确的手机号码"];
            return NO;
        }
    }
    return YES;
}
-(void)userRegiste:(id)sender
{
   // WGRegisterViewController *phoneRegisteCon = [[WGRegisterViewController alloc] init];
  //  PhoneRegisteViewController *pvc=[[PhoneRegisteViewController alloc]init];
    
  //  GRRegisterVC *pvc=[[GRRegisterVC alloc]init];
  //  [self.navigationController pushViewController:pvc animated:YES];
    PopRootWebVC *vc4=[[PopRootWebVC alloc]init];
    [vc4 setUrl:[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@"/#/Register"]];
    [self.navigationController pushViewController:vc4 animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HttpRequestCommDelegate
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    BaseResponse *res=[[BaseResponse alloc]init];
    [res setHeadData:inParam];
    switch (tagId) {
           
        case USERLOGIN:{
            loadBtn.userInteractionEnabled = YES;
            if ([inParam isKindOfClass:[NSDictionary class]]) {
                [self showToast:@"登录成功"];
                NSString *token=[inParam JSONString];
                [[SharedUserDefault sharedInstance] setUserToken:token];
                [[NSNotificationCenter defaultCenter] postNotificationName:JSRefreshAllTag object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                return;
            }
            else
            {
                [self showToast:@"系统错误！请稍后再试"];
                return;
            }
            if (res.code == 0) {
                
               // if(loginResponse.userElement)
                {
                    [self showToast:@"登录成功"];
//                    self.userElement=[UserElement mj_objectWithKeyValues:res.data];
//
//                    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:self.userElement];
//                    [[SharedUserDefault sharedInstance]setUserInfo:data];
                    
                    NSString *token=[res.data objectForKey:@"token"];
                    [[SharedUserDefault sharedInstance] setUserToken:token];
                     [[SharedUserDefault sharedInstance] setLoginState:@"Y"];
                   [self.navigationController popToRootViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                    
                    
                 //   NSData *data=[NSKeyedArchiver archivedDataWithRootObject:self.userElement];
                 //   [[SharedUserDefault sharedInstance] setUserInfo:data];
                 //    NSLog(@"srviceLogin 成功 即将调用环信登陆 手机号：%@密码：%@",accountField.text,pwdField.text);
                   // [self loginWithUsername:[accountField.text md5] password:[pwdField.text md5]];
                }
//                else
//                {
//                    [self showToast:@"登录失败!"];
//                }
            }else{
                self.userElement = nil;
                NSString *returnMsg = [[inParam objectForKey:@"result"] objectForKey:@"msg"];
                if (returnMsg == nil || [returnMsg isEqualToString:@""])
                {
                    [self showToast:@"网络异常，请稍后再试"];
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
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    loadBtn.userInteractionEnabled = YES;
    [self showToast:NO_NETWORK_TEXT];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}
//限制手机号输入字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == accountField) {
        if (textField.text.length >= 11 && string.length > 0) {
            return NO;
        }
    }
    if (textField == pwdField) {
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

#pragma mark —环信登陆


@end
