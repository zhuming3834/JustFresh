//
//  JFPay.h
//  JustFresh
//
//  Created by JF on 2016/12/29.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  支付宝支付相关
 */
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Product.h"

/**
 *  微信支付相关
 */

#include "WXApi.h"

typedef NS_ENUM(NSInteger, JFPayStatus) {
    /**
     *  支付宝支付成功
     */
    AlipayStatusSuccess  = 9000,
    /**
     *  支付宝支付中
     */
    AlipayStatusDoing = 8000,
    /**
     *  支付宝支付失败
     */
    AlipayStatusFail = 4000,
    /**
     *  支付宝用户中途取消
     */
    AlipayStatusCancel = 6001,
    /**
     *  支付宝网络链接错误
     */
    AlipayStatusNetError = 6002,
    
    /**
     *  微信支付成功
     */
    WXPayStatusSuccess = 0,
    
    WXPayStatusErrCodeCommon = -1,
    
    WXPayStatusErrCodeUserCancel = -2,
    
    WXPayStatusErrCodeSentFail = -3,
    
    WXPayStatusErrCodeAuthDeny = -4,
    
    WXPayStatusErrCodeUnsupport = -5,
};

/**
 *  支付宝支付的回调
 *
 *  @param payStatus 支付结果状态
 *  @param resultDic 结果集
 */
typedef void(^AlipayCallBack)(JFPayStatus payStatus,NSDictionary *resultDic);
/**
 *  微信支付的回调
 *
 *  @param payStatus 支付后的状态码
 */
typedef void(^WXpayCallBack)(JFPayStatus payStatus);

@interface JFPay : NSObject

/**
 *  支付单例
 *
 *  @return return value description
 */
+ (JFPay *)shareJFPay;

/**
 *  支付宝支付
 *
 *  @param product             产品数据模型
 *  @param alipayCallBackBlock 支付回调
 */
+ (void)JFPayWithAlipay:(Product *)product AlipayCallBack:(AlipayCallBack)alipayCallBackBlock;

/**
 *  微信支付
 *
 *  @param wxPayCallBackBlock 支付回调
 */
+ (void)JFPayWithWXPayCallBack:(WXpayCallBack)wxPayCallBackBlock;


/**
 *  使用控件的控制器
 */
@property (nonatomic,strong)UIViewController *viewController;
/**
 *  银联支付成功 从AppDelegate里面回调获取的url
 */
@property (nonatomic,strong)NSURL *callBackURL;

@end
