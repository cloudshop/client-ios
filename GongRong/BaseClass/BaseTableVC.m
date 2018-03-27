//
//  BaseTableVC.m
//  ZhongYiTrain
//
//  Created by 王旭 on 17/3/2.
//  Copyright © 2017年 ZhongYi. All rights reserved.
//

#import "BaseTableVC.h"
#import "WGPublicData.h"


#define RECT_MainTableView                   Rect(0.0f, NaviBarHeight + StatusBarHeight,ScreenWidth , (ScreenHeight - NaviBarHeight - StatusBarHeight /*- TopScrollViewHeight*/ - TabBarHeight))


@interface BaseTableVC ()

@property (nonatomic, readonly) UITableViewStyle style;
@end

@implementation BaseTableVC

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        _style = style;
    }
    
    return self;
}

-(id)init
{
    self = [super init];
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (self)
    {
        [WGPublicData sharedInstance].currentViewController=self;
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBtwUiResources];
    self.view.backgroundColor=kAppColorBackground;
}
- (void)setBtwUiResources
{
    [self setMainTableViewResource];
    [self setHeaderAndFooter];
}

- (void)setMainTableViewResource
{
    if (SYSTEM_VERSION >= 7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _mainTableView = [[UITableView alloc] initWithFrame:RECT_MainTableView];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor=kAppColorBackground;
    [self.view addSubview:_mainTableView];
    _currentPage=0;
    _dataArray = [[NSMutableArray alloc]init];
    
    
    _secondTableView = [[UITableView alloc] initWithFrame:RECT_MainTableView];
    _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondTableView.backgroundColor=kAppColorBackground;
    [self.view addSubview:_secondTableView];
    _secondTableView.hidden=YES;
    _secondPage=0;
    _secondDataArr = [[NSMutableArray alloc]init];
    
}
/*addObject后的array其实是变了，可能内存变大了,你可以理解成这个对象已经不是原来的了，就相当于没有定义一个具体实例对象一样。但通过@synthesize 默认的setter不能保证copy就一定等于mutableCopy；所以我们需要自定义自己的setter方法*/
-(void)setDataArray:(NSMutableArray *)dataArray
{
    if(_dataArray != nil)
    {
        _dataArray = nil;
    }
    _dataArray = [dataArray mutableCopy];
}

-(void)setSecondDataArr:(NSMutableArray *)secondDataArr
{
    if (_secondDataArr!=nil) {
        _secondDataArr=nil;
    }
    _secondDataArr=[secondDataArr mutableCopy];
}
-(void)setHeaderAndFooter
{
    [self addheader];
    [self addFooter];
    [self addheader_secondTBV];
    [self addFooter_secondTBV];
}
-(void)endAllRefresh
{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    [self.secondTableView.mj_header endRefreshing];
    [self.secondTableView.mj_footer endRefreshing];
}

#pragma mark 第一个tbale
//添加头尾部
-(void)addheader
{
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       // [self loadStatus:self.button.tag];
        [self beginToReloadDataForHeader];
    }];
    
}
-(void)addFooter
{
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
      //  page++;
      //  NSLog(@"%ld",(long)page);
      //  [self addMoreStatus:page:self.button.tag];
        [self beginToReloadDataForFooter];
    }];
}



-(void)removeHeadView
{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_header removeFromSuperview];
}
-(void)removeFooterView
{
    [self.mainTableView.mj_footer endRefreshing];
    [self.mainTableView.mj_footer removeFromSuperview];
}

- (void)setFooterViewNew
{
    //    UIEdgeInsets test = self.aoView.contentInset;
    // if the footerView is nil, then create it, reset the position of the footer
    if (!self.mainTableView.mj_footer)
    {
        self.mainTableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            [self beginToReloadDataForFooter];
        }];
                             
       // _mainTableView.tableFooterView = _refreshFooterView;
    }
    
    if (self.mainTableView.mj_footer)
    {
       // [_refreshFooterView refreshLastUpdatedDate];
    }
}
-(void)setFooterViewClolr:(UIColor *)color
{
    self.mainTableView.mj_footer.backgroundColor=color;
}



#pragma mark - For Overide Functions

- (void)beginToReloadDataForHeader
{
    // overide by subclass and use to reload data for header
}

- (void)beginToReloadDataForFooter
{
    // overide by subclass and use to reload data for footer
}

- (void)finishUpdateData
{
    // overide by subclass and finish reload data for header
}
//将请求获取到的数据传给刷新方法 定向刷新某一组或者某一个table 
- (void)finishUpdateDataWithData:(NSMutableArray *)dataEle AndTag:(NSInteger)tag AndResponse:(BaseResponse *)resp;
{
    // overide by subclass and finish reload data for header
}

#pragma mark 第二个tbale
//添加头尾部
-(void)addheader_secondTBV
{
    self.secondTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // [self loadStatus:self.button.tag];
        [self beginToReloadDataForHeader_secondTBV];
    }];
    
}
-(void)addFooter_secondTBV
{
    self.secondTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        //  page++;
        //  NSLog(@"%ld",(long)page);
        //  [self addMoreStatus:page:self.button.tag];
        [self beginToReloadDataForFooter_secondTBV];
    }];
}



-(void)removeHeadView_secondTBV
{
    [self.secondTableView.mj_header endRefreshing];
    [self.secondTableView.mj_header removeFromSuperview];
}
-(void)removeFooterView_secondTBV
{
    [self.secondTableView.mj_footer endRefreshing];
    [self.secondTableView.mj_footer removeFromSuperview];
}

- (void)setFooterViewNew_secondTBV
{
    //    UIEdgeInsets test = self.aoView.contentInset;
    // if the footerView is nil, then create it, reset the position of the footer
    if (!self.secondTableView.mj_footer)
    {
        self.secondTableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            [self beginToReloadDataForFooter_secondTBV];
        }];
        
        // _mainTableView.tableFooterView = _refreshFooterView;
    }
    
    if (self.secondTableView.mj_footer)
    {
        // [_refreshFooterView refreshLastUpdatedDate];
    }
}
-(void)setFooterViewClolr_secondTBV:(UIColor *)color
{
    self.secondTableView.mj_footer.backgroundColor=color;
}



#pragma mark - For Overide Functions

- (void)beginToReloadDataForHeader_secondTBV
{
    // overide by subclass and use to reload data for header
}

- (void)beginToReloadDataForFooter_secondTBV
{
    // overide by subclass and use to reload data for footer
}

- (void)finishUpdateData_secondTBV
{
    // overide by subclass and finish reload data for header
}
//将请求获取到的数据传给刷新方法 定向刷新某一组或者某一个table
-(void)finishUpdate_secondTBVDataWithData:(NSMutableArray *)dataEle AndTag:(NSInteger)tag AndResponse:(BaseResponse *)resp
{
    // overide by subclass and finish reload data for header
}



- (void)reloadEmptyView
{
    //Later will show empty view if no data
}





-(UITableViewCell *)creatEmptyCellWithIMGName:(NSString *)imgName AndTitle:(NSString *)title
{
    if (![ConUtils checkUserNetwork]) {
        imgName=@"nonetwork";
        title=@"网络连接异常，请检查网络";
    }
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.backgroundColor=RGB(246, 246, 246);
    UIImageView *imgView=[[UIImageView alloc]initWithImageNamed:imgName];
    imgView.size=Size(140, 110);
    imgView.top=35;
    imgView.centerX=ScreenWidth/2;
    [cell.contentView addSubview:imgView];
    UILabel *titleLB=[[UILabel alloc]initWithFrame:Rect(0, imgView.bottom+27, ScreenWidth, 14.5)];
    titleLB.textColor=UIColorWithHex(0x9b9b9b);
    titleLB.font=[UIFont systemFontOfSize:14];
    titleLB.text=title;
    titleLB.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:titleLB];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
/*
 * 显示用户信息提示框
 */
- (void)showToast:(NSString *) msg
{
    if([msg isEqualToString:NO_DATA_TEXT])
    {
        return;
    }
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 5 ;
    view.tag = 600 ;
    CGFloat width = [ConUtils labelWidth:msg withFont:[UIFont systemFontOfSize:15]];
    view.frame = CGRectMake(0, 0, width+30, 50);
    view.backgroundColor = [UIColor blackColor];
    //view.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+150);
    //    view.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-TabBarHeight-NaviBarHeight-view.frame.size.height-view.frame.size.height/2-20);
    view.center = CGPointMake(ScreenWidth/2, ScreenHeight-TabBarHeight-view.frame.size.height-10);
    
    UILabel *msgLa = [[UILabel alloc] init];
    msgLa.frame = CGRectMake(0, 0, width+30, 50) ;
    msgLa.text = msg ;
    msgLa.textAlignment = NSTextAlignmentCenter ;
    msgLa.font = [ConUtils boldAndSizeFont:15];
    msgLa.backgroundColor = [UIColor clearColor];
    msgLa.textColor = INFO_TEXT_COLOR;
    [view addSubview:msgLa];
    [[[UIApplication sharedApplication].delegate window] addSubview:view];
    
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dismissToastView) userInfo:nil repeats:NO];
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void)
     {
         [view setAlpha:0.6];
     }completion:^(BOOL finished)
     {
         [view removeFromSuperview];
     }];
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
