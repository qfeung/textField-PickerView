//
//  AddressEditTableController.h
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/9.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressTableCellModel.h"

@interface AddressEditTableController : UITableViewController

// 模型数据
@property(nonatomic,strong)AddressTableCellModel *model;
// 记录是哪一行
@property(nonatomic,assign)NSUInteger indexRow;

@property(nonatomic, copy) void (^saveBlock)(AddressTableCellModel *);

@property(nonatomic, copy) void (^deleteBlock)(NSUInteger);

@end
