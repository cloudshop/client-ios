//
//  GRSetPasswordVC.h
//  GongRongPoints
//
//  Created by 王旭 on 2018/3/31.
//

#import "BaseViewController.h"

@interface GRSetPasswordVC : BaseViewController

@property (nonatomic,assign)BOOL isReset;//是否是重新设置密码
@property (nonatomic,strong)NSString *verifyCode;
@property (nonatomic,strong)NSString *phoneNumber;
@end
