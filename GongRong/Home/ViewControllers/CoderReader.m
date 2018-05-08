//
//  CoderReader.m
//  ZhongYiTrain
//
//  Created by 王旭 on 2017/4/28.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import "CoderReader.h"
#import "SJScanningView.h"
#import "SJCameraViewController.h"
#import "UIAlertView+SJAddtions.h"

#define kIsAuthorizedString @"请在iOS - 设置 － 隐私 － 相机 中打开相机权限"
#define kiOS8 [[UIDevice currentDevice].systemVersion integerValue]

@interface CoderReader ()<SJCameraControllerDelegate,SJScanningViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *preview;
@property (nonatomic, assign)   BOOL   isLoad;
@property (nonatomic, strong) SJScanningView *scanningView;
@property (nonatomic, strong) SJCameraViewController *cameraController;
@property (nonatomic, strong) UIImagePickerController *pickerController;
@end

@implementation CoderReader


- (SJScanningView *)scanningView {
    if (_scanningView == nil) {
        _scanningView = [[SJScanningView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _scanningView.scanningDelegate = self;
    }
    return _scanningView;
}

- (UIView *)preview {
    if (!_preview) {
        _preview = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _preview;
}

- (SJCameraViewController *)cameraController {
    if (!_cameraController) {
        _cameraController = [[SJCameraViewController alloc] init];
        _cameraController.delegate = self;
    }
    return _cameraController;
}

- (UIImagePickerController *)pickerController {
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _pickerController.delegate = self;
        _pickerController.allowsEditing = NO;
    }
    return _pickerController;
}

#pragma mark - Life Cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewNaviBar.hidden=YES;
    self.isLoad = YES;
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    if ([self isCameraIsAuthorized]) {
        if (self.isLoad == YES) {
            [self setupView];
        }
    } else {
      //  UIAlertView *alert  =  [UIAlertView alertViewTitle:@"相机权限提示" message:kIsAuthorizedString  delegate:self cancelButtonTitle:@"知道了"];
     //   alert.tag = 1;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相机权限提示"
                                                                                 message:kIsAuthorizedString
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [self.navigationController popViewControllerAnimated:YES];

                                                          }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:^(UIAlertAction *action){
                                                                      //completionHandler(NO);
                                                                    [self.navigationController popViewControllerAnimated:YES];
                                                                  }]];
        
        [self presentViewController:alertController animated:YES completion:^{}];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.cameraController = nil;
    self.preview = nil;
    self.scanningView = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - SetUp View

/** 建立视图 */
- (void)setupView {
    [self.scanningView scanning];
    [self.view addSubview:self.preview];
    [self.view addSubview:self.scanningView];
    [self.cameraController showCaptureOnView:self.preview];
    
}

#pragma mark - The Camera is Authorized

/** 是否授权 */
- (BOOL)isCameraIsAuthorized {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusDenied){
        return NO;
    } else if (authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    }
    return YES;
}

#pragma mark - SJScanningViewDelegate BarBUttonItem 点击事件

/** 按钮的点击事件 */
- (void)clickBarButtonItemSJButtonType:(SJButtonType)type {
    if (type == SJButtonTypeReturn) {
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (type == SJButtonTypeTorch) {
        [self setTorchMode];
    } else if (type == SJButtonTypeAlbum) {
        [self openImagePickerController];
    }
}

#pragma mark - Configuration Torch

/** 配置手电筒 */
- (void)setTorchMode {
    if ([self.cameraController cameraHasTorch]) {
        [self configurationTorch];
    } else {
     //   [UIAlertView alertViewTitle:@"温馨提示！" message:@"您的闪光灯无法开启，请检查" delegate:self cancelButtonTitle:@"知道了"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                 message:@"您的闪光灯无法开启"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                             
                                                          }]];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
//                                                            style:UIAlertActionStyleCancel
//                                                          handler:^(UIAlertAction *action){
//                                                              completionHandler(NO);
//                                                          }]];
        
        [self presentViewController:alertController animated:YES completion:^{}];
    }
}

#pragma mark - Torch Click


- (void)configurationTorch {
    UIButton *button = [self.scanningView viewWithTag:SJButtonTypeTorch];
    button.selected = !button.selected;
    if (button.selected) {
        [self.cameraController setTorchMode:AVCaptureTorchModeOn];
    } else {
        [self.cameraController setTorchMode:AVCaptureTorchModeOff];
    }
}

#pragma mark - Open imagePickController

/** 打开相册 */
- (void)openImagePickerController {
    [self presentViewController:self.pickerController animated:YES completion:nil];
}

#pragma mark - SJCameraControllerDelegate

/** codesString 扫描二维码返回的结果 */
- (void)didDetectCodes:(NSString *)codesString {
    [self.scanningView removeScanningAnimations];
    if (self.successBlock) {
        self.successBlock(codesString);
    }
    else{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
//    HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
//    [dic setObject:codesString forKey:@"content"];
//    [request initRequestComm:dic withURL:Push_Sign operationTag:PushSign];
//    [SVProgressHUD show];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)httpRequestSuccessComm:(NSInteger)tagId withInParams:(id)inParam
{
    [SVProgressHUD dismiss];
    BaseResponse *resp=[[BaseResponse alloc]init];
    [resp setHeadData:inParam];
    if (resp.code==0) {
        [self showToast:@"签到成功!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self showToast:resp.message];
        
    }
}
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *)error
{
    [SVProgressHUD dismiss];
    [self showToast:@"签到失败,稍后再试"];
   }
#pragma mark - UIImagePickerControllerDelegate

/** alertMessageString 读取相册中二维码相册的结果*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info; {
    UIImage *pickerImage= [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *resultString = nil;
    if (kiOS8 >= 8.0) {
        resultString = [self.cameraController readAlbumQRCodeImage:pickerImage];
        if (self.successBlock) {
            self.successBlock(resultString);
        }
        else{
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            
            HttpBaseRequest *request=[[HttpBaseRequest alloc] initWithDelegate:self];
            [dic setObject:resultString forKey:@"content"];
            [request initRequestComm:dic withURL:Push_Sign operationTag:PushSign];
            [SVProgressHUD show];
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        //self.isLoad = NO;
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - StatusBarStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [self.cameraController stopSession];
    self.cameraController = nil;
    self.preview = nil;
    self.scanningView = nil;
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
