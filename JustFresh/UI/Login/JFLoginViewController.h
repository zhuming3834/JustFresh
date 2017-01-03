//
//  JFLoginViewController.h
//  JustFresh
//
//  Created by hgdq on 2016/12/29.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFBaseViewController.h"

@protocol JFLoginDelegate <NSObject>

/**
 登录成功的代理
 */
- (void)jfLoginSuccess;

@end


typedef NS_ENUM(NSInteger, JFLoginType) {
    JFLoginType_Normal = 0,
    JFLoginType_Parent,
    JFLoginType_Root,
};

@interface JFLoginViewController : JFBaseViewController

@property (nonatomic,assign)id<JFLoginDelegate>delegate;

@property (nonatomic,assign)JFLoginType loginType;

// 用户没有登录就跳转到登录的VC
// 用户登录了就 return 跳出这个方法
+ (void)login:(UIViewController *)ctrl loginType:(JFLoginType)loginType;

@end
