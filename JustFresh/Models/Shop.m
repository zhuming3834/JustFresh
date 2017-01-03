//
//  Shop.m
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "Shop.h"

@implementation Shop

- (instancetype)initDataWithDice:(NSDictionary *)dice{
    if([super init]){
        [self setValuesForKeysWithDictionary:dice];
    }
    return self;
}

@end
