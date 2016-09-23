//
//  AddressEditSelectTableCell.m
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/10.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "AddressEditSelectTableCell.h"

@interface AddressEditSelectTableCell ()





@end

@implementation AddressEditSelectTableCell

- (IBAction)selectManClick:(id)sender {
    [self.manBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    [self.womanBtn setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    self.sexRecord = 0;
}

- (IBAction)selectWomanClick:(id)sender {
    [self.manBtn setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    [self.womanBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    self.sexRecord = 1;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
