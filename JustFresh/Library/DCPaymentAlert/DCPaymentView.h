//
//  DCPaymentView.h
//  DCPayAlertDemo
//
//  Created by dawnnnnn on 15/12/9.
//  Copyright © 2015年 dawnnnnn. All rights reserved.
//  输入支付密码框  仿微信

#import <UIKit/UIKit.h>

@interface DCPaymentView : UIView

@property (nonatomic, copy) NSString *title, *detail;
@property (nonatomic, assign) CGFloat amount;

@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd);

- (void)show;


// 使用：
//- (IBAction)test:(id)sender {
//    DCPaymentView *payAlert = [[DCPaymentView alloc]init];
//    payAlert.title = @"请输入支付密码";
//    payAlert.detail = @"提现";
//    payAlert.amount= 10;
//    [payAlert show];
//    payAlert.completeHandle = ^(NSString *inputPwd) {
//        NSLog(@"密码是%@",inputPwd);
//    };
//}




@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
