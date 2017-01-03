//
//  MessageManager.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFMessageManager.h"

@implementation JFMessageManager


/**
 显示加载的Loading框  不带文字信息

 @param view 需要加载的视图
 @return HUB
 */
+ (JGProgressHUD *) showLoadingInView:(UIView *)view{
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
//    HUD.textLabel.text = @"Loading";
    HUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;// 不允许再次点击
    [HUD showInView:view];
    return HUD;
}

/**
 显示加载的Loading框  带文字信息

 @param view 需要加载的视图
 @param msg 显示的文本信息
 @return HUD
 */
+ (JGProgressHUD *) showLoadingInView:(UIView *)view andMessage:(NSString *)msg{
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = msg;
    HUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;// 不允许再次点击
    [HUD showInView:view];
    return HUD;
}

/**
 显示加载错误的HUD

 @param view 需要加载的视图
 @return HUD
 */
+ (JGProgressHUD *) showErrorHUDInView:(UIView *)view {
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    
    HUD.textLabel.text = @"Error!";
    HUD.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init];
    
    HUD.square = YES;
    
    [HUD showInView: view];
    return HUD;
}


/**
 显示Toast  在视图下面

 @param view 需要显示的视图
 @param msg 提示信息
 */
+ (void)showToastOnBottomCenterInView:(UIView *)view andMessage:(NSString *)msg {
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    
    HUD.indicatorView = nil;
    
    HUD.detailTextLabel.text = msg;
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;// 允许触摸
    HUD.marginInsets = UIEdgeInsetsMake(5, 5, 100, 5);
    HUD.contentInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    HUD.position = JGProgressHUDPositionBottomCenter;
    [HUD showInView:view];
    
    [HUD dismissAfterDelay:2.0];
}
/**
 显示Toast  在视图中间
 
 @param view 需要显示的视图
 @param msg 提示信息
 */
+ (void)showToastOnCenterInView:(UIView *)view andMessage:(NSString *)msg {
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    
    HUD.indicatorView = nil;
    
    HUD.detailTextLabel.text = msg;
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;// 允许触摸
    HUD.marginInsets = UIEdgeInsetsMake(5, 5, 100, 5);
    HUD.contentInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    HUD.position = JGProgressHUDPositionCenter;
    [HUD showInView:view];
    
    [HUD dismissAfterDelay:2.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
