//
//  CityListVC.m
//  GongRongCredits
//
//  Created by 王旭 on 2018/3/15.
//

#import "CityListVC.h"

@interface CityListVC ()<HttpRequestCommDelegate>

@end

@implementation CityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setTableConfig
{
    
}
-(void)requestCityList
{
    
}
-(void)httpRequestSuccessComm:(NSInteger)tagId withInParams:(id)inParam
{
    
}
-(void)httpRequestFailueComm:(NSInteger)tagId withInParams:(NSString *)error
{
    
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
