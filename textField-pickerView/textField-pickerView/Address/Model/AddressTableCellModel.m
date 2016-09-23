//
//  AddressTableCellModel.m
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/9.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "AddressTableCellModel.h"

@implementation AddressTableCellModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    AddressTableCellModel *model = [[AddressTableCellModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
