//
//  HomeViewController.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "HomeViewController.h"
#include "TextViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [[BaiduMobStat defaultStat] pageviewStartWithName:@"1"];
//}
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear: animated];
//    [[BaiduMobStat defaultStat] pageviewEndWithName:@"1"];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self setButton];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



- (void)setButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick {
    TextViewController *testVC = [[TextViewController alloc] init];
    testVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:testVC animated:YES];
 
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
