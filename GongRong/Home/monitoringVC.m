//
//  monitoringVC.m
//  GongRongPoints
//
//  Created by 王旭 on 2018/8/17.
//

#import "monitoringVC.h"
#import "baseWkWebVC.h"


@interface monitoringVC ()

@property (nonatomic,strong)NSArray *webURLArr;
@end

@implementation monitoringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
}

-(void)initSubViews
{
    for (int i=0; i<3; i++) {
        
    }
    
}
-(void)webBTclicked:(UIButton *)sender
{
    
    baseWkWebVC *vc=[[baseWkWebVC alloc]init];
  
  //  if (showClose) {
        vc.showClose=YES;
 //   }
   
    NSString *  urlStr=[NSString stringWithFormat:@"%@%@",Web_BASEURLPATH,@""];
    
    [vc setUrl:urlStr];
   
    [self.navigationController pushViewController:vc animated:YES];
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
