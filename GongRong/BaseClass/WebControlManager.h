//
//  WebControlManager.h
//  GongRongPoints
//
//  Created by 王旭 on 2018/4/11.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "baseWkWebVC.h"


@interface WebControlManager : NSObject

+(instancetype)shareInstance;

-(void)handelMessageWithController:(baseWkWebVC *)webVC AndMessage:(WKScriptMessage *)message;

@end
