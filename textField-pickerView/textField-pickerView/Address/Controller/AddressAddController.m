//
//  AddressAddController.m
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/10.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "AddressAddController.h"
#import "AddressAddTableController.h"
#import "Masonry.h"
#import "AddressEditNormalTableCell.h"
#import "AddressTableCellModel.h"
#import "AddressEditSelectTableCell.h"


@interface AddressAddController () 

@property(nonatomic,weak)AddressAddTableController *ADTableVC;

// 本页生成的模型数组
@property(nonatomic, strong)AddressTableCellModel *adrModel;

@end

@implementation AddressAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setupNav];
    // 加载tableVC
    [self loadAddressAddTableView];
    



}

//- (void)viewDidAppear:(BOOL)animated {
//    // 获取cell
//    AddressEditNormalTableCell *cell = [self.ADTableVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//    // 获取textField
//    UITextField *cityTField = cell.secfield;
//    cityTField.inputView = self.pickerView;
//    cityTField.inputAccessoryView = self.pickerView;
//
//}

// 设置导航栏
- (void)setupNav {
    // 标题
    self.navigationItem.title = @"修改地址";
    // 渲染颜色
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    // 右侧保存按钮
    UIBarButtonItem *saveBBItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    self.navigationItem.rightBarButtonItem = saveBBItem;
    // 左侧返回按钮
    UIBarButtonItem *backBBItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"v2_goback"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = backBBItem;
}
// 加载addressAddTableVC
- (void)loadAddressAddTableView {
    // create
    AddressAddTableController *addressAddTableVC = [[AddressAddTableController alloc] initWithStyle:UITableViewStyleGrouped];
    // 传递数据 ------ 把自己传给子视图
    addressAddTableVC.addressAddVC = self;
    
    // Constraint
    [self.view addSubview:addressAddTableVC.tableView];
    [addressAddTableVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
    // 控制器建立父子关系
    [self addChildViewController:addressAddTableVC];
    [addressAddTableVC didMoveToParentViewController:self];
    // upload global
    self.ADTableVC = addressAddTableVC;
    
    
}




#pragma mark - 导航栏按钮的点击事件

- (void)saveClick {
    
    // 收集数据
    
    AddressAddTableController* adrAddTableVC = [self.childViewControllers firstObject];
    
    AddressEditNormalTableCell *cell_0 = [adrAddTableVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    AddressEditSelectTableCell *cell_1 = [adrAddTableVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    AddressEditNormalTableCell *cell_2 = [adrAddTableVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    AddressEditNormalTableCell *cell_3 = [adrAddTableVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    AddressEditNormalTableCell *cell_4 = [adrAddTableVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    AddressEditNormalTableCell *cell_5 = [adrAddTableVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    
    // 初始化模型
    self.adrModel = [[AddressTableCellModel alloc] init];
    
    self.adrModel.name = cell_0.secfield.text;
    self.adrModel.isMan = cell_1.sexRecord;
    self.adrModel.number = cell_2.secfield.text;
    self.adrModel.city = cell_3.secfield.text;
    self.adrModel.region = cell_4.secfield.text;
    self.adrModel.address = cell_5.secfield.text;
    
    // 反向传值
    self.addNewAddress(self.adrModel);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
