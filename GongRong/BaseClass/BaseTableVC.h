//
//  BaseTableVC.h
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"
#import "BaseResponse.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@interface BaseTableVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, readonly) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger  currentPage;

//应对两个tableview的情况
@property (nonatomic, strong, readonly) UITableView *secondTableView;
@property (nonatomic,strong)NSMutableArray *secondDataArr;
@property (nonatomic,assign)NSInteger secondPage;


- (instancetype)initWithStyle:(UITableViewStyle)style;
//初始化无内容cell
-(UITableViewCell *)creatEmptyCellWithIMGName:(NSString *)imgName AndTitle:(NSString *)title;

-(void)endAllRefresh;

#pragma mark 第一个table
//For header and footer and overide by subclass
- (void)beginToReloadDataForHeader;
- (void)beginToReloadDataForFooter;
- (void)finishUpdateData;
//将请求获取到的数据传给刷新方法 定向刷新某一组或者某一个table
- (void)finishUpdateDataWithData:(NSMutableArray *)dataEle AndTag:(NSInteger)tag AndResponse:(BaseResponse *)resp;

//添加头尾部
-(void)addheader;
-(void)addFooter;



-(void)removeHeadView;
-(void)removeFooterView;

- (void)setFooterViewNew;
-(void)setFooterViewClolr:(UIColor *)color;


#pragma mark 第二个table
//For header and footer and overide by subclass
- (void)beginToReloadDataForHeader_secondTBV;
- (void)beginToReloadDataForFooter_secondTBV;
- (void)finishUpdateData_secondTBV;
//将请求获取到的数据传给刷新方法 定向刷新某一组或者某一个table
- (void)finishUpdate_secondTBVDataWithData:(NSMutableArray *)dataEle AndTag:(NSInteger)tag AndResponse:(BaseResponse *)resp;

//添加头尾部
-(void)addheader_secondTBV;
-(void)addFooter_secondTBV;



-(void)removeHeadView_secondTBV;
-(void)removeFooterView_secondTBV;

- (void)setFooterViewNew_secondTBV;
-(void)setFooterViewClolr_secondTBV:(UIColor *)color;


- (void)showToast:(NSString *) msg;
@end
