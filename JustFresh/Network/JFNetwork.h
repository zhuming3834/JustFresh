//
//  JFNetwork.h
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "AFNetworking.h"

@interface JFNetwork : NSObject

/**
 GET网络请求
 
 @param urlString 接口
 @param params 参数
 @param neterror 网络错误
 @param netstart 请求开始
 @param success 请求成功
 @param fail 请求失败
 */
+ (void)getWithURLString:(NSString *)urlString parameters:(NSDictionary *)params neterror:(void (^)())neterror   netstart:(void (^)())netstart success:(void (^)(id json))success fail:(void (^)(NSError *error))fail;

/**
 POST网络请求
 
 @param urlString 接口
 @param params 参数
 @param neterror 网络错误
 @param netstart 请求开始
 @param success 请求成功
 @param fail 请求失败
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)params neterror:(void (^)())neterror   netstart:(void (^)())netstart success:(void (^)(id json))success fail:(void (^)(NSError *error))fail;

@end
