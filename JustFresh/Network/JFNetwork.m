//
//  JFNetwork.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFNetwork.h"

@implementation JFNetwork



/**
 GET网络请求

 @param urlString 接口
 @param params 参数
 @param neterror 网络错误
 @param netstart 请求开始
 @param success 请求成功
 @param fail 请求失败
 */
+ (void)getWithURLString:(NSString *)urlString parameters:(NSDictionary *)params neterror:(void (^)())neterror   netstart:(void (^)())netstart success:(void (^)(id json))success fail:(void (^)(NSError *error))fail{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        JFLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        // 网络不可用
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            neterror();
        }else{ // 网络可用
            // 网络请求开始
            netstart();
            // 开启风火轮
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
            manage.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manage GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                JFLog(@"服务器返回成功：\n%@",task.response);
                success(json);
                // 关闭风火轮
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                JFLog(@"服务器返回失败：\n%@",task.response);
                fail(error);
                // 关闭风火轮
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            }];
        }

    }];
}
/**
 POST网络请求
 
 @param urlString 接口
 @param params 参数
 @param neterror 网络错误
 @param netstart 请求开始
 @param success 请求成功
 @param fail 请求失败
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)params neterror:(void (^)())neterror   netstart:(void (^)())netstart success:(void (^)(id json))success fail:(void (^)(NSError *error))fail{
   
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        JFLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        // 网络不可用
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            neterror();
        }else{ // 网络可用
            // 网络请求开始
            netstart();
            // 开启风火轮
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
            manage.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manage POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                JFLog(@"服务器返回成功：\n%@",task.response);
                success(json);
                // 关闭风火轮
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                JFLog(@"服务器返回失败：\n%@",task.response);
                fail(error);
                // 关闭风火轮
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            }];
        }
        
    }];
}

/**
 上传单张图片

 @param image 图片对象
 @param neterror 网络错误
 @param netstart 请求开始
 @param success 上传成功
 @param fail 上传失败
 */
+ (void)uploadImage:(UIImage *)image neterror:(void (^)())neterror   netstart:(void (^)())netstart success:(void (^)(id json))success fail:(void (^)(NSError *error))fail{
    // 图片压缩
    NSData *imageData = UIImageJPEGRepresentation(image, 0.01);
    UIImage *newImage = [UIImage imageWithData:imageData];
    // 图片尺寸 200*200
    UIImage *newImage2 = [JFTools scaleToSize:newImage size:CGSizeMake(200, 200)];
    NSData *newImageData = UIImageJPEGRepresentation(newImage2, 1);
    // 参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"用户ID" forKey:@"userid"];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        JFLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        // 网络不可用
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            neterror();
        }else{ // 网络可用
            // 网络请求开始
            netstart();
            // 开启风火轮
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
            manage.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manage POST:@"图片上传地址" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:newImageData name:@"服务器文件夹名字" fileName:@"图片名字.jpg" mimeType:@"image/jpeg"];
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                JFLog(@"服务器返回成功：\n%@",task.response);
                success(json);
                // 关闭风火轮
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                JFLog(@"服务器返回失败：\n%@",task.response);
                fail(error);
                // 关闭风火轮
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            }];
        }
        
    }];
}
/**
 上传多张图片
 
 @param imageArray 图片对象集合
 @param neterror 网络错误
 @param netstart 请求开始
 @param success 上传成功
 @param fail 上传失败
 */
+ (void)uploadImages:(NSArray *)imageArray neterror:(void (^)())neterror   netstart:(void (^)())netstart success:(void (^)(id json))success fail:(void (^)(NSError *error))fail{
    // 参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"用户ID" forKey:@"userid"];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        JFLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        // 网络不可用
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            neterror();
        }else{ // 网络可用
            // 网络请求开始
            netstart();
            // 开启风火轮
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
            manage.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manage POST:@"图片上传地址" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                for (int i = 0;i < imageArray.count;i ++) {
                    UIImage *image = imageArray[i];
                    // 图片压缩
                    NSData *imageData = UIImageJPEGRepresentation(image, 0.01);
                    UIImage *newImage = [UIImage imageWithData:imageData];
                    // 图片尺寸 200*200
                    UIImage *newImage2 = [JFTools scaleToSize:newImage size:CGSizeMake(200, 200)];
                    NSData *newImageData = UIImageJPEGRepresentation(newImage2, 1);
                    [formData appendPartWithFileData:newImageData name:@"服务器文件夹名字" fileName:@"图片名字.jpg" mimeType:@"image/jpeg"];
                }
                
                
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                JFLog(@"服务器返回成功：\n%@",task.response);
                success(json);
                // 关闭风火轮
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                JFLog(@"服务器返回失败：\n%@",task.response);
                fail(error);
                // 关闭风火轮
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            }];
        }
        
    }];
}

@end
