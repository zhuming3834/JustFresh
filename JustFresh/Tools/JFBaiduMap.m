//
//  JFBaiduMap.m
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFBaiduMap.h"

#define BAIDU_MAP_AK     @"hi0Uyebuw4roYyE2CUzTM8OKDjRt5R8A"
#define LOCATION_COUNT   1
#define POI_RADIUS       5000  // POI搜索的半径  单位是米

@interface JFBaiduMap()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate>
{
    BMKMapManager      *_bmkMapManager;
    BMKLocationService *_bmkLocationService; // 定位
    BMKGeoCodeSearch   *_bmkGeoCodeSearch;   // 反向地理编码
    BMKReverseGeoCodeOption *_reverseGeoCodeSearchOption; //
    LocationCallBackBlock    _locationCallBackBlock;  // 定位结果回调
    PoiSearchCallBackBlock   _poiSearchCallBackBlock; // POI搜索的结果回调
    BMKPoiSearch        *_bmkPoiSearch; // 周边POI搜索
    BMKNearbySearchOption    *_bmkNearbySearchOption;  // 附近搜索
    JFMapType           _type;  // 定位还是POI
    NSString            *_keyword; // POI搜索的关键字
}

@end

@implementation JFBaiduMap

+ (instancetype)shareInstance {
    static dispatch_once_t once;
    static JFBaiduMap *mapManager;
    dispatch_once(&once, ^{
        mapManager = [[JFBaiduMap alloc] init];
    });
    return mapManager;
}
// 百度地图配置  注册
- (void)configBaiduMapAK {
    if (_bmkMapManager == nil) {
        _bmkMapManager = [[BMKMapManager alloc] init];
    }
    BOOL ret = [_bmkMapManager start:BAIDU_MAP_AK generalDelegate:nil];
    if (!ret) {
        JFLog(@"百度地图注册失败");
    }
}


/**
 地图服务

 @param jfmaptype 定位还是POI
 @param locCallBackBlock 定位成功的回调
 @param keyword POI 关键字
 @param poiCallBackBlock POI成功的回调
 */
- (void)bmkMapServiceJFMapType:(JFMapType)jfmaptype locationCallBackBlock:(LocationCallBackBlock)locCallBackBlock poiKeyword:(NSString *)keyword poiSearchCallBackBlock:(PoiSearchCallBackBlock)poiCallBackBlock {
    _type = jfmaptype;
    _locationCallBackBlock = locCallBackBlock;
    _poiSearchCallBackBlock = poiCallBackBlock;
    _keyword = keyword;
    if (_bmkLocationService == nil) {
        _bmkLocationService = [[BMKLocationService alloc] init];
    }
    _bmkLocationService.delegate = self;
    [_bmkLocationService startUserLocationService];
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    JFLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    AppDelegateInstance.latitude = userLocation.location.coordinate.latitude;
    AppDelegateInstance.latitude = userLocation.location.coordinate.latitude;
    // 定位 获取单点信息  反向地理编码
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
    if (_bmkGeoCodeSearch == nil) {
        _bmkGeoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        _reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    }
    _bmkGeoCodeSearch.delegate = self;
    _reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_bmkGeoCodeSearch reverseGeoCode:_reverseGeoCodeSearchOption];
    if(flag){
//       JFLog(@"geo检索发送成功");
    }else{
//       JFLog(@"geo检索发送失败");
    }
    if (_type == JFMapType_POISearch) {
        // 获取周边街道信息
        if (_bmkPoiSearch == nil) {
            _bmkPoiSearch = [[BMKPoiSearch alloc] init];
            _bmkNearbySearchOption = [[BMKNearbySearchOption alloc] init];
        }
        _bmkPoiSearch.delegate = self;
        _bmkNearbySearchOption.location = pt;
        _bmkNearbySearchOption.radius = POI_RADIUS; // 周边范围
        if (_keyword == nil) {
            _bmkNearbySearchOption.keyword = @"大厦";
        }else{
            _bmkNearbySearchOption.keyword = _keyword;
        }
        BOOL poiSearchFlag = [_bmkPoiSearch poiSearchNearBy:_bmkNearbySearchOption];
        if(poiSearchFlag){
            NSLog(@"周边检索发送成功");
        }else{
            NSLog(@"周边检索发送失败");
        }
    }
}
#pragma mark - BMKGeoCodeSearchDelegate

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    BMKAddressComponent *com = (BMKAddressComponent *)result.addressDetail;
    AppDelegateInstance.bmkAddressComponent = com;  // 保存位置信息
    _locationCallBackBlock(com);
}
#pragma mark - BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        _poiSearchCallBackBlock(poiResultList.poiInfoList);
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

/**
 移除地图服务
 */
- (void)removeJfMap {
    _bmkLocationService = nil;
    _bmkLocationService.delegate = nil;
    _bmkGeoCodeSearch = nil;
    _bmkGeoCodeSearch.delegate = nil;
    _bmkPoiSearch = nil;
    _bmkPoiSearch.delegate = nil;
    [_bmkLocationService stopUserLocationService];
}
- (void)dealloc{
    _bmkLocationService = nil;
    _bmkLocationService.delegate = nil;
    _bmkGeoCodeSearch = nil;
    _bmkGeoCodeSearch.delegate = nil;
    _bmkPoiSearch = nil;
    _bmkPoiSearch.delegate = nil;
    [_bmkLocationService stopUserLocationService];
}



@end















