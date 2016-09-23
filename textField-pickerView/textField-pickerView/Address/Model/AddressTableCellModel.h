//
//  AddressTableCellModel.h
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/9.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressTableCellModel : NSObject

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *number;

@property(nonatomic, copy) NSString *city;

@property(nonatomic, copy) NSString *region;

@property(nonatomic, copy) NSString *address;

@property(nonatomic,assign)NSInteger isMan;

// 字典转模型方法
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
