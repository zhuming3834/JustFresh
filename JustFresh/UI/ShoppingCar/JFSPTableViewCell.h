//
//  JFSPTableViewCell.h
//  JustFresh
//
//  Created by hgdq on 2016/12/30.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^clickCars)(UIImageView *goodImage);

@interface JFSPTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (strong , nonatomic)clickCars clickCars;


@end
