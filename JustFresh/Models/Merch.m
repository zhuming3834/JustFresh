//
//  Merch.m
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "Merch.h"


@implementation Merch

- (instancetype)initModelWithDice:(NSDictionary *)dic{
    if (self = [super init]) {
        self.status = dic[@"status"];
        self.msg = dic[@"msg"];
        self.data = [[NSMutableArray alloc] init];
        NSArray *data = dic[@"data"];
        if (data.count > 0) {
            for (NSDictionary *dice in data) {
                [self.data addObject:[[Shop alloc] initDataWithDice:dice]];
            }
        }
    }
    return self;
}


@end
