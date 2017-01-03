//
//  JFLoadImage.m
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFLoadImage.h"
#import "UIImageView+WebCache.h"

@implementation JFLoadImage


/**
 加载固定替代图的图片

 @param url 图片地址
 @param imageView 需要加载图片的imageView
 */
+ (void)loadImageFromURL:(NSString *)url imageView:(UIImageView *)imageView{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"替代图"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
}


/**
 加载任意替代图的图片

 @param url 图片地址
 @param image 替代图
 @param imageView 需要加载图片的imageView
 */
+ (void)loadImageFromURL:(NSString *)url placeholderImage:(UIImage *)image imageView:(UIImageView *)imageView{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

#pragma mark - 获取缓存大小
/**
 *  获取缓存大小
 *
 *  @return 缓存大小
 */
+ (CGFloat)getImageCacheSize{
    CGFloat totalSize = 0;
    //获取图片缓存
    totalSize = [[SDImageCache sharedImageCache] getSize];
    return totalSize/ 1024.0 / 1024.0;
}
#pragma mark - 清除缓存
/**
 *  清理缓存
 */
+ (void)clearImageCache{
    //清除图片缓存
//    [[SDImageCache sharedImageCache] clearDisk];   // 清除Disk
    [[SDImageCache sharedImageCache] clearMemory]; // 清除Memory
}

@end
