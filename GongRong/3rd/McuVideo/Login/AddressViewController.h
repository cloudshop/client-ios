//
//  AddressViewController.h
//  iVMS-8700-MCUV2.0
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 HikVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<UITextFieldDelegate>
{
    UIView      *_fieldView;//外部轮廓
    UIView      *_lineView;//中间线条
    UILabel     *_addressLabel;
    UILabel     *_portLabel;
    UITextField *_addressField;
    UITextField *_portField;
}
@end
