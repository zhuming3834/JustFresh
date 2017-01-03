//
//  JFBaiduMap.h
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

typedef NS_ENUM(NSInteger, JFMapType)
{
    JFMapType_Location = 0, // 定位
    JFMapType_POISearch, // POI搜索
};

@interface JFBaiduMap : NSObject


/**
 定位获取的位置信息

 @param result 位置信息
 */
typedef void(^LocationCallBackBlock)(BMKAddressComponent *result);

/**
 周边POI搜索

 @param poiInfoLists 结果信息列表  BMKPoiInfo
 */
typedef void(^PoiSearchCallBackBlock)(NSArray *poiInfoLists);


+ (instancetype)shareInstance;
- (void)configBaiduMapAK;

/**
 地图服务
 
 @param jfmaptype 定位还是POI
 @param locCallBackBlock 定位成功的回调
 @param keyword POI 关键字
 @param poiCallBackBlock POI成功的回调
 */
- (void)bmkMapServiceJFMapType:(JFMapType)jfmaptype locationCallBackBlock:(LocationCallBackBlock)locCallBackBlock poiKeyword:(NSString *)keyword poiSearchCallBackBlock:(PoiSearchCallBackBlock)poiCallBackBlock;

/**
 移除地图服务
 */
- (void)removeJfMap;

@end
