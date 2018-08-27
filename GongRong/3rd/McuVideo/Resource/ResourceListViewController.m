//
//  ResourceListViewController.m
//  Mcu_sdk_demo
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 hikvision. All rights reserved.
//

#import "ResourceListViewController.h"
#import "Mcu_sdk/MCUVmsNetSDK.h"
#import "Mcu_sdk/MCUResourceNode.h"
#import "RealPlayViewController.h"
#import "PlayBackViewController.h"

@interface ResourceListViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate
>

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSArray *resourceArray;

@end

@implementation ResourceListViewController

#pragma mark - UIViewController life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self initUI];
    if (_parentNode) {
        //获取组织树节点的子节点资源
        [self requestResource];
    } else {
        //首先要请求获取组织树节点的第一级节点资源
        [self requestRootResource];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - initUI
- (void)initUI {
    self.title = @"资源列表";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    
    UIButton *registButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 24)];
    [registButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [registButton setTitle:@"注销" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc]initWithCustomView:registButton];
    self.navigationItem.rightBarButtonItem = rigthItem;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    MCUResourceNode *node = _resourceArray[indexPath.row];
    [cell.textLabel setText:node.nodeName];
    if (node.nodeType == ResourceNodeTypeRegion || node.nodeType == ResourceNodeTypeControlCenter) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _parentNode = _resourceArray[indexPath.row];
    if (_parentNode.nodeType == ResourceNodeTypeControlCenter || _parentNode.nodeType == ResourceNodeTypeRegion) {//节点为控制中心或区域,点击节点继续请求子节点资源
        ResourceListViewController *list = [[ResourceListViewController alloc]init];
        list.parentNode = _parentNode;
        [self.navigationController pushViewController:list animated:YES];
    }
    else {//节点为监控点,开始准备进行预览或者回放的操作
        [self alertPlayVideoChooseView:indexPath.row];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    } else {
        switch (buttonIndex) {
            case 1: {//预览
                MCUResourceNode *node = _resourceArray[alertView.tag];
                RealPlayViewController *realPlayController = [[RealPlayViewController alloc]init];
                realPlayController.cameraSyscode = node.sysCode;
                [self.navigationController pushViewController:realPlayController animated:YES];
                break;
            }
            case 2: {//回放
                MCUResourceNode *node = _resourceArray[alertView.tag];
                PlayBackViewController *playBackController = [[PlayBackViewController alloc]init];
                playBackController.cameraSyscode = node.sysCode;
                [self.navigationController pushViewController:playBackController animated:YES];
                break;
            }
            case 3: {//详情
                
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark - event response
- (void)regist:(UIButton *)registButton {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要注销吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 100;
    [alertView show];
}

#pragma mark - private method
/**
 *  请求根资源点数据
 */
- (void)requestRootResource {
    //1 代表视频资源
    [[MCUVmsNetSDK shareInstance] requestRootNodeWithSysType:1 success:^(id object) {
        if ([object[@"status"] isEqualToString:@"200"]) {
            _parentNode = object[@"resourceNode"];
            [self requestResource];
        } else {
            [self showDescription:object];
        }
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  请求资源点列表数据
 */
- (void)requestResource {
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[MCUVmsNetSDK shareInstance] requestResourceWithSysType:1 nodeType:_parentNode.nodeType currentID:_parentNode.nodeID numPerPage:100 curPage:1 success:^(id object) {
        [self dismiss];
        if ([object[@"status"] isEqualToString:@"200"]) {
            _resourceArray = object[@"resourceNodes"];
            if (_resourceArray.count > 0) {
                [_tableView reloadData];
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD showErrorWithStatus:@"暂无资源"];
                    [self performSelector:@selector(dismiss) withObject:nil afterDelay:delayTime];
                });
            }
        }
    } failure:^(NSError *error) {
        [self dismiss];
        NSLog(@"requestResource failed");
    }];
}

/**
 *  监控点弹出选择框
 */
- (void)alertPlayVideoChooseView:(NSInteger)row {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请选择" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"预览",@"回放", nil];
    alertView.tag = row;
    [alertView show];
}

- (void)showDescription:(id)object {
    [SVProgressHUD showErrorWithStatus:object[@"description"]];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:delayTime];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

#pragma mark - getter & setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setBackgroundColor:[UIColor whiteColor]];
    }
    return _tableView;
}

@end
