//
//  MessageManager.h
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "JGProgressHUD.h"

@interface JFMessageManager : UIView

/**
 显示加载的Loading框  不带文字信息
 
 @param view 需要加载的视图
 @return HUB
 */
+ (JGProgressHUD *) showLoadingInView:(UIView *)view;

/**
 显示加载的Loading框  带文字信息
 
 @param view 需要加载的视图
 @param msg 显示的文本信息
 @return HUD
 */
+ (JGProgressHUD *) showLoadingInView:(UIView *)view andMessage:(NSString *)msg;

/**
 显示加载错误的HUD
 
 @param view 需要加载的视图
 @return HUD
 */
+ (JGProgressHUD *) showErrorHUDInView:(UIView *)view;

/**
 显示Toast  在视图下面
 
 @param view 需要显示的视图
 @param msg 提示信息
 */
+ (void)showToastOnBottomCenterInView:(UIView *)view andMessage:(NSString *)msg;
/**
 显示Toast  在视图中间
 
 @param view 需要显示的视图
 @param msg 提示信息
 */
+ (void)showToastOnCenterInView:(UIView *)view andMessage:(NSString *)msg;

@end
