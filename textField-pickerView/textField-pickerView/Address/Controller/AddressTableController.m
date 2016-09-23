//
//  AddressTableController.m
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/9.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "AddressTableController.h"
#import "AddressTableCell.h"
#import "Masonry.h"
#import "AddressTableCellModel.h"
#import "AddressEditTableController.h"

@interface AddressTableController ()

@end

@implementation AddressTableController

// cell上'edit按钮'的点击事件
- (IBAction)editClick:(id)sender {
    
    // create toVC
    AddressEditTableController *toVC = [[AddressEditTableController alloc] initWithStyle:UITableViewStyleGrouped];
    // 获取'edit按钮'所在的cell
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    // 获取cell的indexPath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    toVC.model = _dataSourceArrM[indexPath.row];
    toVC.indexRow = indexPath.row;
    [toVC setSaveBlock:^(AddressTableCellModel *model) {
        _dataSourceArrM[indexPath.row] = model;
        [self.tableView reloadData];
    }];
    [toVC setDeleteBlock:^(NSUInteger indexRow) {
        [_dataSourceArrM removeObjectAtIndex:indexRow];
        [self.tableView reloadData];
    }];
    // 跳转
    [self.navigationController pushViewController:toVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];

    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressTableCell" bundle:nil] forCellReuseIdentifier:@"reuse_id_AddressTableCell"];
    // 初始化数据源数组
    _dataSourceArrM = [NSMutableArray array];
    
    // 加载数据
    _dataSourceArrM = [self loadData];
    
}

// 解析数据
- (NSMutableArray*)loadData
{
    // 1.获取文件路径
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"userAddress" withExtension:@"plist"];
    // 2.创建临时数组
    NSArray* tempArr = [[NSArray alloc] initWithContentsOfURL:url];
    // 3.初始化可变数组
    NSMutableArray* mArr = [NSMutableArray array];
    // 4.遍历临时数组
    for (NSDictionary* dict in tempArr) {
        // 5.字典转模型
        AddressTableCellModel* model = [AddressTableCellModel modelWithDict:dict];
        // 6.放入可变数组
        [mArr addObject:model];
    }
    // 7.返回
    return mArr;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSourceArrM.count;
}

- (AddressTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 到缓存池中找
    AddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse_id_AddressTableCell" forIndexPath:indexPath];
    
    AddressTableCellModel *model = _dataSourceArrM[indexPath.row];
    // Configure the cell...
    cell.nameLabel.text = model.name;
    cell.numberLabel.text = model.number;
    cell.addressLabel.text = [[model.city stringByAppendingString:model.region] stringByAppendingString:model.address];
    
    return cell;
}
// cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue = %@",segue);
}

@end
