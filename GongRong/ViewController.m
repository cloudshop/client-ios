//
//  ViewController.m
//  GongRong
//
//  Created by 王旭 on 2018/1/5.
//

#import "ViewController.h"

//#import <FrameworkTest/TestVC.h>


@interface ViewController ()

    @property (strong, nonatomic)  UIView *playView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *pushBT=[UIButton buttonWithType:UIButtonTypeCustom];
    pushBT.frame=Rect(100, 100, 40, 30);
    pushBT.backgroundColor=[UIColor redColor];
    [pushBT addTarget:self action:@selector(pushTestVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBT];
    
}
-(void)pushTestVC
{
//    TestVC *test=[[TestVC alloc]init];
//    [self presentViewController:test animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
