//
//  AddressController.m
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/9.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "AddressController.h"
#import "AddressTableController.h"
#import "Masonry.h"
#import "AddressAddController.h"
#import "AddressAddTableController.h"

@interface AddressController ()

@end

@implementation AddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];

    // 加载tableView
    [self loadTableView];

    // 加载底部白色视图
    [self loadBottomView];

}

// 设置导航栏
- (void)setupNav {
    // 导航条导致的下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 导航栏标题
    self.navigationItem.title = @"我的收货地址";
    // 导航栏返回按钮
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"v2_goback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(dismissClick)];
    self.navigationItem.leftBarButtonItem = returnButtonItem;
}

// 加载tableView
- (void)loadTableView {
    AddressTableController *addressTableVC = [[AddressTableController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:addressTableVC.tableView];
    // 控制器建立父子关系
    [self addChildViewController:addressTableVC];
    [addressTableVC didMoveToParentViewController:self];
    
    [addressTableVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.offset(64);
    }];
}

// 加载底部白色视图
- (void)loadBottomView {
    // create底部白色视图
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithRed:254/255.0 green:143/255.0 blue:52/255.0 alpha:1];
    
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(44);
        make.left.bottom.right.equalTo(self.view);
    }];
    // 白色视图上的Btn
    UIButton *addAddressBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    addAddressBtn.contentMode = UIViewContentModeScaleToFill;
    [bottomView addSubview:addAddressBtn];
    
    addAddressBtn.backgroundColor = [UIColor colorWithRed:254/255.0 green:143/255.0 blue:52/255.0 alpha:1];
    
//    UIImage *normalImage = [UIImage imageNamed:@"v2_coupon_verify_normal@2x"];
//    CGSize normalImageSize = normalImage.size;
//    normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(normalImageSize.height*.6, normalImageSize.width*.4, normalImageSize.height*.4, normalImageSize.width*.6)];
//    
//    [addAddressBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
//    
//    UIImage *selectedImage = [UIImage imageNamed:@"v2_coupon_verify_selected@2x"];
//    CGSize selectedImageSize = normalImage.size;
//    selectedImage = [selectedImage resizableImageWithCapInsets:UIEdgeInsetsMake(selectedImageSize.height*.6, selectedImageSize.width*.4, selectedImageSize.height*.4, selectedImageSize.width*.6)];
//    [addAddressBtn setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.right.offset(-50);
        make.top.offset(12);
        make.bottom.offset(-12);
    }];
    // 按钮的标题
    [addAddressBtn setTitle:@"+ 新增地址" forState:UIControlStateNormal];
    addAddressBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [addAddressBtn addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 跳转到'添加新地址'界面
- (void)addAddressBtnClick {
    // toVC
    AddressAddController *aAddVC = [[AddressAddController alloc] init];
    
    // 反向传值block赋值
    [aAddVC setAddNewAddress:^(AddressTableCellModel *newModel) {
        // 获取子控制器
        AddressTableController *adrTableVC = [self.childViewControllers firstObject];
        [adrTableVC.dataSourceArrM addObject:newModel];
        // 刷新列表
        [adrTableVC.tableView reloadData];
    }];
    
    [self.navigationController pushViewController:aAddVC animated:YES];
}

@end
