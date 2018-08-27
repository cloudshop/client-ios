//
//  AddressViewController.m
//  iVMS-8700-MCUV2.0
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 HikVision. All rights reserved.
//

#import "AddressViewController.h"
#import "Mcu_sdk/MCUVmsNetSDK.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

#pragma mark =====UIViewController life cycle=====
- (void)viewDidLoad {
    [self initUI];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _addressField.text = [defaults stringForKey:MSP_ADDRESS];
    _portField.text = [defaults stringForKey:MSP_PORT];
    if ([@"" isEqualToString:_portField.text]) {
        _portField.text = DEFAULT_MSP_PORT;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tapGesture];
    [super viewDidLoad];
}

#pragma mark =====initUI=====
-(void)initUI{
    self.title = @"设置";
    self.view.backgroundColor = backGroundColor;
    //外部轮廓设置
    _fieldView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 100)];
    [_fieldView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_fieldView];
    
    //分割线设置
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/3, _fieldView.frame.size.height/2, _fieldView.frame.size.width, 1)];
    _lineView.backgroundColor = CELL_SEPARATOR_COLOR;
    [_fieldView addSubview:_lineView];
    
    //label设置
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CELL_LEFTDISTANCE, 0, 60, _fieldView.frame.size.height/2)];
    _addressLabel.font = [UIFont systemFontOfSize:SIZE15];
    _addressLabel.text = @"地址";
    _addressLabel.textAlignment = NSTextAlignmentRight;
    [_fieldView addSubview:_addressLabel];
    _portLabel = [[UILabel alloc]initWithFrame:CGRectMake(CELL_LEFTDISTANCE, _fieldView.frame.size.height/2, 60, _fieldView.frame.size.height/2)];
    _portLabel.font = [UIFont systemFontOfSize:SIZE15];
    _portLabel.text = @"端口";
    _portLabel.textAlignment = NSTextAlignmentRight;
    [_fieldView addSubview:_portLabel];
    
    //field设置
    _addressField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/3, 0,ScreenWidth*2/3, _fieldView.frame.size.height/2)];
    _addressField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressField.font = [UIFont systemFontOfSize:SIZE14];
    _addressField.textColor = [UIColor grayColor];
    _addressField.delegate = self;
    _addressField.returnKeyType = UIReturnKeyNext;
    _addressField.tag = 2000;
    _addressField.keyboardType = UIKeyboardTypeAlphabet;
    _addressField.placeholder = @"请输入服务器地址";
    [_addressField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_fieldView addSubview:_addressField];
    _portField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/3, _fieldView.frame.size.height/2, ScreenWidth*2/3, _fieldView.frame.size.height/2)];
    _portField.font = [UIFont systemFontOfSize:SIZE14];
    _portField.textColor = [UIColor grayColor];
    _portField.delegate = self;
    _portField.keyboardType = UIKeyboardTypeNumberPad;
    _portField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _portField.placeholder= @"请输入端口号";
    [_portField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_fieldView addSubview:_portField];
    
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"address_save"] forState:UIControlStateNormal];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"address_save_sel"] forState:UIControlStateHighlighted];
    [saveButton.titleLabel setFont:[UIFont systemFontOfSize:SIZE14]];
    saveButton.layer.cornerRadius = 2.0f;
    [saveButton setTitle:@"确定" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_portField.mas_bottom).with.offset(56 * SCREEN_HEIGHT_SCALE);
        make.size.mas_equalTo(CGSizeMake(280, 44));
    }];
}

#pragma mark --TextField响应事件
//限制textfield的输入长度
-(void)textFieldDidChange:(UITextField *)textField{
    if (textField.text.length > ALLOWMAXLENGTH) {
        textField.text = [textField.text substringToIndex:ALLOWMAXLENGTH];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 2000) {
        [_portField becomeFirstResponder];
    }
    return YES;
}

#pragma mark =====event response=====
/**
 *  保存按钮点击事件
 */
-(void)saveAddress{
    [_addressField resignFirstResponder];
    [_portField resignFirstResponder];
    NSString *address = [_addressField.text stringByReplacingOccurrencesOfString:@" " withString:@""];;
    NSString *port = [_portField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ((![address isEqualToString:@""] && address != nil) || (!([port isEqualToString:@""] && (port != nil)))) {
        if ([self isNumText:[address stringByReplacingOccurrencesOfString:@"." withString:@"1"]]) {
            if (![self isRightIP:address]) {
                UIAlertView *ipAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的服务器地址或端口号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [ipAlert show];
                return;
            }
        }
        if (![self isRightPort:port]) {
            UIAlertView *ipAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的服务器地址或端口号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [ipAlert show];
            return;
        }
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:address forKey:MSP_ADDRESS];
        [userDefault setObject:port forKey:MSP_PORT];
        [userDefault synchronize];
        
        //输入完成之后,调用初始化msp的IP与端口,来配置登录平台所需的地址和端口号
        [[MCUVmsNetSDK shareInstance] configMspWithAddress:address port:port];
       // [self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的服务器地址或端口号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

//单击手势
- (void)tapClick{
    [_addressField resignFirstResponder];
    [_portField resignFirstResponder];
}

#pragma mark - private method
/**
 *  判断是否是纯数字
 *
 *  @param str
 *
 *  @return
 */
-(BOOL)isNumText:(NSString *)str{
    NSString *regex = @"(^[0-9]*$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark --判断是否是ip地址
-(BOOL)isRightIP:(NSString *)ipStr{
    NSString *regex = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:ipStr];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark --判断是否是端口号
-(BOOL)isRightPort:(NSString *)portStr{
    NSString *regex = @"^([1-9]|[1-9]\\d{1,3}|[1-6][0-5][0-5][0-3][0-5])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:portStr];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark =====overwrite=====
-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

@end
