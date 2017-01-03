//
//  JFBaseViewController.h
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFBaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic,strong)UIGestureRecognizer *keyBoardGesture;

/**
 *  是否未控制器添加消失键盘事件
 *  必须在继承父类 viewDidLoad方法之前调用
 *  默认开启
 */
@property (nonatomic)    BOOL keyBoardBool;

/**
 显示showLoading框
 */
- (void)showLoading;
/**
 取消显示showLoading框
 */
- (void)dismissLoading;


/**
 *  隐藏键盘
 */
- (void)hiddenKeyboard;


@end
