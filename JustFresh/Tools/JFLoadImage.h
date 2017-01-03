//
//  JFLoadImage.h
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFLoadImage : NSObject


/**
 加载固定替代图的图片
 
 @param url 图片地址
 @param imageView 需要加载图片的imageView
 */
+ (void)loadImageFromURL:(NSString *)url imageView:(UIImageView *)imageView;
/**
 加载任意替代图的图片
 
 @param url 图片地址
 @param image 替代图
 @param imageView 需要加载图片的imageView
 */
+ (void)loadImageFromURL:(NSString *)url placeholderImage:(UIImage *)image imageView:(UIImageView *)imageView;

/**
 *  获取缓存大小
 *
 *  @return 缓存大小
 */
+ (CGFloat)getImageCacheSize;

/**
 *  清理缓存
 */
+ (void)clearImageCache;
@end
