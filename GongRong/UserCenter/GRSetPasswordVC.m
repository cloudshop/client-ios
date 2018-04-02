//
//  GRSetPasswordVC.m
//  GongRongPoints
//
//  Created by 王旭 on 2018/3/31.
//

#import "GRSetPasswordVC.h"

@interface GRSetPasswordVC ()
{
    NSMutableData* mData;
}
@property (nonatomic,strong)UITextField *passwordTF;
@property (nonatomic,strong)UITextField *confirmTF;
@property (nonatomic,strong)UIButton *finishBT;

@end

@implementation GRSetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.viewNaviBar setNavBarMode:NavBarTypeLeftTitle];
    [self.viewNaviBar setTitle:@"设置密码"];
    self.viewNaviBar.m_labelTitle.textColor=kAppColor5;
    self.viewNaviBar.backgroundColor=kAppColor8;
    [self initSubviews];
}
-(void)initSubviews
{
    UILabel *passworldLB=[[UILabel alloc]init];
    passworldLB.textColor=kAppColor5;
    passworldLB.font=[UIFont systemFontOfSize:13];
    passworldLB.text=@"设置密码";
    [self.view addSubview:passworldLB];
    
    UILabel *confirmLB=[[UILabel alloc]init];
    confirmLB.textColor=kAppColor5;
    confirmLB.font=[UIFont systemFontOfSize:13];
    confirmLB.text=@"确认密码";
    [self.view addSubview:confirmLB];
    
    self.passwordTF=[[UITextField alloc]init];
    self.passwordTF.font=[UIFont systemFontOfSize:12];
    self.passwordTF.placeholder=@"请输入密码";
   // self.passwordTF.layer.borderColor=[kAppColorSeparate CGColor];
   // self.passwordTF.layer.borderWidth=0.5;
    self.passwordTF.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:self.passwordTF];
   
    UIView *lineView=[[UIView alloc]init];
    lineView.backgroundColor=kAppColorSeparate;
    [self.view addSubview:lineView];
    
    self.confirmTF=[[UITextField alloc]init];
    self.confirmTF.font=[UIFont systemFontOfSize:12];
    self.confirmTF.placeholder=@"请再次输入密码";
   // self.confirmTF.layer.borderColor=[kAppColorSeparate CGColor];
   // self.confirmTF.layer.borderWidth=0.5;
    self.confirmTF.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:self.confirmTF];
    
    self.finishBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishBT addTarget:self action:@selector(finishOperation) forControlEvents:UIControlEventTouchUpInside];
    self.finishBT.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.finishBT setTitle:@"完成" forState:UIControlStateNormal];
    self.finishBT.backgroundColor=kAppColor6;
    [self.finishBT setTitleColor:kAppColor5 forState:UIControlStateNormal];
    self.finishBT.layer.borderColor=[kAppColorSeparate CGColor];
    self.finishBT.layer.borderWidth=0.5;
    [self.view addSubview:self.finishBT];
    
    CGSize psize=[passworldLB getLableSize];
    [passworldLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(psize);
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(ViewCtrlTopBarHeight+30);
        
    }];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(passworldLB.mas_right).offset(5);
        make.right.mas_equalTo(-40);
        make.centerY.equalTo(passworldLB);
        
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(5);
        make.left.equalTo(passworldLB);
        make.right.equalTo(self.passwordTF);
        
    }];
    CGSize csize=[confirmLB getLableSize];
    [confirmLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(csize);
        make.left.mas_equalTo(30);
        make.top.equalTo(lineView.mas_bottom).offset(15);
        
    }];
    [self.confirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.passwordTF);
        make.left.right.equalTo(self.passwordTF);
        make.centerY.equalTo(confirmLB);
        
    }];
    [self.finishBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(passworldLB);
        make.right.equalTo(self.passwordTF);
        make.top.equalTo(self.confirmTF.mas_bottom).offset(20);
    }];
    
    
}
-(void)finishOperation
{
    if (!self.passwordTF.text||!self.confirmTF.text) {
        [self showToast:@"请输入密码"];
        return;
    }
    if (![self.passwordTF.text isEqualToString:self.confirmTF.text]) {
        [self showToast:@"两次输入的密码不一致"];
        return;
    }
    [self payByHttpRequest];
    return;
    HttpBaseRequest *req=[[HttpBaseRequest alloc]initWithDelegate:self];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"dfjdlkndv" forKey:@"name"];
    [dic setObject:@"1" forKey:@"productId"];
    [dic setObject:@"2" forKey:@"status"];
    if (self.isReset) {
        
    }
    else
    {
        [req initRequestJsonComm:dic withURL:@"api/attributes" operationTag:USERREGISTER];
    }
}
- (void)payByHttpRequest{
    NSDictionary *dic=@{@"name":@"dfjdlkndv",@"productId":@"1",@"status":@"2"};
    NSString *disStr=[dic JSONString];
NSString *outputStr = (NSString *)
CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                          (CFStringRef)disStr,
                                                          NULL,
                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                          kCFStringEncodingUTF8));

    NSString *presignStr=@"";//@"paydata=";
presignStr=[presignStr stringByAppendingString:outputStr];
NSString *urlStr=[NSString stringWithFormat:@"http://192.168.1.105:8116/api/attributes"];
NSURL* url = [NSURL URLWithString:urlStr];
NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
[urlRequest setHTTPMethod:@"POST"];

urlRequest.HTTPBody=[presignStr dataUsingEncoding:NSUTF8StringEncoding];
NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
[urlConn start];

// [self showAlertWait];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response {
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    int code = (int)[rsp statusCode];
    if (code != 200) {
        
    } else {
        if (mData != nil) {
            mData = nil;
        }
        mData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
   
     [mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // [self hideAlert];
   
     NSString* data = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
     NSLog(@"finishLoad----%@",data);
    // [IpaynowPluginApi pay:payData AndScheme:@"TYIPayNowSchems" viewController:self delegate:self];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // [self hideAlert];
    // [self showAlertMessage:kErrorNet];
    [self showToast:@"失败了"];
}

-(void)httpRequestSuccessComm:(NSInteger)tagId withInParams:(id)inParam
{
    BaseResponse *resp=[[BaseResponse alloc]init];
    [resp setResultData:inParam];
    if (resp.code!=2000) {
        [self showToast:resp.message];
        return;
    }else
    {
        [self showToast:@"注册成功"];
    }
    
}
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *)error
{
    [self showToast:@"请求失败，请稍后再试"];
    
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
