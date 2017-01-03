//
//  JFPay.m
//  JFPay
//
//  Created by zhuming on 16/4/8.
//  Copyright © 2016年 zhuming. All rights reserved.
//

#import "JFPay.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#define ALIPAY_PARTNER     @"2088801142678498"
#define ALIPAY_SELLER      @"2088801142678498"
#define ALIPAY_PRIVATEKEY    @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKADO4HcskWfaWCSLSdCqPMWymC2m3paALX6jVjpz/eIFajO/hbOec1IZB8yLImClKTyke9kGy2IwVSt1QNugxx/u6lUEoE6LeO2LKR37YnopdgKxXVITX5Ymn0yJdI3WWFiqfcFXzAHq3D5Il9zfTVRyOTHfRTC05EML7F1hV/1AgMBAAECgYBeUKlxqQk3OngdYOvWeVcmOae+C8RnAMfse6t23hIkAAVsQ93GyZtHocTKEoPn5Z0CAKx+I05Vr4btB61H4YrLga89mbXjP+YoYejNRVoZBjEpkf7NgMh7ScQIhx3hHk2IuCO6syz/cR5zNWpK47gMSWtS3/xoWjX9aicKcsTNgQJBANQd3qZZeo1XTi4qugp8AAvCwsy4IGM1LztahKIll+XMTLHxF6e5WTEQTuRe6fQzfbP7emNX3aAwqLRhgez+hmECQQDBHdOGsuqGQkes1VO9C9zEOegjEgv+Dzxq3Wj8AeVzO4idUJ2Gl6IV4EWflev9kZGX6CXFjJ3RngM6dsoejpoVAkEAj36Rc7mOhXVtZx/ycUtHgK1FuNZK2rJM/HsUxNhntMaLj8kIdqeVpfJhXG61GEWJISvbtL7pKAgi6LwZ9+iLoQJAWO5HTqxt284B+9FxcolX7PVNtXjGFQUnKX80rXiiFWLBEtDg+e4yMijJZyg/ONIkXfQGEOckdjdx/SZfBZtd0QJAPL0+YBO5Bvbb4/VRIeoww+4pAd46f9Ews0a0gYjOrTL+tNomvVet92HgJJQIEIoLbqh4NTDJDFgC8rmh7UBeSg=="


// 微信支付


@interface JFPay ()

/**
 *  支付宝支付的订单
 */
@property (nonatomic,strong)Product *product;

/**
 *  微信支付的回调block
 */
@property (nonatomic,copy)WXpayCallBack wxPayCallBackBlock;
/**
 *  网络请求的数据流
 */
@property (nonatomic,strong)NSMutableData *responseData;

//@property (nonatomic,assign)enum WXScene scene;
@property (nonatomic,copy)NSString *Token;
@property (nonatomic,assign)long token_time;

@end

@implementation JFPay

/**
 *  支付单例
 *
 *  @return return value description
 */
+ (JFPay *)shareJFPay{
    static JFPay *JFPay = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        JFPay = [[self alloc] init];
    });
    return JFPay;
}
#pragma mark - 支付宝支付
/**
 *  支付宝支付
 *
 *  @param product             产品数据模型
 *  @param alipayCallBackBlock 支付回调
 */
+ (void)JFPayWithAlipay:(Product *)product AlipayCallBack:(AlipayCallBack  )alipayCallBackBlock{
    JFPay *jfpay = [[JFPay alloc] init];
    jfpay.product = product;
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = ALIPAY_PARTNER;
    NSString *privateKey = ALIPAY_PRIVATEKEY;
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = ALIPAY_PARTNER;

    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
//    order.biz_content.seller_id = ALIPAY_SELLER; // seller_id

    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式  Y2SBQMIKZ3JMTVV
    if (signedString != nil) {
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"JustFresh";
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSString *resultStatusStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            int resultStatus = resultStatusStr.intValue;
            JFLog(@"resultStatusStr = %@",resultStatusStr);
            JFPayStatus payStatus;
            switch (resultStatus) {
                case 9000:
                    payStatus = AlipayStatusSuccess;
                    break;
                case 8000:
                    payStatus = AlipayStatusDoing;
                    break;
                case 4000:
                    payStatus = AlipayStatusFail;
                    break;
                case 6001:
                    payStatus = AlipayStatusCancel;
                    break;
                case 6002:
                    payStatus = AlipayStatusNetError;
                    break;
                default: payStatus = 2016;
                    break;
            }
            alipayCallBackBlock(payStatus,resultDic);
        }];
    }
}

/**
 *  生成随机的订单号
 *
 *  @return 订单号
 */
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    NSLog(@"订单号 = %@",resultStr);
    return resultStr;
}

#pragma mark - 微信支付
/**
 *  微信支付
 *
 *  @param wxPayCallBackBlock 支付回调
 */
+ (void)JFPayWithWXPayCallBack:(WXpayCallBack)wxPayCallBackBlock{
    JFPay *jfpay = [JFPay shareJFPay];
    [jfpay wxpay];
    jfpay.wxPayCallBackBlock = ^(JFPayStatus payStatus){
        wxPayCallBackBlock(payStatus);
    };
    
}

//微信支付
- (void)wxpay
{
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = @"1220277201";
    request.prepayId = @"82010380001603250865be9c4c063c30";
    request.package = @"Sign=WXPay";
    request.nonceStr= @"lUu5qloVJV7rrJlr";
    request.timeStamp = 1458893985;
    request.sign= @"b640c1a4565b476db096f4d34b8a9e71960b0123";
    [WXApi sendReq: request];
}
/**
 *  微信支付成功回调
 *
 *  @param resp resp description
 */
- (void)onResp:(BaseResp *)resp {
    JFPayStatus payStatus;
    if ([resp isKindOfClass: [PayResp class]]){
        PayResp *response=(PayResp*)resp;
        switch (response.errCode) {
            case WXSuccess:
                payStatus = WXPayStatusSuccess;
                break;
            case WXErrCodeCommon:
                payStatus = WXPayStatusErrCodeCommon;
                break;
            case WXErrCodeUserCancel:
                payStatus = WXPayStatusErrCodeUserCancel;
                break;
            case WXErrCodeSentFail:
                payStatus = WXPayStatusErrCodeSentFail;
                break;
            case WXErrCodeAuthDeny:
                payStatus = WXPayStatusErrCodeAuthDeny;
                break;
            case WXErrCodeUnsupport:
                payStatus = WXPayStatusErrCodeUnsupport;
                break;
            default:
                payStatus = 2016;
                break;
        }
        [JFPay shareJFPay].wxPayCallBackBlock(payStatus);
    }
}

#pragma mark - setCallBackURL
/**
 *  callBackURL的set方法
 *
 *  @param callBackURL 银联支付成功回调
 */
- (void)setCallBackURL:(NSURL *)callBackURL{
    NSLog(@"host = %@",callBackURL.host);
    // 支付宝  不走这个回调
    if ([callBackURL.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:callBackURL standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"回调result = %@",resultDic[@"memo"]);
        }];
    }
//     微信
    else if ([callBackURL.host isEqualToString:@"pay"]){
        id idSelf = self;
        [WXApi handleOpenURL:callBackURL delegate:idSelf];
    }
}


//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}




@end
