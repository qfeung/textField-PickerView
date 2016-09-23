//
//  AddressEditSelectTableCell.h
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/10.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressEditSelectTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property(nonatomic,assign)NSInteger sexRecord;

@end
