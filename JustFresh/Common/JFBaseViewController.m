//
//  JFBaseViewController.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFBaseViewController.h"

@interface JFBaseViewController ()

@property (nonatomic,strong)JGProgressHUD *HUD;

@end

@implementation JFBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_keyBoardBool) {
        _keyBoardGesture = [[UIGestureRecognizer alloc] init];
        _keyBoardGesture.delegate = self;
        [self.view addGestureRecognizer:_keyBoardGesture];
    }
    [self setNavBackBtn];
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark 设置导航栏左边按钮
- (void)setNavBackBtn {
    UIImage *image = [UIImage imageNamed:@"btn-back"];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 30);
//    backBtn.backgroundColor = [UIColor yellowColor];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 加载Loading 框  不带文本信息

/**
 显示showLoading框
 */
- (void)showLoading {
    self.HUD = [JFMessageManager showLoadingInView:self.view];
}

/**
 取消显示showLoading框
 */
- (void)dismissLoading {
    [self.HUD dismissAfterDelay: 0.5];
}




#pragma  -mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [self hiddenKeyboard];
    return NO;
}
#pragma  -mark hiddenKeyboard
/**
 *  隐藏键盘，子类需继承；
 *[_tfAccount resignFirstResponder];
 */
- (void)hiddenKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
