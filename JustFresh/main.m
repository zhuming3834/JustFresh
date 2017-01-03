//
//  main.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [OneAPM startWithApplicationToken: @ "70C97597FEE7DEEB67F3AC3B1004313E50"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
