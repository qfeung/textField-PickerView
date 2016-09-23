//
//  AddressAddController.h
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/10.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressTableCellModel.h"

@interface AddressAddController : UIViewController

// 反向传值block
@property(nonatomic, copy) void(^addNewAddress)(AddressTableCellModel *);

@end
