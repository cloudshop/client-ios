//
//  GRRegisterVC.m
//  GongRongPoints
//
//  Created by 王旭 on 2018/3/30.
//

#import "GRRegisterVC.h"
#import "GRSetPasswordVC.h"

@interface GRRegisterVC ()
@property(nonatomic,strong)UITextField *phoneNumberTF;
@property (nonatomic,strong)UITextField *verifyNumberTF;
@property (nonatomic,strong)UIButton *requestVerifyBT;
@property (nonatomic,strong)UIButton *nextBT;
@property (nonatomic,strong)UIButton *clearPhoneBT;
@end

@implementation GRRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle];
    [self.viewNaviBar setTitle:@"手机注册"];
    [self initSubviews];
}

-(void)regesiter
{
    GRSetPasswordVC *setVC=[[GRSetPasswordVC alloc]init];
    setVC.isReset=NO;
    setVC.phoneNumber=self.phoneNumberTF.text;
    setVC.verifyCode=self.verifyNumberTF.text;
    [self.navigationController pushViewController:setVC animated:YES];
    
}
-(void)httpRequestSuccessComm:(NSInteger)tagId withInParams:(id)inParam
{
    BaseResponse *resp=[[BaseResponse alloc]init];
    [resp setResultData:inParam];
    if (resp.code==200) {
        [self showToast:resp.message];
        return;
    }
    switch (tagId) {
        case USERVERIFYCODE:
        {
            
        }
            break;
            
        default:
            break;
    }
}
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *)error
{
    [SVProgressHUD dismiss];
    [self showToast:@"请求失败，请稍后再试"];
    
}

-(void)initSubviews
{
    self.phoneNumberTF=[[UITextField alloc]init];
    self.phoneNumberTF.font=[UIFont systemFontOfSize:12];
    self.phoneNumberTF.placeholder=@"请输入手机号";
    self.phoneNumberTF.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneNumberTF];
    
    self.clearPhoneBT=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.clearPhoneBT setImage:[UIImage imageNamed:@"clearPhoneNBIMG"]  forState:UIControlStateNormal];
    [self.clearPhoneBT addTarget:self action:@selector(clearPhoneNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearPhoneBT];
    
    UIView *septorLine=[[UIView alloc]init];
    septorLine.backgroundColor=kAppColor1;
    [self.view addSubview:septorLine];
    
    
    self.verifyNumberTF=[[UITextField alloc]init];
    self.verifyNumberTF.font=[UIFont systemFontOfSize:12];
    self.verifyNumberTF.placeholder=@"请输入验证码";
    self.verifyNumberTF.layer.borderColor=[kAppColorSeparate CGColor];
    self.verifyNumberTF.layer.borderWidth=0.5;
    self.verifyNumberTF.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:self.verifyNumberTF];
    
    self.requestVerifyBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.requestVerifyBT addTarget:self action:@selector(reqestVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    self.requestVerifyBT.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.requestVerifyBT setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.requestVerifyBT setTitleColor:kAppColor6 forState:UIControlStateNormal];
    self.requestVerifyBT.layer.borderColor=[kAppColorSeparate CGColor];
    self.requestVerifyBT.layer.borderWidth=0.5;
    [self.view addSubview:self.requestVerifyBT];
    
    self.nextBT=[UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBT.layer.cornerRadius=5;
    [self.nextBT setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBT setTitleColor:kAppColor5 forState:UIControlStateNormal];
    [self.nextBT addTarget:self action:@selector(regesiter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBT];
    
    
    [self.phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.leading.mas_equalTo(40);
        make.trailing.mas_equalTo(-50);
        make.top.mas_equalTo(90);
        
    }];
    [self.clearPhoneBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(Size(20, 20));
        make.left.equalTo(self.phoneNumberTF.mas_right).offset(5);
        make.centerY.equalTo(self.phoneNumberTF);
        
    }];
    [septorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.phoneNumberTF.mas_bottom).offset(5);
        make.leading.trailing.equalTo(self.phoneNumberTF);
    }];
    [self.requestVerifyBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.phoneNumberTF);
        make.top.equalTo(septorLine.mas_bottom).offset(10);
    }];
    [self.verifyNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(self.phoneNumberTF);
        make.right.equalTo(self.requestVerifyBT.mas_left).offset(-5);
        make.top.equalTo(self.requestVerifyBT);
    }];
   
    [self.nextBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.leading.trailing.equalTo(self.phoneNumberTF);
        make.top.equalTo(self.verifyNumberTF.mas_bottom ).offset(20);
    }];
}

-(void)reqestVerifyCode
{
    if (self.phoneNumberTF.text.length<11) {
        [self showToast:@"请输入正确的手机号"];
        return;
    }
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary: @{@"phone":self.phoneNumberTF.text}];
    HttpBaseRequest *request=[[HttpBaseRequest alloc]initWithDelegate:self];
    //  [request initRequestComm:dic withURL:USER_SMSCODE operationTag:USERSMSCODE];
    [request initGetRequestComm:dic withURL:USER_SMSCODE operationTag:USERSMSCODE];
    //   [HttpRequestComm getCecurityCode:[phoneNum text] withDelegate:self withFlag:nil];
}
-(void)clearPhoneNumber
{
    self.phoneNumberTF.text=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
