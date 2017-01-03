//
//  Shop.h
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (nonatomic,copy)NSString *TELPHONE;
@property (nonatomic,strong)NSNumber *ADMIN;
@property (nonatomic,copy)NSString *NAME;
@property (nonatomic,copy)NSString *FULL_NAME;
@property (nonatomic,copy)NSString *PASSWORD;
@property (nonatomic,copy)NSString *LOGIN_NAME;
@property (nonatomic,strong)NSNumber *MERCHANT_ID;


- (instancetype)initDataWithDice:(NSDictionary *)dice;

@end
