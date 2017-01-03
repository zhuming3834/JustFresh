//
//  JFNetworkConfig.h
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#ifndef JFNetworkConfig_h
#define JFNetworkConfig_h

// 接口地址
#define BASE_URL  @"http://b.app.ydm01.com/ydmappweb"
// 图片上传接口
#define IMAGE_UPLOAD @"图片上传接口"

// 接口拼接  http://服务器地址/接口名
#define JFURLString(INTERFACE_NAME)  [NSString stringWithFormat:@"%@/%@",BASE_URL,INTERFACE_NAME]

// 测试接口
#define GETMER_TEST  @"getMerchantListByPhone.do"


#endif /* JFNetworkConfig_h */
