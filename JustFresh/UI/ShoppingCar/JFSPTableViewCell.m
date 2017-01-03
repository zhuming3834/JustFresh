//
//  JFSPTableViewCell.m
//  JustFresh
//
//  Created by hgdq on 2016/12/30.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFSPTableViewCell.h"

@implementation JFSPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)buyBtnClick:(UIButton *)sender {
    if (_clickCars) {
        _clickCars(_goodsImageView);
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
