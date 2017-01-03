//
//  Merch.h
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shop.h"

@interface Merch : NSObject

@property (nonatomic,copy)NSString *status;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,copy)NSString *msg;

- (instancetype)initModelWithDice:(NSDictionary *)dic;

@end
