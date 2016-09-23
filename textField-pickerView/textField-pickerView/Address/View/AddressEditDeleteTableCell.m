//
//  AddressEditDeleteTableCell.m
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/10.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "AddressEditDeleteTableCell.h"
#import "Masonry.h"

@implementation AddressEditDeleteTableCell

//Style
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupUI];
    }
    return self;
}
//Xib
-(void)awakeFromNib
{
    [self setupUI];
}

-(void)setupUI
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn = deleteBtn;
    
    [deleteBtn setTitle:@"删除当前地址" forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除当前地址" forState:UIControlStateHighlighted];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    
    
    deleteBtn.backgroundColor = [UIColor redColor];
    [deleteBtn.layer setMasksToBounds:YES];
    [deleteBtn.layer setCornerRadius:10];
    [self.contentView addSubview:deleteBtn];
    deleteBtn.center = self.contentView.center;
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(8);
        make.right.bottom.offset(-8);
    }];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
