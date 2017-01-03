//
//  JFLoginViewController.m
//  JustFresh
//
//  Created by hgdq on 2016/12/29.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFLoginViewController.h"
#import "LoginState.h"
@interface JFLoginViewController ()

@end

@implementation JFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)login:(id)sender {
    [self popBack];
}

- (IBAction)loginout:(id)sender {
}



- (void)popBack{
    if (self.loginType == JFLoginType_Normal) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.loginType == JFLoginType_Parent){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:YES];
//                [self.tabBarController setSelectedIndex:3];
    }
}

+ (void)login:(UIViewController *)ctrl loginType:(JFLoginType)loginType{
    if ([LoginState isLogin]) { // 已经登录了
        return;
    }
    else{ // 没有登录
        JFLoginViewController *LVC = [[JFLoginViewController alloc] init];
        LVC.loginType = loginType;
        if (loginType == JFLoginType_Normal) {
            [ctrl.navigationController pushViewController:LVC animated:YES];
        }
        else if (loginType == JFLoginType_Parent){
            [ctrl presentViewController:LVC animated:YES completion:nil];
        }
        else{
            [ctrl.navigationController pushViewController:LVC animated:YES];
        }
    }
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
