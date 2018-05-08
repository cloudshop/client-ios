//
//  JGManager.h
//  GongRongCredits
//
//  Created by 王旭 on 2018/3/13.
//

#import <Foundation/Foundation.h>
#pragma mark 极光
// 引入JPush功能所需头文件
#import "JPUSHService.h"
#import "JSHAREService.h"
#import "AppDelegate.h"

@interface JGManager : NSObject<JPUSHRegisterDelegate>

+(instancetype)shareInstance;
//-(void)initWeihAppdelegate:(AppDelegate *)delegate;
-(NSString *)registrationID;
//@property
@end
