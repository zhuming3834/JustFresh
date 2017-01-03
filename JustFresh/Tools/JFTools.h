//
//  JFTools.h
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>

// 应用程序总代理
#define AppDelegateInstance	     ((AppDelegate*)([UIApplication sharedApplication].delegate))

#pragma mark - 颜色
//设置RGB颜色值
#define RGBAColor(R,G,B,A)	[UIColor colorWithRed:(CGFloat)R/255.0 green:(CGFloat)G/255.0 blue:(CGFloat)B/255.0 alpha:A]
//设置RGB颜色值
#define RGBColor(R,G,B)	[UIColor colorWithRed:(CGFloat)R/255 green:(CGFloat)G/255 blue:(CGFloat)B/255 alpha:1.0]
//RGB转UIColor（不带alpha值）0x
#define UIColorFromRGB(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - 屏幕尺寸
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width


#pragma mark  - 硬件设备相关
// 是否是 iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 是否是 iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断是否iPod touch
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 是否是iPhone4
#define IS_IPHONE4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// 是否是iPhone5或者iPhone5s
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// 是否是iPhone6
#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

// 是否是iPhone6Plus
#define IS_IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)



@interface JFTools : NSObject

/**
 *  图片拉伸
 *
 *  @param imageName 图片名字
 *
 *  @return 返回拉伸后的图片
 */
+ (UIImage *)stretchImageWithImageName:(NSString *)imageName;

/**
 *  计算文本size(主要是高度的计算)
 *
 *  @param string 需要计算的文本
 *  @param width  文本的宽度
 *  @param font   文本的字体
 *
 *  @return 返回计算后的Size
 */
+ (CGSize)heightForString:(NSString *)string width:(CGFloat)width font:(CGFloat)font;


/**
 *  图片设置圆角1
 *
 *  @param cornerRadius 圆角值
 *  @param original     图片
 *
 *  @return 圆角图片
 */
+ (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original;
/**
 *  图片设置圆角2
 *
 *  @param image  需要设置的图片
 *  @param radius 圆角值
 *
 *  @return 圆角图片
 */
+ (UIImage *)makeRoundedImage:(UIImage *) image
                       radius: (float) radius;


/**
 *  改变图片大小 (正方形图片)
 *
 *  @param ciImage 需要改变大小的CIImage 对象的图片
 *  @param size    图片大小 (正方形图片 只需要一个数)
 *
 *  @return 生成的目标图片
 */
+ (UIImage *)changeImageSizeWithCIImage:(CIImage *)ciImage andSize:(CGFloat)size;

/**
 *  等比例压缩图片
 *
 *  @param img  原图片
 *  @param size 目标尺寸
 *
 *  @return 新的图片
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 *  获取父视图控制器
 *
 *  @param view 当前视图
 *
 *  @return return value description
 */
+ (UIViewController*)viewController:(UIView *)view ;

/**
 获取系统当前时间
 eg: 20161228140811
 @return 系统当前时间
 */
+ (NSString *)getCurrentDate;

/**
 *  获取应用当前版本
 *
 *  @return 版本字符串  eg:1.2.0
 */
+ (NSString*) getLocalVer;

@end
